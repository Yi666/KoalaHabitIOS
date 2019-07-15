//
//  NotesEdit.swift
//  
//
//  Created by Yi Liu on 12/31/17.
//

import UIKit

class NotesEditController: UIViewController, UITextViewDelegate {
    
    @IBAction func NotesColor1(_ sender: UIButton) {
        PassingNotesColor = 0
    }
    @IBAction func NotesColor2(_ sender: UIButton) {
        PassingNotesColor = 1
    }
    @IBAction func NotesColor3(_ sender: UIButton) {
        PassingNotesColor = 2
    }
    @IBAction func NotesColor4(_ sender: UIButton) {
        PassingNotesColor = 3
    }
    @IBAction func NotesColor5(_ sender: UIButton) {
        PassingNotesColor = 4
    }
    @IBAction func NotesColor6(_ sender: UIButton) {
        PassingNotesColor = 5
    }
    @IBAction func NotesColor7(_ sender: UIButton) {
        PassingNotesColor = 6
    }
    @IBAction func NotesColor8(_ sender: UIButton) {
        PassingNotesColor = 7
    }
    @IBAction func NotesColor9(_ sender: UIButton) {
        PassingNotesColor = 8
    }
    @IBAction func NotesColor10(_ sender: UIButton) {
        PassingNotesColor = 9
    }
    @IBAction func NotesColor11(_ sender: UIButton) {
        PassingNotesColor = 10
    }
    
    
    
    
    


    @IBOutlet weak var NotesField: UITextView!
    @IBOutlet weak var DateField: UITextField!
    
    @IBOutlet weak var RemindSwitch: UISwitch!
    
    @IBAction func BackToMainpage(_ sender: UIButton) {
        PassingString = ""
        PassingNotesSettingUpDate = String(format: "%02d",currentMonthIndex)+"-"+String(format: "%02d",currentDate)+"-"+String(format: "%02d",currentYear)
        PassingNotesTime = "Time"
        
    }
    @IBOutlet weak var TextEditDone_Show: UIButton!
    @IBOutlet weak var DeleteNotes_Show: UIButton!

    @IBAction func TextEditDone(_ sender: UIButton) {
        NotesField.resignFirstResponder()
        UIView.animate(withDuration: 1, animations: {
 
 //       self.TextEditDone_Show.isHidden = true
        })
            

    }
    
    @IBAction func RemindSwitchTap(_ sender: UISwitch) {
        if RemindSwitch.isOn
        {
            print("\(RemindSwitch.isOn)")
            DateField.isHidden = false
            DatePicker()
            DateField.becomeFirstResponder()
        }
        else
        {
            print("\(RemindSwitch.isOn)")
            DateField.isHidden = true
        }
    }
    @IBAction func SaveNotes(_ sender: UIButton) {
        PassingString = NotesField.text!
        if DateField.text == "" || DateField.text == "Time"
        {
            PassingNotesSettingUpDate = String(format: "%02d",currentMonthIndex)+"-"+String(format: "%02d",currentDate)+"-"+String(format: "%02d",currentYear)
            PassingNotesTime = ""
        }
        else{
            PassingNotesSettingUpDate = String(format: "%02d",currentMonthIndex)+"-"+String(format: "%02d",currentDate)+"-"+String(format: "%02d",currentYear)
            PassingNotesTime = DateField.text!
        }
        NotesStrings[PassingNotesFlag] = PassingString
        NotesSettingUpDate[PassingNotesFlag] = PassingNotesSettingUpDate
        NotesRemindTime[PassingNotesFlag] = PassingNotesTime
        NotesColor[PassingNotesFlag] = PassingNotesColor
        
        print(NotesColor)
        print(PassingNotesSettingUpDate)
        print(PassingNotesTime)
        print(PassingString)
        
        performSegue(withIdentifier: "NotestoMainpage", sender: self)
    }


    @IBAction func DeleteNotes(_ sender: UIButton) {
        
        PassingString = ""
        PassingNotesSettingUpDate = ""
        PassingNotesTime = "Time"
        NotesStrings.remove(at: PassingNotesFlag)
        NotesSettingUpDate.remove(at: PassingNotesFlag)
        NotesRemindTime.remove(at: PassingNotesFlag)
        NotesColor.remove(at: PassingNotesFlag)
        
        PassingNotesColor = 0
            performSegue(withIdentifier: "NotestoMainpage", sender: self)
    }
    
    let picker = UIDatePicker()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DateField.isHidden = true
        NotesField.text = PassingString
        DateField.text = PassingNotesTime
        
        
       // TextEditDone_Show.isHidden = true
//        NotesField.delegate = self
    }
        


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
//        if text == "\n" {
//            NotesField.resignFirstResponder()
//            return false
//        }

       // self.TextEditDone_Show.isHidden = false
        
        return true
    }

    
    func  DatePicker()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: true)
        DateField.inputAccessoryView = toolbar
        DateField.inputView = picker
        picker.datePickerMode = .dateAndTime
    }
    
    @objc func donePressed()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy h:mm a"
        let dateString = formatter.string(from: picker.date)
        DateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
}






    
    
    

