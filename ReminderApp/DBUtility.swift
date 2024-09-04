//
//  DBUtility.swift
//  ReminderApp
//
//  Created by Atharva.Kulkarni on 31/08/24.
//

import Foundation
import UIKit

struct DBUtility{
    
    static var instance = DBUtility()
    let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){
        
    }
    
    func addReminder(title:String, desc:String, date:Date, type:Int, priority: Bool) -> Bool{
        
       let rem = Reminder(context: dbContext)
        
        rem.title = title
        rem.type = Int16(type)
        rem.date = date
        rem.desc = desc
        rem.priority = priority
        
        
        do {
            try dbContext.save()
            
        }catch {
            print(error)
            return false
        }
        
        return true
    }
    
    func getAllReminders()-> [Reminder]{
        let fetchReq = Reminder.fetchRequest()
        do {
            let result = try dbContext.fetch(fetchReq)
           
            return result
            
        }catch {
            print(error)
            return []
        }
    }
    
    func deleteRem(rem: Reminder)-> Bool{
        
        dbContext.delete(rem)
        do {
            try dbContext.save()
            return true
        }catch {
            return false
        }
    }
    
}
