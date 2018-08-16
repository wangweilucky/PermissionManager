//
//  PermissionManagerInterface.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2018/4/5.
//  Copyright © 2018年 王伟. All rights reserved.
//

import Foundation

public protocol PermissionManagerProtocol : PermissionRequestProtocol, PermissionStatusProtocol {}


public typealias PermissionClosure = (Bool)->()


// 请求接口
public protocol PermissionRequestProtocol {
    
    /**
     用户请求权限
     param: permission 权限类型
     */
    static func request(_ permission: RequestPermissionType, _ complectionHandler: @escaping PermissionClosure)
}


// 状态接口
public protocol PermissionStatusProtocol {

    /**
     用户还未决定
     param: permission 权限类型
     */
    static func isNotDetermined(_ permission: RequestPermissionType) -> Bool
    
    /**
     用户没有权限或者拒绝
     param: permission 权限类型
     */
    static func isRestrictOrDenied(_ permission: RequestPermissionType) -> Bool
    
    /**
     用户允许
     param: permission 权限类型
     */
    static func isAuthorized(_ permission: RequestPermissionType) -> Bool
}

