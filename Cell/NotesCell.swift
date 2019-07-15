//
//  NotesCell.swift
//  CalendarDemo
//
//  Created by Yi Liu on 12/30/17.
//  Copyright © 2017 Yi Liu. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell,UITextFieldDelegate{

    @IBOutlet weak var NotesButtonShow: UIButton!
    
    @IBOutlet weak var Notes: UITextField!

    @IBAction func NotesWrite(_ sender: UITextField) {
        NotesStrings[PassingNotesFlag] = Notes.text!
    }
    
    
    
    @IBAction func NotesButton(_ sender: UIButton) {
        if NotesNotDone[NotesButtonShow.tag]
        {
        NotesButtonShow.setImage(UIImage(named:NotesColorDatabase[ShowNotesColor[NotesButtonShow.tag] + 11]), for: UIControlState.normal)
            NotesNotDone[NotesButtonShow.tag] = false
        }
        else
        {
        NotesButtonShow.setImage(UIImage(named:NotesColorDatabase[ShowNotesColor[NotesButtonShow.tag]]), for: UIControlState.normal)
            NotesNotDone[NotesButtonShow.tag] = true
        }
    }
//
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        let string = Notes.text
//        let needle: Character = "."
//        print(Notes.text)
//        if let idx = string?.characters.index(of: needle) {
//            Notes.resignFirstResponder()
//        }
//        else {
//            print("Not found")
//        }
//
//    }


  

    
}
