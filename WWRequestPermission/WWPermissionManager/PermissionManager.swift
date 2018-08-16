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

public struct PermissionsManager{}

extension PermissionsManager: PermissionManagerProtocol {}

extension PermissionsManager {
    
    // jumpSetting
    public static func jumpSetting() {
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!,
                                      options: [:],
                                      completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
        }
    }
}
