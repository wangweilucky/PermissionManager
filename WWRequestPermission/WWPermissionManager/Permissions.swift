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
import StoreKit
import HealthKit
import CoreMotion


/// The app's Info.plist must contain an NSCameraUsageDescription key
class WWCameraPermission: PermissionProtocol {
    
    var status: AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    // .authorized, .denied, .restricted, .notDetermined
    func request(complectionHandler: @escaping PermissionClosure) {
        AVCaptureDevice.requestAccess(for: .video) { (finished) in
            switch self.status {
            case .authorized:
                complectionHandler(true)
            case .denied, .restricted, .notDetermined:
                complectionHandler(false)
            }
        }
    }

    func isNotDetermined() -> Bool {
        return status == .notDetermined
    }
    
    func isAuthorized() -> Bool {
        return status == .authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        return status == .restricted || status == .denied
    }
}

/// The app's Info.plist must contain an NSPhotoLibraryUsageDescription key
class WWPhotoLibraryPermission: PermissionProtocol {
    
    var status: PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
    
    // .authorized, .denied, .restricted, .notDetermined
    func request(complectionHandler: @escaping PermissionClosure) {
        PHPhotoLibrary.requestAuthorization({ finished in
            switch self.status {
            case .authorized:
                complectionHandler(true)
            case .denied, .restricted, .notDetermined:
                complectionHandler(false)
            }
        })
    }
    
    
    func isNotDetermined() -> Bool {
        return status == PHAuthorizationStatus.notDetermined
    }
    
    func isAuthorized() -> Bool {
        return status == PHAuthorizationStatus.authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        return status == PHAuthorizationStatus.restricted || PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.denied
    }
}

class WWNotificationPermission: PermissionProtocol {
    
    // notDetermined denied authorized
    func request(complectionHandler: @escaping PermissionClosure) {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                if (granted) {
                    complectionHandler(true)
                } else {
                    complectionHandler(false)
                }
            }
        } else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
            complectionHandler(true)
        } else {
            UIApplication.shared.registerForRemoteNotifications(matching: [.alert, .badge, .sound])
            UIApplication.shared.registerForRemoteNotifications()
            complectionHandler(true)
        }
    }
    
    @available(iOS 10.0, *)
    var status: UNAuthorizationStatus {
        var status : UNAuthorizationStatus = .denied
        let group = DispatchGroup()
        group.enter() // 阻塞线程,直到派发的任务完成
        UNUserNotificationCenter.current().getNotificationSettings { (setting) in
            status = setting.authorizationStatus
            group.leave()
        }
        group.wait()
        return status
    }
    
    func isNotDetermined() -> Bool {
        if #available(iOS 10, *) {
            return status == .notDetermined
        } else {
            return false
        }
    }
    
    func isAuthorized() -> Bool {
        if #available(iOS 10, *) {
            return status == .authorized
        } else {
            return false
        }
    }
    
    func isRestrictOrDenied() -> Bool {
        if #available(iOS 10, *) {
            return status == .denied
        } else {
            return false
        }
    }
}


class WWMicrophonePermission: PermissionProtocol {
    
    var status: AVAudioSessionRecordPermission {
        return AVAudioSession.sharedInstance().recordPermission()
    }
    
    // denied undetermined granted
    func request(complectionHandler: @escaping PermissionClosure) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            complectionHandler(granted)
        }
    }
    
    func isNotDetermined() -> Bool {
        return status == .undetermined
    }
    
    func isAuthorized() -> Bool {
        return status == .granted
    }
    
    func isRestrictOrDenied() -> Bool {
        return status == .denied
    }
}

// The app's Info.plist must contain an NSContactsUsageDescription key
class WWContactsPermission: PermissionProtocol {
    
    // notDetermined restricted denied authorized
    func request(complectionHandler: @escaping PermissionClosure) {
        if #available(iOS 9.0, *) {
            let store = CNContactStore()
            store.requestAccess(for: .contacts, completionHandler: { (granted, error) in
                complectionHandler(granted)
            })
        } else {
            let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
            ABAddressBookRequestAccessWithCompletion(addressBookRef) {
                (granted: Bool, error: CFError?) in
                complectionHandler(granted)
            }
        }
    }
    
    func isNotDetermined() -> Bool {
        if #available(iOS 9.0, *) {
            return CNContactStore.authorizationStatus(for: .contacts) == .notDetermined
        } else {
            return ABAddressBookGetAuthorizationStatus() == .notDetermined
        }
    }
    
    func isAuthorized() -> Bool {
        if #available(iOS 9.0, *) {
            return CNContactStore.authorizationStatus(for: .contacts) == .authorized
        } else {
            return ABAddressBookGetAuthorizationStatus() == .authorized
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
}

// The app's Info.plist must contain an NSRemindersUsageDescription key
class WWRemindersPermission: PermissionProtocol {
    
    var status: EKAuthorizationStatus {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
        return status
    }
    
    func request(complectionHandler: @escaping PermissionClosure) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
            (accessGranted: Bool, error: Error?) in
            complectionHandler(accessGranted)
        })
    }
    
    
    func isNotDetermined() -> Bool {
        return status == EKAuthorizationStatus.notDetermined
    }
    
    func isAuthorized() -> Bool {
        return status == EKAuthorizationStatus.authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        return status == EKAuthorizationStatus.restricted || status == EKAuthorizationStatus.denied
    }
}

// The app's Info.plist must contain an NSCalendarsUsageDescription key
class WWCalendarPermission: PermissionProtocol {
    
    var status: EKAuthorizationStatus {
        return EKEventStore.authorizationStatus(for: EKEntityType.event)
    }
    
    func request(complectionHandler: @escaping PermissionClosure) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            complectionHandler(accessGranted)
        })
    }
    
    func isNotDetermined() -> Bool {
        return status == EKAuthorizationStatus.notDetermined
    }
    
    func isAuthorized() -> Bool {
        return status == EKAuthorizationStatus.authorized
    }
    
    func isRestrictOrDenied() -> Bool {
        return status == EKAuthorizationStatus.restricted || status == EKAuthorizationStatus.denied
    }
}

// The app's Info.plist must contain an NSLocationUsageDescription key
// The app's Info.plist must contain an NSLocationWhenInUseUsageDescription key
// The app's Info.plist must contain an NSLocationAlwaysUsageDescription key
class WWLocationPermission: PermissionProtocol {
    
    enum WWLocationType {
        case Always
        case WhenInUse
        case AlwaysWithBackground
    }
    
    var type: WWLocationType
    
    lazy var locationManager: CLLocationManager =  {
        return CLLocationManager()
    }()
    
    init(type: WWLocationType) {
        
        self.type = type
    }
    
    func request(complectionHandler: @escaping PermissionClosure) {
        switch type {
        case .Always:
            PermissionAlwaysLocationHandler.share.request({ (authorized) in
                complectionHandler(authorized)
            })
            
        case .WhenInUse:
            PermissionWhenInUseLocationHandler.share.request({ (authorized) in
                complectionHandler(authorized)
            })
            
        case .AlwaysWithBackground:
            PermissionLocationWithBackgroundHandler.share.request({ (authorized) in
                complectionHandler(authorized)
            })
        }
    }
    
    
    func isNotDetermined() -> Bool {
        switch type {
        case .Always:
            return PermissionAlwaysLocationHandler().isNotDetermined()
        case .WhenInUse:
            return PermissionWhenInUseLocationHandler().isNotDetermined()
        case .AlwaysWithBackground:
            return PermissionLocationWithBackgroundHandler().isNotDetermined()
        }
    }
    
    func isAuthorized() -> Bool {
        switch type {
        case .Always:
            return PermissionAlwaysLocationHandler().isAuthorized()
        case .WhenInUse:
            return PermissionWhenInUseLocationHandler().isAuthorized()
        case .AlwaysWithBackground:
            return PermissionLocationWithBackgroundHandler().isAuthorized()
        }
    }
    
    func isRestrictOrDenied() -> Bool {
        switch type {
        case .Always:
            return PermissionAlwaysLocationHandler().isRestrictOrDenied()
        case .WhenInUse:
            return PermissionWhenInUseLocationHandler().isRestrictOrDenied()
        case .AlwaysWithBackground:
            return PermissionLocationWithBackgroundHandler().isRestrictOrDenied()
        }
    }
}

// The app's Info.plist must contain an NSMotionUsageDescriptionApp key 
class WWMotionPermission: PermissionProtocol {
    
//    var status: CMAuthorizationStatus {
//        return CMMotionActivityManager.
//    }
//    
//    // denied undetermined granted
//    func request(complectionHandler: @escaping PermissionClosure) {
//        CMMotionActivityManager.
//    }
//    
//    func isNotDetermined() -> Bool {
//        return status == .undetermined
//    }
//    
//    func isAuthorized() -> Bool {
//        return status == .granted
//    }
//    
//    func isRestrictOrDenied() -> Bool {
//        return status == .denied
//    }
}

// The app's Info.plist must contain an NSMotionUsageDescriptionApp key
class WWAppleMusicPermission: PermissionProtocol {
    
    @available(iOS 9.3, *)
    var status: SKCloudServiceAuthorizationStatus {
        return SKCloudServiceController.authorizationStatus()
    }
    
    // denied undetermined granted
    func request(complectionHandler: @escaping PermissionClosure) {
        if #available(iOS 9.3, *) {
            SKCloudServiceController.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    complectionHandler(true)
                    
                case .denied, .notDetermined, .restricted:
                    complectionHandler(false)
                }
            }
        } else {
            fatalError(WWgetLog(type: self))
        }
    }
    
    func isNotDetermined() -> Bool {
        if #available(iOS 9.3, *) {
            return status == .notDetermined
        } else {
            // Fallback on earlier versions
            fatalError(WWgetLog(type: self))
        }
    }
    
    func isAuthorized() -> Bool {
        if #available(iOS 9.3, *) {
            return status == .authorized
        } else {
            // Fallback on earlier versions
            fatalError(WWgetLog(type: self))
        }
    }
    
    func isRestrictOrDenied() -> Bool {
        if #available(iOS 9.3, *) {
            return status == .restricted || status == .denied
        } else {
            // Fallback on earlier versions
            fatalError(WWgetLog(type: self))
        }
    }
}


//// The app's Info.plist must contain an NSHealthUpdateUsageDescription key
//class WWHealthPermission: PermissionProtocol {
//
//    @available(iOS 9.3, *)
//    var status: SKCloudServiceAuthorizationStatus {
//        return SKCloudServiceController.authorizationStatus()
//    }
//
//    // denied undetermined granted
//    func request(complectionHandler: @escaping PermissionClosure) {
//        if #available(iOS 9.3, *) {
//            SKCloudServiceController.requestAuthorization { (status) in
//                switch status {
//                case .authorized:
//                    complectionHandler(true)
//
//                case .denied, .notDetermined, .restricted:
//                    complectionHandler(false)
//                }
//            }
//        } else {
//            fatalError(WWgetLog(type: self))
//        }
//    }
//
//    func isNotDetermined() -> Bool {
//        if #available(iOS 9.3, *) {
//            return status == .notDetermined
//        } else {
//            // Fallback on earlier versions
//            fatalError(WWgetLog(type: self))
//        }
//    }
//
//    func isAuthorized() -> Bool {
//        if #available(iOS 9.3, *) {
//            return status == .authorized
//        } else {
//            // Fallback on earlier versions
//            fatalError(WWgetLog(type: self))
//        }
//    }
//
//    func isRestrictOrDenied() -> Bool {
//        if #available(iOS 9.3, *) {
//            return status == .restricted || status == .denied
//        } else {
//            // Fallback on earlier versions
//            fatalError(WWgetLog(type: self))
//        }
//    }
//}



