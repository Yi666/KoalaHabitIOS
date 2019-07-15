//
//  MainPageController.swift
//  CalendarDemo
//
//  Created by Yi Liu on 11/5/17.
//  Copyright © 2017 Yi Liu. All rights reserved.
//

import UIKit
import AudioToolbox
import UserNotifications
import FirebaseDatabase
import FirebaseAuth
import Foundation

    var IconNum = [40,40,40,40,40,40]  //Six Habit Icon
    var PassingIconNum = 0
    var NameofHabits_Saving = ["","","","","",""]
    var HabitsCheckTime = ["","","","","",""]
    var HabitsDone = [false,false,false,false,false,false]
    var HabitsDoneDate_1 = [String]()
    var HabitsDoneDate_2 = [String]()
    var HabitsDoneDate_3 = [String]()
    var HabitsDoneDate_4 = [String]()
    var HabitsDoneDate_5 = [String]()
    var HabitsDoneDate_6 = [String]()




    var NotesStrings = [String]()
    var NotesSettingUpDate = [String]()
    var NotesRemindTime = [String]()
    var NotesNotDone = [Bool]()  //true means not done yet,initially with true
    var NotesColor = [Int]()

    var PassingString = ""
    var PassingNotesSettingUpDate = ""
    var PassingNotesTime = ""
    var PassingNotesFlag = 0
    var PassingNotesColor = 0



var NotesColorDatabase = ["1","2","3","4","5","6","7","8","9","10","11","1+O","2+O","3+O","4+O","5+O","6+O","7+O","8+O","9+O","10+O","11+O"]
    var MonthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonthIndex = Calendar.current.component(.month, from: Date())
    var currentDate = Calendar.current.component(.day, from: Date())
    var currentWeekday = Calendar.current.component(.weekday, from: Date())    //Get today's date

    var ShowYear = currentYear
    var ShowMonthIndex = currentMonthIndex
    var ShowDate = currentDate
    var ShowWeekday = currentWeekday    //Show this date, today is default

    var ShowNotesString = [String]()  //Only show notes on this day, find the notes text, remind time and the position
    var ShowNotesSettingUpDate = [String]()
    var ShowNotesRemindTime = [String]()
    var ShowNotesDone = [Bool]()
    var ShowNotesTag = [Int]()     //tag means the location of each showingnotes in the whole notes database
    var ShowNotesColor = [Int]()


class MainPageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate
{
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var isSideMenuHidden = true
    var WeekdayArray=["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var images=["a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14","a15","a16","a17","a18","a19","a20","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","b14","b15","b16","b17","b18","b19","b20","add"]
    var HabitLongGesture: UILongPressGestureRecognizer?

    
    
    @IBOutlet weak var MainPageMonth: UILabel!
    @IBOutlet weak var MainPageDay: UILabel!
    @IBOutlet weak var MainPageWeekday: UILabel!
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var HeadShotImage: UIImageView!
    @IBOutlet weak var HeadShotHeight: NSLayoutConstraint!
    
    @IBOutlet weak var HabitCollectionView: UICollectionView!
    
    
    // MARK: Button come to focus
    @IBAction func FocusPage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ComeToFocus", sender: self)
    }
    
    // Focus part
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    
    @IBOutlet weak var uiSlider: UISlider!
    
    var totalCount = 0
    
    @IBOutlet weak var focusMinute: UILabel!
    @IBOutlet weak var uiFocus: UIButton!
    
    @IBOutlet weak var FocusBackground: UIImageView!
    
    
    
    
    

    // @IBOutlet weak var HabitCellHeight: NSLayoutConstraint!
    @IBOutlet weak var NotesView: UITableView!
    @IBAction func AddNotes(_ sender: UIButton) {
        
        NotesStrings.append("")
        NotesSettingUpDate.append("")
        NotesRemindTime.append("Time")
        NotesNotDone.append(true)
        NotesColor.append(0)
        PassingString = NotesStrings[NotesStrings.count-1]
        PassingNotesSettingUpDate = NotesSettingUpDate[NotesSettingUpDate.count - 1]
        PassingNotesTime = NotesRemindTime[NotesRemindTime.count-1]
        PassingNotesFlag = NotesStrings.count - 1
        
    }
    
    @IBAction func BackToToday(_ sender: UIButton) {
        ShowYear = currentYear
        ShowMonthIndex = currentMonthIndex
        ShowDate = currentDate
        ShowWeekday = currentWeekday
        // back to today's date
        
        self.viewDidLoad()
    }
    
    
    @IBOutlet weak var MainPageBlur: UIVisualEffectView!
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: focus part
        ref = Database.database().reference()
        
        let currentDateline = String(currentYear)+String(currentMonthIndex)+String(currentDate)
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        let currentMinute = Calendar.current.component(.minute, from: Date())
        
        let userID = Auth.auth().currentUser!.uid
        
        handle = ref?.child("users").child(userID).child("Focus").child(currentDateline).observe(.childAdded, with: { (snapshot) in
            
            if let item = snapshot.value as? String
            {
                let itemArray = item.components(separatedBy: ",")
                let focusTime = itemArray[2]
                self.totalCount += Int(focusTime)!
                //self.myList.append(focusTime)
                //self.myTableView.reloadData()
                
            }
            print(self.totalCount)
            
            self.focusMinute.textColor = UIColor.white
            self.focusMinute.text = String("\(self.totalCount) min")
        })
        
        self.FocusBackground.backgroundColor = UIColor(red: 115/255.0, green: 140/255.0, blue: 199/255.0, alpha: 1)
        uiSlider.value = Float(currentHour*60+currentMinute)
        //uiSlider.maximumTrackTintColor = UIColor.white
        //uiSlider.minimumTrackTintColor = UIColor.white
        
        uiSlider.maximumTrackTintColor = UIColor(red: 115/255.0, green: 140/255.0, blue: 199/255.0, alpha: 1)
        uiSlider.minimumTrackTintColor = UIColor(red: 115/255.0, green: 140/255.0, blue: 199/255.0, alpha: 1)
        uiSlider.setThumbImage(UIImage(named: "focus_pin.png"), for: .normal)
        uiSlider.setThumbImage(UIImage(named: "focus_pin.png"), for: .highlighted)
        
        
        
        
        
        HeadShotImage.layer.cornerRadius = 8.0
        HeadShotImage.clipsToBounds = true
 
        
        sideMenuConstraint.constant = -375 //-375 is hiding the setting window
        MainPageBlur.frame.size.width = 375
        MainPageBlur.frame.size.height = 667
        MainPageBlur.center = CGPoint(x: 187.5, y: 333.5)
        MainPageBlur.isHidden = true
        MainPageBlur.alpha = 0.6
        
//HabitIcon CollectionView Layout
        let itemSize = 51
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        HabitCollectionView.collectionViewLayout = layout
        // HabitCellHeight.constant = CGFloat(itemSize)

        
//Calendar information
        MainPageMonth.text=MonthsArr[ShowMonthIndex-1]
        MainPageDay.text=String(ShowDate)
        MainPageWeekday.text=WeekdayArray[ShowWeekday-1]

        
        if NotesStrings.count >= 2
        {
            if NotesStrings[NotesStrings.count-1] == ""
            {
                NotesStrings.remove(at: NotesStrings.count - 1)
                NotesRemindTime.remove(at: NotesStrings.count - 1)
            }
        }
        else if NotesStrings.count == 1
        {
            if NotesStrings[NotesStrings.count-1] == ""
            {
            NotesStrings.removeAll()
            NotesRemindTime.removeAll()
            }
        }
        
        ShowNotesTag = []
        ShowNotesString = []
        ShowNotesDone = []
        ShowNotesSettingUpDate = []
        ShowNotesRemindTime = []
        ShowNotesColor = []
        PassingNotesColor = 0
        
        
        
        //每次都要清空之前显示的notes，重新读取应该在今天显示的notes
        NotesView.reloadData()
    
    
    

      //Notification setup
//        appDelegate?.ScheduleNotification()
//
        
//        let content = UNMutableNotificationContent()
//        content.title = NSString.localizedUserNotificationString(forKey: "Wake up!", arguments: nil)
//        content.body = NSString.localizedUserNotificationString(forKey: "Rise and shine! It's morning time!",
//                                                                arguments: nil)
//
//        // Configure the trigger for a 7am wakeup.
//        var dateInfo = DateComponents()
//        dateInfo.hour = 12
//        dateInfo.minute = 53
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
//
//        // Create the request object.
//        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let position = touch.location(in: view)
//            print(position)
//        }
//    }
//这个方法可以检测按键按到屏幕上没有内容的空白地方

//////////////////////////////////////////////////
//Playing with the Side View
    @IBAction func ListViewButton(_ sender: Any) {
        sideMenuConstraint.constant = -375
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.MainPageBlur.isHidden = true
        })
        isSideMenuHidden = true

    }
    
    @IBAction func MenuController(_ sender: UIButton) {
    
        if isSideMenuHidden {
            sideMenuConstraint.constant = 0

            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, animations: {

                self.MainPageBlur.isHidden = false
                
            })
            isSideMenuHidden = false
            
            AudioServicesPlaySystemSound(1520)
     
        }else{
            sideMenuConstraint.constant = -375
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.MainPageBlur.isHidden = true
                
            })
            isSideMenuHidden = true

        }

    }
    
    @IBAction func SwipeRight(_ sender: Any) {
        sideMenuConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.MainPageBlur.isHidden = false
        })
        isSideMenuHidden = false
    
    }
    
    @IBAction func SwipeLeft(_ sender: Any) {
        sideMenuConstraint.constant = -375
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.MainPageBlur.isHidden = true
        })
        isSideMenuHidden = true
   
    }
    

    
    
    
    
    
    
//////////////////////////////////////////////////
//Habit Icon Collection Viewcontroller
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HabitCell", for: indexPath) as! HabitCell
        if IconNum[indexPath.row] == 40      // “add” 符号
        {
            cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row]])
        }
        else if HabitsDone[indexPath.row] == true
            
        {
            if indexPath.row == 0
            {
                if HabitsDoneDate_1.contains(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))    // 有颜色的习惯
                {
                    cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row]])
                }
            }
            else if indexPath.row == 1
            {
                if HabitsDoneDate_2.contains(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))    // 有颜色的习惯
                {
                    cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row]])
                }
            }
            else if indexPath.row == 2
            {
                if HabitsDoneDate_3.contains(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))    // 有颜色的习惯
                {
                    cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row]])
                }
            }
            else if indexPath.row == 3
            {
                if HabitsDoneDate_4.contains(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))    // 有颜色的习惯
                {
                    cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row]])
                }
            }
            else if indexPath.row == 4
            {
                if HabitsDoneDate_5.contains(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))    // 有颜色的习惯
                {
                    cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row]])
                }
            }
            else
            {
                if HabitsDoneDate_6.contains(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))    // 有颜色的习惯
                {
                    cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row]])
                }
            }
            
            
        }
        else                                 // 灰色的习惯
        {
            cell.HabitIcon.image = UIImage(named: images[IconNum[indexPath.row] + 20])
        }

        return cell
    }
    
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let cellSize = CGSize(width: 73, height: 73)
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let DvC = mainStoryboard.instantiateViewController (withIdentifier: "HabitController") as! HabitController
        DvC.imageString = images[IconNum[indexPath.row]]
        PassingIconNum = IconNum[indexPath.row]
        IconNum[indexPath.row]=100
        present(DvC, animated: true, completion: nil)


    }
    
    
    
    
    
    
    @IBAction func LongPressHabit(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended
        {
            let location = sender.location(in: HabitCollectionView)
            print(location.x,location.y)
           if location.y>=0 && location.y <= 52
           {
                if location.x >= 0 && location.x <= 52 && IconNum[0] != 40
                {
                    AudioServicesPlaySystemSound(1520)
                    HabitsDone[0] = !HabitsDone[0]

                    if HabitsDone[0] == true
                    {
                        HabitsDoneDate_1.append(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))
                    }
                    if HabitsDone[0] == false
                    {
                        HabitsDoneDate_1.remove(at: HabitsDoneDate_1.index(of: String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))!)
                    }
                    
                    self.HabitCollectionView.reloadData()
                }
                else if location.x >= 58 && location.x <= 100 && IconNum[1] != 40
                {
                    AudioServicesPlaySystemSound(1520)
                    HabitsDone[1] = !HabitsDone[1]
             
                    if HabitsDone[1] == true
                    {
                        HabitsDoneDate_2.append(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))
                    }
                    if HabitsDone[1] == false
                    {
                        HabitsDoneDate_2.remove(at: HabitsDoneDate_2.index(of: String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))!)
                    }
                    self.HabitCollectionView.reloadData()
                }
                else if location.x >= 116 && location.x <= 168 && IconNum[2] != 40
                {
                    AudioServicesPlaySystemSound(1520)
                    HabitsDone[2] = !HabitsDone[2]
              
                    if HabitsDone[2] == true
                    {
                        HabitsDoneDate_3.append(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))
                    }
                    if HabitsDone[2] == false
                    {
                        HabitsDoneDate_3.remove(at: HabitsDoneDate_3.index(of: String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))!)
                    }
                    
                    self.HabitCollectionView.reloadData()
                }
                else if location.x >= 175 && location.x <= 227 && IconNum[3] != 40
                {
                    AudioServicesPlaySystemSound(1520)
                    HabitsDone[3] = !HabitsDone[3]
                   
                    if HabitsDone[3] == true
                    {
                        HabitsDoneDate_4.append(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))
                    }
                    if HabitsDone[3] == false
                    {
                        HabitsDoneDate_4.remove(at: HabitsDoneDate_4.index(of: String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))!)
                    }
                    
                    self.HabitCollectionView.reloadData()
                }
                else if location.x >= 233 && location.x <= 285 && IconNum[4] != 40
                {
                    AudioServicesPlaySystemSound(1520)
                    HabitsDone[4] = !HabitsDone[4]
                
                    if HabitsDone[4] == true
                    {
                        HabitsDoneDate_5.append(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))
                    }
                    if HabitsDone[4] == false
                    {
                        HabitsDoneDate_5.remove(at: HabitsDoneDate_5.index(of: String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))!)
                    }
                    
                    self.HabitCollectionView.reloadData()
                }
                else if location.x >= 292 && location.x <= 344 && IconNum[5] != 40
                {
                    AudioServicesPlaySystemSound(1520)
                    HabitsDone[5] = !HabitsDone[5]
                    
                    if HabitsDone[5] == true
                    {
                        HabitsDoneDate_6.append(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear))
                    }
                    if HabitsDone[5] == false
                    {


                        HabitsDoneDate_6.remove(at: HabitsDoneDate_6.index(of: String(String(format: "%02d",ShowMonthIndex)+"-"+String(format: "%02d",ShowDate)+"-"+String(format: "%02d",ShowYear)))!)
                    }
                    
                    self.HabitCollectionView.reloadData()
                }
                    
                    
                else{}
            }
           else{}
        }
    }


    
    

    
    
    
//////////////////////////////////////////////////
// Notes List View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        for i in 0..<NotesStrings.count    //我这个地方的逻辑有点麻烦，功能是：先检测是否有notes的提醒时间，有则在提醒当天显示notes，如果没有提醒时间则在编辑notes的那一天显示notes
        {
            var myText = Array(NotesRemindTime[i].characters)
            if myText.count >= 6
            {
                if String(myText[0]) + String(myText[1]) == String(format:"%02d",ShowMonthIndex) && String(myText[3]) + String(myText[4]) == String(format:"%02d",ShowDate) && String(myText[6]) + String(myText[7]) + String(myText[8]) + String(myText[9]) == String(ShowYear)
                {
                    if ShowNotesTag.contains(i){}
                    else
                    {
                       
                        ShowNotesString.append(NotesStrings[i])
                        ShowNotesSettingUpDate.append(NotesSettingUpDate[i])
                        ShowNotesRemindTime.append(NotesRemindTime[i])
                        ShowNotesDone.append(NotesNotDone[i])
                        ShowNotesColor.append(NotesColor[i])
                        ShowNotesTag.append(i)
                    }
                }
            }
            else
            {
                myText = Array(NotesSettingUpDate[i].characters)
                if String(myText[0]) + String(myText[1]) == String(format:"%02d",ShowMonthIndex) && String(myText[3]) + String(myText[4]) == String(format:"%02d",ShowDate) && String(myText[6]) + String(myText[7]) + String(myText[8]) + String(myText[9]) == String(ShowYear)
                {
                    if ShowNotesTag.contains(i){}
                    else
                    {
                        
                        ShowNotesString.append(NotesStrings[i])
                        ShowNotesSettingUpDate.append(NotesSettingUpDate[i])
                        ShowNotesRemindTime.append(NotesRemindTime[i])
                        ShowNotesDone.append(NotesNotDone[i])
                        ShowNotesColor.append(NotesColor[i])
                        ShowNotesTag.append(i)
                    }
                }
            }
        }
        
        return ShowNotesTag.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"NotesCell", for: indexPath) as! NotesCell
        
        cell.Notes.text = ShowNotesString[indexPath.row]
        cell.Notes.tag = indexPath.row
        cell.Notes.delegate = self
        cell.NotesButtonShow.tag = indexPath.row
       
        if NotesNotDone[cell.NotesButtonShow.tag]
        {
            cell.NotesButtonShow.setImage(UIImage(named:NotesColorDatabase[ShowNotesColor[indexPath.row]]), for: UIControlState.normal)
        }
        else
        {
            cell.NotesButtonShow.setImage(UIImage(named:NotesColorDatabase[ShowNotesColor[indexPath.row] + 11]), for: UIControlState.normal)
        }
     
        return cell
    }
    



    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("edit button tapped")

            PassingNotesFlag = ShowNotesTag[index.row]
            PassingString = ShowNotesString[index.row]
            PassingNotesSettingUpDate = ShowNotesSettingUpDate[index.row]
            PassingNotesTime = ShowNotesRemindTime[index.row]
            PassingNotesColor = ShowNotesColor[index.row]
            
 
            self.performSegue(withIdentifier: "ToNotesEdit", sender: self)
            
        }
        edit.backgroundColor = UIColor(red: 248/255.0, green: 191/255.0, blue: 101/255.0, alpha: 1)
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            print("delete button tapped")
            print(index.row)
            ShowNotesString.remove(at: index.row)
            ShowNotesSettingUpDate.remove(at: index.row)
            ShowNotesRemindTime.remove(at: index.row)
            ShowNotesDone.remove(at: index.row)
            ShowNotesColor.remove(at: index.row)
            NotesStrings.remove(at: ShowNotesTag[index.row])
            NotesSettingUpDate.remove(at: ShowNotesTag[index.row])
            NotesRemindTime.remove(at: ShowNotesTag[index.row])
            NotesNotDone.remove(at: ShowNotesTag[index.row])
            NotesColor.remove(at: ShowNotesTag[index.row])
            ShowNotesTag = []
            self.NotesView.reloadData()
            
            
        }
        delete.backgroundColor = UIColor(red: 239/255.0, green: 112/255.0, blue: 108/255.0, alpha: 1)
        
        return [delete, edit]
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        PassingNotesFlag = textField.tag
        return true
    }
    

}
