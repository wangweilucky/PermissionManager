# PermissionManager
APP权限管理类

***支持的权限类型***
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



####基本方法介绍：

```swift
/// 权限管理者接口
public protocol WWPermissionManagerInterface {
    
    /**
     用户还未决定
     param: permission 权限类型
     */
    func isNotDetermined(_ permission: WWRequestPermissionType) -> Bool
    
    /**
     用户没有权限或者拒绝
     param: permission 权限类型

     */
    func isRestrictOrDenied(_ permission: WWRequestPermissionType) -> Bool
    
    /**
     用户允许
     param: permission 权限类型
     */
    func isAuthorized(_ permission: WWRequestPermissionType) -> Bool
    
    /**
     用户请求权限
     param: permission 权限类型
     */
    func request(_ permission: WWRequestPermissionType, with complectionHandler: @escaping ()->())
}
```

####使用方法：
```swift

// 请求相册权限(异步)
WWPermissionsManager().request(.photoLibrary, with: {
    print("申请了相册权限")
})

// 相册权限-还未决定
WWPermissionsManager().isNotDetermined(.photoLibrary) {
    print("用户还没有决定")
}

// 相册权限-允许
WWPermissionsManager().isAuthorized(.photoLibrary) {
    print("用户允许")
}

// 相册权限-没有权限或者拒绝
WWPermissionsManager().isRestrictOrDenied(.photoLibrary) {
    print("用户没有权限或者拒绝")
}

```
