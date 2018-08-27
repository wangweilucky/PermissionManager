//
//  WWLog.swift
//  WWRequestPermission
//
//  Created by 王大吉 on 27/8/18.
//  Copyright © 2018年 王伟. All rights reserved.
//

import Foundation

func WWlog<T>(type:T,
            file: String = #file,
            method: String = #function ,
            line: Int = #line) {
    
    var message = ""
    #if DEBUG
    message = "\((file as NSString).lastPathComponent)[\(line)], \(method), \(type)"
    print(message)
    #endif
    
}

func WWgetLog<T>(type:T,
               file: String = #file,
               method: String = #function ,
               line: Int = #line) -> String {
    
    var message = ""
    #if DEBUG
    message = "\((file as NSString).lastPathComponent)[\(line)], \(method), \(type)"
    #endif
    return message
}
