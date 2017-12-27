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
        let cameraPermissionBool = WWPermissionsManager().isAuthorized(.camera)
        cameraBtn.setTitle(cameraPermissionBool ? CameraEnable : CameraUsing, for: .normal)
        cameraBtn.setTitleColor(cameraPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func photoLibraryPermission() {
        let photoLibraryPermissionBool = WWPermissionsManager().isAuthorized(.photoLibrary)
        photoLibraryBtn.setTitle(photoLibraryPermissionBool ? PhotoLibraryEnable : PhotoLibraryUsing, for: .normal)
        photoLibraryBtn.setTitleColor(photoLibraryPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func noticePermission() {
        let noticePermissionBool = WWPermissionsManager().isAuthorized(.notification)
        noticeBtn.setTitle(noticePermissionBool ? NotificationEnable : NotificationUsing, for: .normal)
        noticeBtn.setTitleColor(noticePermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func microphonePermission() {
        let microphonePermissionBool = WWPermissionsManager().isAuthorized(.microphone)
        microphoneBtn.setTitle(microphonePermissionBool ? MicrophoneEnable : MicrophoneUsing, for: .normal)
        microphoneBtn.setTitleColor(microphonePermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func locationWhenInusePermission() {
        let locationPermissionBool = WWPermissionsManager().isAuthorized(.locationWhenInUse)
        locationWhenInuseBtn.setTitle(locationPermissionBool ? LocationWhenInuseEnable : LocationWhenInuseUsing, for: .normal)
        locationWhenInuseBtn.setTitleColor(locationPermissionBool ? enableColor : noEnableColor, for: .normal)
    }

    func locationAlwaysPermission() {
        let locationPermissionBool = WWPermissionsManager().isAuthorized(.locationAlways)
        locationAlwaysBtn.setTitle(locationPermissionBool ? LocationAlwaysEnable : LocationAlwaysUsing, for: .normal)
        locationAlwaysBtn.setTitleColor(locationPermissionBool ? enableColor : noEnableColor, for: .normal)
    }
    
    func locationBackgroudPermission() {
        let locationPermissionBool = WWPermissionsManager().isAuthorized(.locationWithBackground)
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
        
        WWPermissionsManager().request(.camera) {self.cameraPermission()}
        if WWPermissionsManager().isNotDetermined(.camera) {}
        else if WWPermissionsManager().isAuthorized(.camera) {}
        else if WWPermissionsManager().isRestrictOrDenied(.camera) {WWPermissionsManager.jumpSetting()}
    }
    
    // 相册权限
    @IBAction func photoLibraryPremissionRequest(_ sender: UIButton) {
        
        WWPermissionsManager().request(.photoLibrary, with: {self.photoLibraryPermission()})
        if WWPermissionsManager().isNotDetermined(.photoLibrary) {}
        else if WWPermissionsManager().isAuthorized(.photoLibrary) {}
        else if WWPermissionsManager().isRestrictOrDenied(.photoLibrary) {WWPermissionsManager.jumpSetting()}
    }
    
    // 通知权限
    @IBAction func noticePremissionRequest(_ sender: UIButton) {
        
        WWPermissionsManager().request(.notification, with: {
            self.noticePermission()
            if WWNotificationPermission().isRestrictOrDenied() {}
            //            self.jumpSetting()
        })
    }
    
    // 麦克风权限
    @IBAction func microphonePermissionRequest(_ sender: UIButton) {
        
        WWPermissionsManager().request(.microphone) {self.microphonePermission()}
        if WWPermissionsManager().isNotDetermined(.microphone) {}
        else if WWPermissionsManager().isAuthorized(.microphone) {}
        else if WWPermissionsManager().isRestrictOrDenied(.microphone) {WWPermissionsManager.jumpSetting()}
    }
    
    // 使用时定位
    @IBAction func locationWhenUsePermissionRequest(_ sender: UIButton) {
        WWPermissionsManager().request(.locationWhenInUse) {
            self.locationWhenInusePermission()
            self.locationAlwaysPermission()
            self.locationBackgroudPermission()
        }
        if WWPermissionsManager().isNotDetermined(.locationWhenInUse) {}
        else if WWPermissionsManager().isAuthorized(.locationWhenInUse) {}
        else if WWPermissionsManager().isRestrictOrDenied(.locationWhenInUse) {WWPermissionsManager.jumpSetting()}
    }
    
    // 前后台定位（IOS11 以后就降级了）
    @IBAction func locationAlwaysPermissionRequest(_ sender: UIButton) {
        WWPermissionsManager().request(.locationAlways) {
            self.locationAlwaysPermission()
            self.locationWhenInusePermission()
            self.locationBackgroudPermission()
        }
        if WWPermissionsManager().isNotDetermined(.locationAlways) {}
        else if WWPermissionsManager().isAuthorized(.locationAlways) {}
        else if WWPermissionsManager().isRestrictOrDenied(.locationAlways) {WWPermissionsManager.jumpSetting()}
    }
    
    // 前后台定位（IOS11开始生效，需要在info.plist设置下：
    // 1. Privacy - Location Always and When In Use Usage Description
    // 2. targets - Capabilities - Background Modes - location Update 打钩
    @IBAction func locationBackgroundPermissionRequest(_ sender: UIButton) {
        WWPermissionsManager().request(.locationWithBackground) {
            self.locationBackgroudPermission()
            self.locationWhenInusePermission()
            self.locationAlwaysPermission()
        }
        if WWPermissionsManager().isNotDetermined(.locationWithBackground) {}
        else if WWPermissionsManager().isAuthorized(.locationWithBackground) {}
        else if WWPermissionsManager().isRestrictOrDenied(.locationWithBackground) {WWPermissionsManager.jumpSetting()}
    }
    
    // 日历
    @IBAction func CalendarPermissionRequest(_ sender: UIButton) {
        
        WWPermissionsManager().request(.calendar) {
            self.calendarPermission()
            
        }
        if WWPermissionsManager().isNotDetermined(.calendar) {}
        else if WWPermissionsManager().isAuthorized(.calendar) {}
        else if WWPermissionsManager().isRestrictOrDenied(.calendar) {WWPermissionsManager.jumpSetting()}
    }
    
    // 联系人
    @IBAction func ContactsPermissionRequest(_ sender: UIButton) {
        
        WWPermissionsManager().request(.contacts) {
            self.contactsPermission()
            
        }
        if WWPermissionsManager().isNotDetermined(.contacts) {}
        else if WWPermissionsManager().isAuthorized(.contacts) {}
        else if WWPermissionsManager().isRestrictOrDenied(.contacts) {WWPermissionsManager.jumpSetting()}
    }
    
    // 日程提醒
    @IBAction func RemindersPermissionRequest(_ sender: UIButton) {
        
        WWPermissionsManager().request(.reminders) {
            self.remindersPermission()
            
        }
        if WWPermissionsManager().isNotDetermined(.reminders) {}
        else if WWPermissionsManager().isAuthorized(.reminders) {}
        else if WWPermissionsManager().isRestrictOrDenied(.reminders) {WWPermissionsManager.jumpSetting()}
    }
    
    
    // jumpSetting
    @IBAction func jumpSetting() {
        WWPermissionsManager.jumpSetting()
    }
}

