//
//  RequestPermission.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2017/12/20.
//  Copyright © 2017年 王伟. All rights reserved.
//

import UIKit

/// 权限类型
public enum RequestPermissionType {
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

public class PermissionsManager: NSObject, PermissionManagerInterface {

    public func isNotDetermined(_ permission: RequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isNotDetermined()
    }
    
    public func isRestrictOrDenied(_ permission: RequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isRestrictOrDenied()
    }

    public func isAuthorized(_ permission: RequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isAuthorized()
    }
   
    public func request(_ permission: RequestPermissionType, with complectionHandler: @escaping () -> ()) {
        return getManagerForPermission(permission).request(withComplectionHandler: {
            complectionHandler()
        })
    }
}

extension PermissionsManager {
    
    private func getManagerForPermission(_ permission: RequestPermissionType) -> PermissionInterface {
        
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
}
