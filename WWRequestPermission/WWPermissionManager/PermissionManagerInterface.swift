//
//  PermissionManagerInterface.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2018/4/5.
//  Copyright © 2018年 王伟. All rights reserved.
//

import Foundation

/// 权限管理者接口
public protocol PermissionManagerInterface {
    
    /**
     用户还未决定
     param: permission 权限类型
     */
    func isNotDetermined(_ permission: RequestPermissionType) -> Bool
    
    /**
     用户没有权限或者拒绝
     param: permission 权限类型
     */
    func isRestrictOrDenied(_ permission: RequestPermissionType) -> Bool
    
    /**
     用户允许
     param: permission 权限类型
     */
    func isAuthorized(_ permission: RequestPermissionType) -> Bool
    
    /**
     用户请求权限
     param: permission 权限类型
     */
    func request(_ permission: RequestPermissionType, with complectionHandler: @escaping ()->())
}
