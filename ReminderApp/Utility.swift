//
//  Utility.swift
//  ReminderApp
//
//  Created by Atharva.Kulkarni on 01/09/24.
//

import Foundation
import UIKit
import UserNotifications

extension UIViewController {
    
    func showAlert(msg: String){
        
        let alertVC = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true)
        
    }
    
    
    func scheduleByDateTime(title:String,date:Date,priority:Bool) async -> Bool{
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = priority ? "High priority" : "Low priority"
        
        var trig = DateComponents()
    
        
        return true
    }
    
    func isAuthorizedForNotification() async -> Bool {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let settings = await notificationCenter.notificationSettings()
        
        switch settings.authorizationStatus {
        case .authorized:
            return true
        case .denied:
            return false
        default:
            return try! await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
        }
        
        
    }
    
}
