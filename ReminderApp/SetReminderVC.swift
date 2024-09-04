//
//  SetReminderVCViewController.swift
//  ReminderApp
//
//  Created by Atharva.Kulkarni on 31/08/24.
//

import UIKit

class SetReminderVC: UIViewController {
    
    var type: Int = 0
    var date: Date = Date()
    var priority: Bool = true

    @IBAction func setB(_ sender: UIButton) {
        
        let title = titleTF.text ?? ""
        let desc = descTV.text ?? ""
        
        if  title.isEmpty {
            showAlert(msg: "Pls provide all info")
        }
        else {
            if (DBUtility.instance.addReminder(title: title, desc: desc, date: date, type: type, priority: priority))
                {
                print(dateTimeDP.timeZone?.localizedName(for: .standard, locale: .current) ?? "")
                print(date)
                
              navigationController?.popViewController(animated: true)
            }else {
                showAlert(msg: "Error adding reminder ")
            }
        }
        
        
        
    }
    
    @IBAction func typeSC(_ sender: UISegmentedControl) {
        type = typeSC.selectedSegmentIndex
    }
    @IBAction func dateTimeDP(_ sender: UIDatePicker) {
    
    
        date = dateTimeDP.date

        
        var dateFormatter = DateFormatter()
        dateFormatter.timeZone = dateTimeDP.timeZone
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        let dateStr = dateFormatter.string(from: date)
        print(dateStr)
        
    }
    @IBAction func prioritySW(_ sender: UISwitch) {
       
        priority = prioritySW.isOn
    }
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var dateTimeDP: UIDatePicker!
    
    @IBOutlet weak var setB: UIButton!
    @IBOutlet weak var typeSC: UISegmentedControl!
    @IBOutlet weak var prioritySW: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Set Reminder"
        
        titleTF.becomeFirstResponder()
        
        titleTF.layer.cornerRadius = 5
        titleTF.layer.borderWidth = 1
        titleTF.layer.borderColor = UIColor.lightGray.cgColor
        
        dateTimeDP.minimumDate = Date()
        
        
        descTV.layer.cornerRadius = 5
        descTV.layer.borderWidth = 1
        descTV.layer.borderColor = UIColor.lightGray.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
