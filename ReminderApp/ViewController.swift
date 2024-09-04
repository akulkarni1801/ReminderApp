//
//  ViewController.swift
//  ReminderApp
//
//  Created by Atharva.Kulkarni on 30/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tbl: UITableView!
    
    var reminderList: [Reminder] = []
    var isAuthorized = false

    @IBOutlet weak var AddRemB: UIBarButtonItem!
    
    @IBAction func AddRemB(_ sender: UIBarButtonItem) {
        let vc = storyboard!.instantiateViewController(identifier: "setReminder")
        show(vc, sender: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reminderList = DBUtility.instance.getAllReminders()
        tbl.reloadData()
        
        Task {
            isAuthorized = await isAuthorizedForNotification()
        }
        
    }
    
    override func viewDidLoad() {
        
        tbl.dataSource = self
        tbl.delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(NSHomeDirectory())
        
    }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rem = tableView.dequeueReusableCell(withIdentifier: "remCell", for: indexPath) as! ReminderCell
        
        let remlist = reminderList[indexPath.row]
        
        rem.titleL.text = remlist.title
        
        rem.priorityL.text = remlist.priority ? "High" : "Low"
        if let image = UIImage(systemName: remlist.priority ? "timer" : "clock") {
            rem.imgIV.image = image.withRenderingMode(.alwaysTemplate)
            rem.imgIV.tintColor = remlist.priority ? .systemRed : .systemGreen
        }

        
        return rem
        
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let remToDelete = reminderList[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") {[weak self] _, _, _ in
            
            if (DBUtility.instance.deleteRem(rem: remToDelete)){
                self?.reminderList.remove(at: indexPath.row)
                //self?.empList = DBUtility.instance.getAllEmployees()
                self?.tbl.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ViewController: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        
        print("App in foreground")
        return .banner
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        
        print("App in background")
        if response.notification.request.identifier == "test1" {
            print("time Interval notification ")
        }
    }
}
