//
//  WWRequestPermissionLocationHandler.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2017/12/27.
//  Copyright © 2017年 王伟. All rights reserved.
//

import Foundation
import MapKit

/*
 kCLAuthorizationStatusNotDetermined                  //用户尚未对该应用程序作出选择
 kCLAuthorizationStatusRestricted                     //应用程序的定位权限被限制
 kCLAuthorizationStatusAuthorizedAlways               //允许一直获取定位
 kCLAuthorizationStatusAuthorizedWhenInUse            //在使用时允许获取定位
 kCLAuthorizationStatusAuthorized                     //已废弃，相当于一直允许获取定位
 kCLAuthorizationStatusDenied                         //拒绝获取定位
 */

typealias PermissionLocationClosure = (Bool) ->Void

protocol WWRequestPermissionLocationProtocol {}

extension WWRequestPermissionLocationProtocol{
    func isNotDetermined() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .notDetermined
    }
    
    func isRestrictOrDenied() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .restricted || status == .denied
    }
}

// 获取定位状态
private var status: CLAuthorizationStatus {
    let status = CLLocationManager.authorizationStatus()
    return status
}

class PermissionAlwaysLocationHandler
: NSObject
, CLLocationManagerDelegate
, WWRequestPermissionLocationProtocol {
    
    static var share = PermissionAlwaysLocationHandler()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    var complectionHandler: PermissionLocationClosure?
    
    private var whenInUseNotRealChangeStatus: Bool = false
    
    func request(_ complectionHandler: @escaping PermissionLocationClosure) {
        
        self.complectionHandler = complectionHandler
        
        switch status {
        case .notDetermined, .authorizedWhenInUse:
           locationManager.delegate = self
           locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            complectionHandler(false)
        case .authorizedAlways:
            complectionHandler(isAuthorized())
        }
    }
    
    func isAuthorized() -> Bool {
        if #available(iOS 8.0, *) {
            if status == .authorizedAlways {
                return true
            } else {
                return false
            }
        } else {
            if status == .authorized {
                return true
            } else {
                return false
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        if let complectionHandler = complectionHandler {
            complectionHandler(isAuthorized())
        }
    }
    
    deinit {
        locationManager.delegate = nil
    }
}

class PermissionWhenInUseLocationHandler
: NSObject
, CLLocationManagerDelegate
, WWRequestPermissionLocationProtocol {
    
    static var share = PermissionWhenInUseLocationHandler()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    var complectionHandler: PermissionLocationClosure?
    
    private var whenInUseNotRealChangeStatus: Bool = false
    
    // notDetermined restricted denied authorizedAlways authorizedWhenInUse authorized
    func request(_ complectionHandler: @escaping PermissionLocationClosure) {
        
        self.complectionHandler = complectionHandler
    
        switch status {
        case .notDetermined , .authorizedAlways:
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            complectionHandler(false)
            
        case .authorizedWhenInUse:
            complectionHandler(isAuthorized())
        }
    }
    
    func isAuthorized() -> Bool {
        if #available(iOS 8.0, *) {
            if status == .authorizedWhenInUse {
                return true
            } else {
                return false
            }
        } else {
            if status == .authorized {
                return true
            } else {
                return false
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .notDetermined { return }
        
        if let complectionHandler = complectionHandler {
            complectionHandler(isAuthorized())
        }
    }
    
    deinit {
        locationManager.delegate = nil
    }
}

class PermissionLocationWithBackgroundHandler: PermissionAlwaysLocationHandler {
   
    override func request(_ complectionHandler: @escaping PermissionLocationClosure)
    {
        // iOS9.0以上系统除了配置info之外，还需要添加这行代码，才能实现后台定位，否则程序会crash
        if #available(iOS 9.0, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        }
        super.request(complectionHandler)
    }
    
}

