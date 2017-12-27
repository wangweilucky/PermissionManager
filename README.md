# PermissionManager
APP权限管理类

***1. 支持的权限类型***
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



***2. 基本方法***

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

***3. 设计思路、注意事项***
> 设计思路：将所有权限类型定义成一个枚举，并将每一个权限类都实现协议WWPermissionInterface。权限管理者类实现的协议WWPermissionManagerInterface，权限管理者Manager会根据传入的枚举类型进行区分。

> 所有权限请求request都是异步回调的，所以可以在用户选择完权限后进行回调。

> 在Info.plist中加入权限对应的key，否非会出现奔溃的现象。

> 位置获取权限注意事项：
在iOS11之后，Privacy - Location Always Usage Description被降级为Privacy - Location When In Use Usage Description。
新添加Privacy - Location Always and When In Use Usage Description隐私权限，在使用后台定位的时候进行操作：Targets - Capabilities - Background Modes - location Update 这一项打钩


***4. 使用方法，以相册权限为例***

```swift

// 请求相册权限
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

// 跳转到setting
WWPermissionsManager.jumpSetting()

```

***5. 如果喜欢😍 请给star吧***

