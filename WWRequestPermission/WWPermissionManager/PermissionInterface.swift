//
//  PermissionInterface.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2018/4/5.
//  Copyright © 2018年 王伟. All rights reserved.
//

import Foundation

/// 各个权限接口
public protocol PermissionInterface {
    
    func isNotDetermined() -> Bool
    
    func isAuthorized() -> Bool
    
    func isRestrictOrDenied() -> Bool
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ())
}
