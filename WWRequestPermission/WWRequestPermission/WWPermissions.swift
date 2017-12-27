//
//  WWPermissions.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2017/12/21.
//  Copyright © 2017年 王伟. All rights reserved.
//


import Photos
import UserNotifications
import MapKit
import EventKit
import Contacts
import AVFoundation


/// The app's Info.plist must contain an NSCameraUsageDescription key
class WWCameraPermission: WWPermissionInterface{
    
    func isNotDetermined() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined
    }
    
    func isAuthorized() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .restricted || AVCaptureDevice.authorizationStatus(for: .video) == .denied
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        AVCaptureDevice.requestAccess(for: .video) { (finished) in
            DispatchQueue.main.async {
                complectionHandler()
            }
        }
    }
}

/// The app's Info.plist must contain an NSPhotoLibraryUsageDescription key
class WWPhotoLibraryPermission: WWPermissionInterface {
    
    func isNotDetermined() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.notDetermined
    }
    
    func isAuthorized() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.restricted || PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.denied
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        PHPhotoLibrary.requestAuthorization({
            finished in
            DispatchQueue.main.async {
                complectionHandler()
            }
        })
    }
}

class WWNotificationPermission: WWPermissionInterface {
    
    func isNotDetermined() -> Bool {
        return true // 通知没有未确定的情况，此方法忽略
    }
    
    func isAuthorized() -> Bool {
        return UIApplication.shared.currentUserNotificationSettings!.types != []
    }
    
    func isRestrictOrDenied() -> Bool {
        return !WWNotificationPermission().isAuthorized()
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                DispatchQueue.main.async {
                    complectionHandler()
                }
            }
        } // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            DispatchQueue.main.async {
                complectionHandler()
            }
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            DispatchQueue.main.async {
                complectionHandler()
            }
        }
            // iOS 7 support
        else {
            DispatchQueue.main.async {
                complectionHandler()
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}


class WWMicrophonePermission: WWPermissionInterface {
    func isNotDetermined() -> Bool {
        return AVAudioSession.sharedInstance().recordPermission() == .undetermined
    }
    
    func isAuthorized() -> Bool {
        let status = AVAudioSession.sharedInstance().recordPermission()
        return status == .granted
    }
    
    func isRestrictOrDenied() -> Bool {
        return AVAudioSession.sharedInstance().recordPermission() == .denied
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        
        AVAudioSession.sharedInstance().requestRecordPermission {
            granted in
            DispatchQueue.main.async {
                complectionHandler()
            }
        }
    }
}

class WWLocationPermission: NSObject, WWPermissionInterface {
    
    var type: WWLocationType
    
    lazy var locationManager: CLLocationManager =  {
        return CLLocationManager()
    }()
    
    enum WWLocationType {
        case Always
        case WhenInUse
        case AlwaysWithBackground
    }
    
    init(type: WWLocationType) {
        
        self.type = type
    }
    
    
    func isNotDetermined() -> Bool {
        switch type {
        case .Always:
            return WWRequestPermissionAlwaysAuthorizationLocationHandler().isNotDetermined()
        case .WhenInUse:
            return WWRequestPermissionWhenInUseAuthorizationLocationHandler().isNotDetermined()
        case .AlwaysWithBackground:
            return WWRequestPermissionLocationWithBackgroundHandler().isNotDetermined()
        }
    }
    
    func isAuthorized() -> Bool {
        switch type {
        case .Always:
            return WWRequestPermissionAlwaysAuthorizationLocationHandler().isAuthorized()
        case .WhenInUse:
            return WWRequestPermissionWhenInUseAuthorizationLocationHandler().isAuthorized()
        case .AlwaysWithBackground:
            return WWRequestPermissionLocationWithBackgroundHandler().isAuthorized()
        }
    }
    
    func isRestrictOrDenied() -> Bool {
        switch type {
        case .Always:
            return WWRequestPermissionAlwaysAuthorizationLocationHandler().isRestrictOrDenied()
        case .WhenInUse:
            return WWRequestPermissionWhenInUseAuthorizationLocationHandler().isRestrictOrDenied()
        case .AlwaysWithBackground:
            return WWRequestPermissionLocationWithBackgroundHandler().isRestrictOrDenied()
        }
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        switch type {
        case .Always:
            if WWRequestPermissionAlwaysAuthorizationLocationHandler.share == nil {
                WWRequestPermissionAlwaysAuthorizationLocationHandler.share = WWRequestPermissionAlwaysAuthorizationLocationHandler()
            }
            WWRequestPermissionAlwaysAuthorizationLocationHandler.share!.request({ (authorized) in
                DispatchQueue.main.async {
                    complectionHandler()
                    WWRequestPermissionAlwaysAuthorizationLocationHandler.share = nil
                }
            })
            
        case .WhenInUse:
            if WWRequestPermissionWhenInUseAuthorizationLocationHandler.share == nil {
                WWRequestPermissionWhenInUseAuthorizationLocationHandler.share = WWRequestPermissionWhenInUseAuthorizationLocationHandler()
            }
            WWRequestPermissionWhenInUseAuthorizationLocationHandler.share!.request({ (authorized) in
                DispatchQueue.main.async {
                    complectionHandler()
                    WWRequestPermissionWhenInUseAuthorizationLocationHandler.share = nil
                }
            })
            
        case .AlwaysWithBackground:
            if WWRequestPermissionLocationWithBackgroundHandler.share == nil {
                WWRequestPermissionLocationWithBackgroundHandler.share = WWRequestPermissionLocationWithBackgroundHandler()
            }
            WWRequestPermissionLocationWithBackgroundHandler.share!.request({ (authorized) in
                DispatchQueue.main.async {
                    complectionHandler()
                    WWRequestPermissionLocationWithBackgroundHandler.share = nil
                }
            })
        }
    }
    
}

// The app's Info.plist must contain an NSContactsUsageDescription key
class WWContactsPermission: WWPermissionInterface {
    func isNotDetermined() -> Bool {
        if #available(iOS 9.0, *) {
            let status = CNContactStore.authorizationStatus(for: .contacts)
            return status == .notDetermined
        } else {
            let status = ABAddressBookGetAuthorizationStatus()
            return status == .notDetermined
        }
    }
    
    func isAuthorized() -> Bool {
        if #available(iOS 9.0, *) {
            let status = CNContactStore.authorizationStatus(for: .contacts)
            return status == .authorized
        } else {
            let status = ABAddressBookGetAuthorizationStatus()
            return status == .authorized
        }
    }
    
    func isRestrictOrDenied() -> Bool {
        if #available(iOS 9.0, *) {
            let status = CNContactStore.authorizationStatus(for: .contacts)
            return status == .restricted || status == .denied
        } else {
            let status = ABAddressBookGetAuthorizationStatus()
            return status == .restricted || status == .denied
        }
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        if #available(iOS 9.0, *) {
            let store = CNContactStore()
            store.requestAccess(for: .contacts, completionHandler: { (granted, error) in
                DispatchQueue.main.async {
                    complectionHandler()
                }
            })
        } else {
            let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
            ABAddressBookRequestAccessWithCompletion(addressBookRef) {
                (granted: Bool, error: CFError?) in
                DispatchQueue.main.async() {
                    complectionHandler()
                }
            }
        }
    }
}

// The app's Info.plist must contain an NSRemindersUsageDescription key
class WWRemindersPermission: WWPermissionInterface {
    
    
    func isNotDetermined() -> Bool {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
        return status == EKAuthorizationStatus.notDetermined
    }
    
    func isAuthorized() -> Bool {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
        return status == EKAuthorizationStatus.authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
        return status == EKAuthorizationStatus.restricted || status == EKAuthorizationStatus.denied
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                complectionHandler()
            }
        })
    }
}

// The app's Info.plist must contain an NSCalendarsUsageDescription key
class WWCalendarPermission: WWPermissionInterface {
    
    func isNotDetermined() -> Bool {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        return status == EKAuthorizationStatus.notDetermined
    }
    
    func isAuthorized() -> Bool {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        return status == EKAuthorizationStatus.authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        return status == EKAuthorizationStatus.restricted || status == EKAuthorizationStatus.denied
    }
    
    func request(withComplectionHandler complectionHandler: @escaping () -> ()) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                complectionHandler()
            }
        })
    }
}


/*
 <!-- 相册 -->
 <key>NSPhotoLibraryUsageDescription</key>
 <string>App需要您的同意,才能访问相册</string>
 <!-- 相机 -->
 <key>NSCameraUsageDescription</key>
 <string>App需要您的同意,才能访问相机</string>
 <!-- 麦克风 -->
 <key>NSMicrophoneUsageDescription</key>
 <string>App需要您的同意,才能访问麦克风</string>
 <!-- 位置 -->
 <key>NSLocationUsageDescription</key>
 <string>App需要您的同意,才能访问位置</string>
 <!-- 在使用期间访问位置 -->
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>App需要您的同意,才能在使用期间访问位置</string>
 <!-- 始终访问位置 -->
 <key>NSLocationAlwaysUsageDescription</key>
 <string>App需要您的同意,才能始终访问位置</string>
 <!-- 日历 -->
 <key>NSCalendarsUsageDescription</key>
 <string>App需要您的同意,才能访问日历</string>
 <!-- 提醒事项 -->
 <key>NSRemindersUsageDescription</key>
 <string>App需要您的同意,才能访问提醒事项</string>
 <!-- 运动与健身 -->
 <key>NSMotionUsageDescription</key> <string>App需要您的同意,才能访问运动与健身</string>
 <!-- 健康更新 -->
 <key>NSHealthUpdateUsageDescription</key>
 <string>App需要您的同意,才能访问健康更新 </string>
 <!-- 健康分享 -->
 <key>NSHealthShareUsageDescription</key>
 <string>App需要您的同意,才能访问健康分享</string>
 <!-- 蓝牙 -->
 <key>NSBluetoothPeripheralUsageDescription</key>
 <string>App需要您的同意,才能访问蓝牙</string>
 <!-- 媒体资料库 -->
 <key>NSAppleMusicUsageDescription</key>
 <string>App需要您的同意,才能访问媒体资料库</string>
 */
