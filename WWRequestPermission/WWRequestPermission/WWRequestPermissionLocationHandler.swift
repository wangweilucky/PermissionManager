//
//  WWRequestPermissionLocationHandler.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2017/12/27.
//  Copyright © 2017年 王伟. All rights reserved.
//

import Foundation
import MapKit

class WWRequestPermissionAlwaysAuthorizationLocationHandler: NSObject, CLLocationManagerDelegate {
    func isNotDetermined() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .notDetermined
    }
    
    func isRestrictOrDenied() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .restricted || status == .denied
    }
    
    static var share: WWRequestPermissionAlwaysAuthorizationLocationHandler?
    
    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    var complectionHandler: WWRequestPermissionAuthorizationHandlerCompletionBlock?
    
    private var whenInUseNotRealChangeStatus: Bool = false
    
    func request(_ complectionHandler: @escaping WWRequestPermissionAuthorizationHandlerCompletionBlock) {
        
        self.complectionHandler = complectionHandler
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            whenInUseNotRealChangeStatus = true
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
        default:
            complectionHandler(isAuthorized())
        }
    }
    
    func isAuthorized() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways {
            return true
        }
        return false
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if whenInUseNotRealChangeStatus {
            if status == .authorizedWhenInUse {return}
        }
        
        if status == .notDetermined {return}
        
        if let complectionHandler = complectionHandler {
            complectionHandler(isAuthorized())
        }
    }
    
    deinit {
        locationManager.delegate = nil
    }
}

class WWRequestPermissionWhenInUseAuthorizationLocationHandler: NSObject, CLLocationManagerDelegate {
    
    static var share: WWRequestPermissionWhenInUseAuthorizationLocationHandler?
    
    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    var complectionHandler: WWRequestPermissionAuthorizationHandlerCompletionBlock?
    
    private var whenInUseNotRealChangeStatus: Bool = false
    
    func request(_ complectionHandler: @escaping WWRequestPermissionAuthorizationHandlerCompletionBlock) {
        
        self.complectionHandler = complectionHandler
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined || status == .authorizedAlways {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        } else {
             complectionHandler(isAuthorized())
        }
    }
    
    func isAuthorized() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            return true
        }
        return false
    }
    
    func isNotDetermined() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .notDetermined
    }
    
    func isRestrictOrDenied() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .restricted || status == .denied
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .notDetermined {
            return
        }
        
        if let complectionHandler = complectionHandler {
            complectionHandler(isAuthorized())
        }
    }
    
    deinit {
        locationManager.delegate = nil
    }
}

class WWRequestPermissionLocationWithBackgroundHandler: WWRequestPermissionAlwaysAuthorizationLocationHandler {
    override func request(_ complectionHandler: @escaping WWRequestPermissionAlwaysAuthorizationLocationHandler.WWRequestPermissionAuthorizationHandlerCompletionBlock) {
        if #available(iOS 9.0, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        }
        super.request(complectionHandler)
    }
    
}

extension WWRequestPermissionAlwaysAuthorizationLocationHandler {
    typealias WWRequestPermissionAuthorizationHandlerCompletionBlock = (Bool) ->Void
}

extension WWRequestPermissionWhenInUseAuthorizationLocationHandler {
    typealias WWRequestPermissionAuthorizationHandlerCompletionBlock = (Bool) ->Void
}
