//
//  ViewController.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2017/12/20.
//  Copyright © 2017年 王伟. All rights reserved.
//

import UIKit

private let CameraEnable       = "相机访问权限已启用"
private let CameraUsing        = "启用相机权限"
private let PhotoLibraryEnable = "相册访问权限已启用"
private let PhotoLibraryUsing  = "启用相册权限"
private let NotificationEnable = "通知访问权限已启用"
private let NotificationUsing  = "启用通知权限"
private let MicrophoneEnable   = "语音访问权限已启用"
private let MicrophoneUsing    = "启用语音权限"
private let LocationWhenInuseUsing    = "启用WhenInuse权限"
private let LocationWhenInuseEnable   = "WhenInuse访问权限已启用"
private let LocationAlwaysUsing       = "启用Always权限"
private let LocationAlwaysEnable      = "Always访问权限已启用"
private let LocationBackgroudUsing    = "启用Backgroud权限"
private let LocationBackgroudEnable   = "Backgroud访问权限已启用"
private let CalendarEnable   = "日历访问权限已启用"
private let CalendarUsing    = "启用日历权限"
private let ContactsEnable   = "联系人访问权限已启用"
private let ContactsUsing    = "启用联系人权限"
private let RemindersEnable  = "注意日程访问权限已启用"
private let RemindersUsing   = "启用日程权限"


private let noEnableColor = UIColor.init(red: 85.0/255.0,
                                                     green: 104.0/255.0,
                                                     blue: 220.0/255.0,
                                                     alpha: 1)
private let enableColor = UIColor.init(red: 0,
                                       green: 0,
                                       blue: 0,
                                       alpha: 0.25)

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var photoLibraryBtn: UIButton!
    @IBOutlet weak var noticeBtn: UIButton!
    @IBOutlet weak var microphoneBtn: UIButton!
    @IBOutlet weak var locationWhenInuseBtn: UIButton!
    @IBOutlet weak var locationAlwaysBtn: UIButton!
    @IBOutlet weak var locationBackgroudBtn: UIButton!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var contactsBtn: UIButton!
    @IBOutlet weak var remindersBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cameraPermission()
        photoLibraryPermission()
        noticePermission()
        microphonePermission()
        locationWhenInusePermission()
        locationAlwaysPermission()
        locationBackgroudPermission()
        contactsPermission()
        calendarPermission()
        remindersPermission()
    }
    
    func cameraPermission() {
        let cameraPermissionBool = PermissionsManager().isAuthorized(.camera)
        cameraBtn.setTitle(cameraPermissionBool ? CameraEnable : CameraUsing, for: .normal)
        cameraBtn.setTitleColor(cameraPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func photoLibraryPermission() {
        let photoLibraryPermissionBool = PermissionsManager().isAuthorized(.photoLibrary)
        photoLibraryBtn.setTitle(photoLibraryPermissionBool ? PhotoLibraryEnable : PhotoLibraryUsing, for: .normal)
        photoLibraryBtn.setTitleColor(photoLibraryPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func noticePermission() {
        let noticePermissionBool = PermissionsManager().isAuthorized(.notification)
        noticeBtn.setTitle(noticePermissionBool ? NotificationEnable : NotificationUsing, for: .normal)
        noticeBtn.setTitleColor(noticePermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func microphonePermission() {
        let microphonePermissionBool = PermissionsManager().isAuthorized(.microphone)
        microphoneBtn.setTitle(microphonePermissionBool ? MicrophoneEnable : MicrophoneUsing, for: .normal)
        microphoneBtn.setTitleColor(microphonePermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func locationWhenInusePermission() {
        let locationPermissionBool = PermissionsManager().isAuthorized(.locationWhenInUse)
        locationWhenInuseBtn.setTitle(locationPermissionBool ? LocationWhenInuseEnable : LocationWhenInuseUsing, for: .normal)
        locationWhenInuseBtn.setTitleColor(locationPermissionBool ? enableColor : noEnableColor, for: .normal)
    }

    func locationAlwaysPermission() {
        let locationPermissionBool = PermissionsManager().isAuthorized(.locationAlways)
        locationAlwaysBtn.setTitle(locationPermissionBool ? LocationAlwaysEnable : LocationAlwaysUsing, for: .normal)
        locationAlwaysBtn.setTitleColor(locationPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func locationBackgroudPermission() {
        let locationPermissionBool = PermissionsManager().isAuthorized(.locationWithBackground)
        locationBackgroudBtn.setTitle(locationPermissionBool ? LocationBackgroudEnable : LocationBackgroudUsing, for: .normal)
        locationBackgroudBtn.setTitleColor(locationPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func calendarPermission() {
        let calendarPermissionBool = WWCalendarPermission().isAuthorized()
        calendarBtn.setTitle(calendarPermissionBool ? CalendarEnable : CalendarUsing, for: .normal)
        calendarBtn.setTitleColor(calendarPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func contactsPermission() {
        let contactsPermissionBool = WWContactsPermission().isAuthorized()
        contactsBtn.setTitle(contactsPermissionBool ? ContactsEnable : ContactsUsing, for: .normal)
        contactsBtn.setTitleColor(contactsPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func remindersPermission() {
        let remindersPermissionBool = WWRemindersPermission().isAuthorized()
        remindersBtn.setTitle(remindersPermissionBool ? RemindersEnable : RemindersUsing, for: .normal)
        remindersBtn.setTitleColor(remindersPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
}

extension ViewController {
    
    /// 相机权限
    @IBAction func cameraPermissionRequest(_ sender: UIButton) {
        

        PermissionsManager().request(.camera) {self.cameraPermission()}
        if PermissionsManager().isNotDetermined(.camera) {}
        else if PermissionsManager().isAuthorized(.camera) {}
        else if PermissionsManager().isRestrictOrDenied(.camera) {PermissionsManager.jumpSetting()}
    }
    
    // 相册权限
    @IBAction func photoLibraryPremissionRequest(_ sender: UIButton) {
        
        PermissionsManager().request(.photoLibrary, with: {self.photoLibraryPermission()})
        if PermissionsManager().isNotDetermined(.photoLibrary) {}
        else if PermissionsManager().isAuthorized(.photoLibrary) {}
        else if PermissionsManager().isRestrictOrDenied(.photoLibrary) {PermissionsManager.jumpSetting()}
    }
    
    // 通知权限
    @IBAction func noticePremissionRequest(_ sender: UIButton) {
        
        PermissionsManager().request(.notification, with: {
            self.noticePermission()
            if WWNotificationPermission().isRestrictOrDenied() {}
            //            self.jumpSetting()
        })
    }
    
    // 麦克风权限
    @IBAction func microphonePermissionRequest(_ sender: UIButton) {
        
        PermissionsManager().request(.microphone) {self.microphonePermission()}
        if PermissionsManager().isNotDetermined(.microphone) {}
        else if PermissionsManager().isAuthorized(.microphone) {}
        else if PermissionsManager().isRestrictOrDenied(.microphone) {PermissionsManager.jumpSetting()}
    }
    
    // 使用时定位
    @IBAction func locationWhenUsePermissionRequest(_ sender: UIButton) {
        PermissionsManager().request(.locationWhenInUse) {
            self.locationWhenInusePermission()
            self.locationAlwaysPermission()
            self.locationBackgroudPermission()
        }
        if PermissionsManager().isNotDetermined(.locationWhenInUse) {}
        else if PermissionsManager().isAuthorized(.locationWhenInUse) {}
        else if PermissionsManager().isRestrictOrDenied(.locationWhenInUse) {PermissionsManager.jumpSetting()}
    }
    
    // 前后台定位（IOS11 以后就降级了）
    @IBAction func locationAlwaysPermissionRequest(_ sender: UIButton) {
        PermissionsManager().request(.locationAlways) {
            self.locationAlwaysPermission()
            self.locationWhenInusePermission()
            self.locationBackgroudPermission()
        }
        if PermissionsManager().isNotDetermined(.locationAlways) {}
        else if PermissionsManager().isAuthorized(.locationAlways) {}
        else if PermissionsManager().isRestrictOrDenied(.locationAlways) {PermissionsManager.jumpSetting()}
    }
    
    // 前后台定位（IOS11开始生效，需要在info.plist设置下：
    // 1. Privacy - Location Always and When In Use Usage Description
    // 2. targets - Capabilities - Background Modes - location Update 打钩
    @IBAction func locationBackgroundPermissionRequest(_ sender: UIButton) {
        PermissionsManager().request(.locationWithBackground) {
            self.locationBackgroudPermission()
            self.locationWhenInusePermission()
            self.locationAlwaysPermission()
        }
        if PermissionsManager().isNotDetermined(.locationWithBackground) {}
        else if PermissionsManager().isAuthorized(.locationWithBackground) {}
        else if PermissionsManager().isRestrictOrDenied(.locationWithBackground) {PermissionsManager.jumpSetting()}
    }
    
    // 日历
    @IBAction func CalendarPermissionRequest(_ sender: UIButton) {
        
        PermissionsManager().request(.calendar) {
            self.calendarPermission()
            
        }
        if PermissionsManager().isNotDetermined(.calendar) {}
        else if PermissionsManager().isAuthorized(.calendar) {}
        else if PermissionsManager().isRestrictOrDenied(.calendar) {PermissionsManager.jumpSetting()}
    }
    
    // 联系人
    @IBAction func ContactsPermissionRequest(_ sender: UIButton) {
        
        PermissionsManager().request(.contacts) {
            self.contactsPermission()
            
        }
        if PermissionsManager().isNotDetermined(.contacts) {}
        else if PermissionsManager().isAuthorized(.contacts) {}
        else if PermissionsManager().isRestrictOrDenied(.contacts) {PermissionsManager.jumpSetting()}
    }
    
    // 日程提醒
    @IBAction func RemindersPermissionRequest(_ sender: UIButton) {
        
        PermissionsManager().request(.reminders) {
            self.remindersPermission()
            
        }
        if PermissionsManager().isNotDetermined(.reminders) {}
        else if PermissionsManager().isAuthorized(.reminders) {}
        else if PermissionsManager().isRestrictOrDenied(.reminders) {PermissionsManager.jumpSetting()}
    }
    
    
    // jumpSetting
    @IBAction func jumpSetting() {
        PermissionsManager.jumpSetting()
    }
}

