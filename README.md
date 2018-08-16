# PermissionManager

## 0. demo效果图

![demo](https://github.com/WangWei1993/PermissionManager/blob/master/permission.gif)

## 1. CocoaPods

```c
pod 'PermissionManager'
```


## 2. 支持的权限类型
```swift
/// Permission Types
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
```


## 3. 使用方法

** 权限管理者接口 **
```swift
public protocol PermissionManagerProtocol {

    /// 判断权限是否处于未决定状态
    static func isNotDetermined(_ permission: RequestPermissionType) -> Bool
    
    /// 判断权限是否处于拒绝状态
    static func isRestrictOrDenied(_ permission: RequestPermissionType) -> Bool
        
    /// 判断权限是否处于允许状态
    static func isAuthorized(_ permission: RequestPermissionType) -> Bool
    
    /// 请求一个权限
    static func request(_ permission: RequestPermissionType, _ complectionHandler: @escaping PermissionClosure)
}
```


**相机权限**
```swift

PermissionsManager.request(.camera) { bool in
    // bool, 异步回调
    // true: 用户允许， false： 用户拒绝
}

// 相机权限是不是处于允许状态
let isAuthorized = PermissionsManager.isAuthorized(.camera)

// 相册权限-没有权限或者拒绝
let isRestrictOrDenied = PermissionsManager.isRestrictOrDenied(.camera)

// 相机权限是不是处于未决定状态
let isNotDetermined = PermissionsManager.isNotDetermined(.camera)

```

**推送权限**
```swift

PermissionsManager.request(.notification) { bool in
    // bool, 异步回调
    // true: 用户允许， false： 用户拒绝
}

// 推送权限是不是处于允许状态
let isAuthorized = PermissionsManager.isAuthorized(.notification)

// 推送权限-没有权限或者拒绝
let isRestrictOrDenied = PermissionsManager.isRestrictOrDenied(.notification)

// 推送权限是不是处于未决定状态
let isNotDetermined = PermissionsManager.isNotDetermined(.notification)

```
## 4. 注意事项

> **位置权限**注意事项：
在iOS11之后，Privacy - Location Always Usage Description被降级为Privacy - Location When In Use Usage Description。
新添加Privacy - Location Always and When In Use Usage Description隐私权限，在使用后台定位的时候进行操作：Targets - Capabilities - Background Modes - location Update 这一项打钩。
> **推送权限**注意事项：
推送权限在iOS10之后才包含notDetermined、authorized、authorized这三种状态，所以iOS10之前默认都会返回false。

** 如果有问题或者有更好的设计方案，请不要羞涩的issues我，会尽快回复 **
** 邮件：15000686094@163.com **
** 如果对你有帮助，请不要羞涩的给star吧 **

