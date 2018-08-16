//
//  PermissionProtocol+Extension.swift
//  WWRequestPermission
//
//  Created by 王大吉 on 15/8/18.
//  Copyright © 2018年 王伟. All rights reserved.
//

import Foundation

// 实现请求接口
public extension PermissionRequestProtocol {
    
    static func request(_ permission: RequestPermissionType, _ complectionHandler: @escaping PermissionClosure) {
        return getManagerForPermission(permission).request { bool in
            complectionHandler(bool)
        }
    }
    
}

// 实现状态获取接口
public extension PermissionStatusProtocol {
    
    static func isNotDetermined(_ permission: RequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isNotDetermined()
    }
    
    static func isRestrictOrDenied(_ permission: RequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isRestrictOrDenied()
    }
    
    static func isAuthorized(_ permission: RequestPermissionType) -> Bool {
        return getManagerForPermission(permission).isAuthorized()
    }
}

// 公共方法
fileprivate func getManagerForPermission(_ permission: RequestPermissionType) -> PermissionProtocol {
    
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
