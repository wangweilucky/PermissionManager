# PermissionManager
APP权限管理类

1. 支持的权限类型
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
2. 基本使用：

```swift
    /**
     此权限用户决定？
     param: permission 权限类型
     */
    func isNotDetermined(_ permission: WWRequestPermissionType) -> Bool
    
    /**
     此权限用户否决？
     param: permission 权限类型
     */
    func isRestrictOrDenied(_ permission: WWRequestPermissionType) -> Bool
    
    /**
     此权限用户同意？
     param: permission 权限类型
     */
    func isAuthorized(_ permission: WWRequestPermissionType) -> Bool
    
    /**
     请求此权限
     param: permission 权限类型
     */
    func request(_ permission: WWRequestPermissionType, with complectionHandler: @escaping ()->())
    
```
