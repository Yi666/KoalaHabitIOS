//
//  HabitController.swift
//  CalendarDemo
//
//  Created by Yi Liu on 11/22/17.
//  Copyright © 2017 Yi Liu. All rights reserved.
//

import UIKit


class HabitController: UIViewController, UICollectionViewDataSource, UITextFieldDelegate, UICollectionViewDelegate {



    var location = 0
    @IBOutlet weak var BigHabitIcon: UIImageView!
    @IBOutlet weak var HabitPoolView: UICollectionView!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var NameOfHabit: UITextField!
    
    @IBOutlet weak var CustomIcons: UILabel!
    
    
    @IBAction func SelectionDone(_ sender: Any) {
        if IconNum[location] == 100
        {
            IconNum[location] = PassingIconNum
            HabitsCheckTime[location] = DateField.text!
            NameofHabits_Saving[location] = NameOfHabit.text!
        }
        else
        {
            HabitsCheckTime[location] = DateField.text!
            NameofHabits_Saving[location] = NameOfHabit.text!
        }
    }
    
    
    @IBAction func TextEditDone(_ sender: UIButton) {
        NameOfHabit.resignFirstResponder()
    }

    
    @IBAction func BackToMainPage(_ sender: Any) {
        
        IconNum[location] = PassingIconNum
        performSegue(withIdentifier: "BackToMainPage", sender:self)
    }
    
    let picker = UIDatePicker()
    var images=["a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14","a15","a16","a17","a18","a19","a20"]
    var imageString = String()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HabitIconPoolCell", for: indexPath) as! HabitIconPoolCell
        
        cell.HabitIconPool.image = UIImage(named:images[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        BigHabitIcon.image = UIImage(named: images[indexPath.row])
        IconNum[location] = indexPath.row
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameOfHabit.delegate = self
        
        BigHabitIcon.image = UIImage(named:imageString)
        CustomIcons.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        
        
//set up the Habit Icon Pool View
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: 52, height: 52)
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        HabitPoolView.collectionViewLayout = layout
        //HabitCellHeight.constant = CGFloat(itemSize)
        location = IconNum.index(of: 100)!
        

        NameOfHabit.text = NameofHabits_Saving[location]
        if HabitsCheckTime[location] != ""
        {
        DateField.text = HabitsCheckTime[location]
        }
        else
        {
            DateField.text = "Time"
        }
        


//set up the time picker
        createDatePicker()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NameOfHabit.resignFirstResponder()
        return true
    }
    
    
    func  createDatePicker()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: true)
        DateField.inputAccessoryView = toolbar
        DateField.inputView = picker
        picker.datePickerMode = .time
    }
    
    
    
    
//Set up the time picker
    @objc func donePressed()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm  a"
        let dateString = formatter.string(from: picker.date)
        DateField.text = "\(dateString)"
        self.view.endEditing(true)
    }

}
