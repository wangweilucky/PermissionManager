//
//  ViewController.swift
//  WWRequestPermission
//
//  Created by 王伟 on 2017/12/20.
//  Copyright © 2017年 王伟. All rights reserved.
//

import UIKit

private let EnableDesc = "启用"
private let HasEnable = "已启用"

private let Camera       = "相机权限"
private let PhotoLibrary = "相册权限"
private let Notification = "通知权限"
private let MicrophoneEnable    = "语音权限"
private let LocationWhenInuse   = "WhenInuse权限"
private let LocationAlways      = "Always权限"
private let LocationBackgroud   = "Backgroud权限"
private let Contacts   = "联系人权限"
private let Reminders  = "日程权限"
private let Calendar   = "日历权限"

private let Motion   = "运动与健身权限"
private let Health   = "健康权限"
private let HealthShare   = "健康分享权限"
private let Bluetooth = "蓝牙"
private let AppleMusic = "媒体资料库"

/*
 <!-- 运动与健身 -->
 <key>NSMotionUsageDescription</key> <string>App需要您的同意,才能运动与健身</string>
 <!-- 健康更新 -->
 <key>NSHealthUpdateUsageDescription</key>
 <string>App需要您的同意,才能健康更新 </string>
 <!-- 健康分享 -->
 <key>NSHealthShareUsageDescription</key>
 <string>App需要您的同意,才能健康分享</string>
 
 <!-- 蓝牙 -->
 <key>NSBluetoothPeripheralUsageDescription</key>
 <string>App需要您的同意,才能蓝牙</string>
 <!-- 媒体资料库 -->
 <key>NSAppleMusicUsageDescription</key>
 <string>App需要您的同意,才能媒体资料库</string>
 */


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
    @IBOutlet weak var motionBtn: UIButton!
    @IBOutlet weak var healthBtn: UIButton!
    @IBOutlet weak var healthShareBtn: UIButton!
    @IBOutlet weak var bluetoothBtn: UIButton!
    @IBOutlet weak var appleMusicBtn: UIButton!
    
    
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
        showButtonUI(sender: cameraBtn,
                     bool: PermissionsManager.isAuthorized(.camera))
    }
    
    func photoLibraryPermission() {
        showButtonUI(sender: photoLibraryBtn,
                     bool: PermissionsManager.isAuthorized(.photoLibrary))
    }
    
    func noticePermission() {
        showButtonUI(sender: noticeBtn,
                     bool: PermissionsManager.isAuthorized(.notification))
    }
    
    func microphonePermission() {
        
        showButtonUI(sender: microphoneBtn,
                     bool: PermissionsManager.isAuthorized(.microphone))
    }
    
    func locationWhenInusePermission() {
        showButtonUI(sender: locationWhenInuseBtn,
                     bool: PermissionsManager.isAuthorized(.locationWhenInUse))
    }

    func locationAlwaysPermission() {
        showButtonUI(sender: locationAlwaysBtn,
                     bool: PermissionsManager.isAuthorized(.locationAlways))
    }
    
    func locationBackgroudPermission() {
        showButtonUI(sender: locationBackgroudBtn,
                     bool: PermissionsManager.isAuthorized(.locationWithBackground))
    }
    
    func calendarPermission() {
        showButtonUI(sender: calendarBtn,
                     bool: PermissionsManager.isAuthorized(.calendar))
    }
    
    func contactsPermission() {
        showButtonUI(sender: contactsBtn,
                     bool: PermissionsManager.isAuthorized(.contacts))
    }
    
    func remindersPermission() {
        showButtonUI(sender: remindersBtn,
                     bool: PermissionsManager.isAuthorized(.reminders))
    }
}

extension ViewController {
    
    func showButtonUI(sender: UIButton, bool: Bool) {
        DispatchQueue.main.async {
            var desc = ""
            switch sender.tag {
            case 1:
                desc = Camera
            case 2:
                desc = PhotoLibrary
            case 3:
                desc = Notification
            case 4:
                desc = MicrophoneEnable
            case 5:
                desc = LocationWhenInuse
            case 6:
                desc = LocationAlways
            case 7:
                desc = LocationBackgroud
            case 8:
                desc = Contacts
            case 9:
                desc = Reminders
            case 10:
                desc = Calendar
            default:
                desc = ""
            }
            
            desc = bool ? (desc + HasEnable) : (EnableDesc + desc)
            sender.setTitleColor(bool ? enableColor : noEnableColor, for: .normal)
            sender.setTitle(desc, for: .normal)
        }
    }
    
    /// 相机权限
    @IBAction func cameraPermissionRequest(_ sender: UIButton) {
        
        
        
        if PermissionsManager.isRestrictOrDenied(.camera) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.camera) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 相册权限
    @IBAction func photoLibraryPremissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.photoLibrary) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.photoLibrary) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 麦克风权限
    @IBAction func microphonePermissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.microphone) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.microphone) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 日历
    @IBAction func CalendarPermissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.calendar) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.calendar) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 联系人
    @IBAction func ContactsPermissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.contacts) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.contacts) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 日程提醒
    @IBAction func RemindersPermissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.reminders) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.reminders) {bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    
    // 通知权限
    @IBAction func noticePremissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.notification) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.notification) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 使用时定位
    @IBAction func locationWhenUsePermissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.locationWhenInUse) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.locationWhenInUse) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 前后台定位（IOS11 以后就降级了）
    @IBAction func locationAlwaysPermissionRequest(_ sender: UIButton) {
        
        if PermissionsManager.isRestrictOrDenied(.locationAlways) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.locationAlways) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 前后台定位（IOS11开始生效，需要在info.plist设置下：
    // 1. Privacy - Location Always and When In Use Usage Description
    // 2. targets - Capabilities - Background Modes - location Update 打钩
    @IBAction func locationBackgroundPermissionRequest(_ sender: UIButton) {
       
        if PermissionsManager.isRestrictOrDenied(.locationWithBackground) {
            PermissionsManager.jumpSetting()
            return
        }
        PermissionsManager.request(.locationWithBackground) { bool in
            self.showButtonUI(sender: sender, bool: bool)
        }
    }
    
    // 运动与健身权限
    @IBAction func motionPermissionRequest(_ sender: UIButton) {
    
    }
    
    // 健康权限
    @IBAction func healthPermissionRequest(_ sender: UIButton) {
        
    }
    
    // 运动与健身权限
    @IBAction func healthSharePermissionRequest(_ sender: UIButton) {
        
    }
    
    // 健康分享权限
    @IBAction func bluetoothPermissionRequest(_ sender: UIButton) {
        
    }
    
    // 媒体资料库
    @IBAction func appleMusicPermissionRequest(_ sender: UIButton) {
        
    }
    
    
    // jumpSetting
    @IBAction func jumpSetting() {
        PermissionsManager.jumpSetting()
    }
}

