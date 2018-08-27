//
//  PermissionInterface.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2018/4/5.
//  Copyright © 2018年 王伟. All rights reserved.
//

import Foundation

/// 各个权限接口
protocol PermissionProtocol {
    
//    associatedtype T
//    
//    var status: T {get}
    
    func request(complectionHandler: @escaping  PermissionClosure)
    
    func isNotDetermined() -> Bool
    
    func isAuthorized() -> Bool
    
    func isRestrictOrDenied() -> Bool
    
}

