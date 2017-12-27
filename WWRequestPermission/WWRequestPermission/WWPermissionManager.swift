//
//  RequestPermission.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2017/12/20.
//  Copyright © 2017年 王伟. All rights reserved.
//

import UIKit

/// 权限类型
public enum WWRequestPermissionType {
    case camera
    case photoLibrary
    case notification
    case microphone
    case locationAlways
    case locationWhenInUse
    case locationWithBackground
    case contacts
    case reminders
    case calendar
}

class WWPermissionsManager: WWPermissionManagerInterface {
    
    func isNotDetermined(_ permission: WWRequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isNotDetermined()
    }
    
    func isRestrictOrDenied(_ permission: WWRequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isRestrictOrDenied()
    }

    func isAuthorized(_ permission: WWRequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isAuthorized()
    }
   
    func request(_ permission: WWRequestPermissionType, with complectionHandler: @escaping () -> ()) {
        return getManagerForPermission(permission).request(withComplectionHandler: {
            complectionHandler()
        })
    }
    
    // jumpSetting
    public class func jumpSetting() {
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!,
                                       options: [:],
                                       completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
        }
    }
    
    private func getManagerForPermission(_ permission: WWRequestPermissionType) -> WWPermissionInterface {
        
        // 分别获取各个权限
        switch permission {
        case .camera:
            return WWCameraPermission()
        case .photoLibrary:
            return WWPhotoLibraryPermission()
        case .notification:
            return WWNotificationPermission()
        case .microphone:
            return WWMicrophonePermission()
        case .locationWhenInUse:
            return WWLocationPermission(type: .WhenInUse)
        case .locationAlways:
            return WWLocationPermission(type: .Always)
        case .locationWithBackground:
            return WWLocationPermission(type: .AlwaysWithBackground)
        case .calendar:
            return WWCalendarPermission()
        case .contacts:
            return WWContactsPermission()
        case .reminders:
            return WWRemindersPermission()
        }
    }
}


/// 权限管理者接口
public protocol WWPermissionManagerInterface {
    
    func isNotDetermined(_ permission: WWRequestPermissionType) -> Bool
    
    func isRestrictOrDenied(_ permission: WWRequestPermissionType) -> Bool
    
    func isAuthorized(_ permission: WWRequestPermissionType) -> Bool
    
    func request(_ permission: WWRequestPermissionType, with complectionHandler: @escaping ()->())
}


/// 各个权限接口
public protocol WWPermissionInterface {
    
    func isNotDetermined() -> Bool
    
    func isAuthorized() -> Bool
    
    func isRestrictOrDenied() -> Bool
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ())
}

