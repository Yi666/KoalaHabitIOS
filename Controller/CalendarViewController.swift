//
//  CalendarViewController.swift
//  CalendarDemo
//
//  Created by Yi Liu on 1/12/18.
//  Copyright © 2018 Yi Liu. All rights reserved.
//

import UIKit
import AudioToolbox


class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var WeekdayArr = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    var MonthDaysCount = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var isSideMenuHidden = true
    var firstDayofMonth = 0

    @IBOutlet weak var presentMonth: UILabel!
    @IBOutlet weak var WeekdayView: UICollectionView!
    @IBOutlet weak var DateView: UICollectionView!
    
    @IBOutlet weak var SideMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var CalendarViewBlur: UIVisualEffectView!
    
    
    @IBAction func MenuController(_ sender: UIButton) {
        
        if isSideMenuHidden {
            SideMenuConstraint.constant = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, animations: {
                
                self.CalendarViewBlur.isHidden = false
                
            })
            isSideMenuHidden = false
            
            AudioServicesPlaySystemSound(1520)
            
        }else{
            SideMenuConstraint.constant = -375
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.CalendarViewBlur.isHidden = true
                
            })
            isSideMenuHidden = true
            
        }
        
    }
    
    @IBAction func SwipeRight(_ sender: Any) {
        SideMenuConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.CalendarViewBlur.isHidden = false
        })
        isSideMenuHidden = false
        
    }
    
    @IBAction func SwipeLeft(_ sender: Any) {
        SideMenuConstraint.constant = -375
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.CalendarViewBlur.isHidden = true
        })
        isSideMenuHidden = true
        
    }
    
    @IBAction func PreviousMonth(_ sender: UIButton) {
        if ShowMonthIndex == 1
        {
            ShowMonthIndex = 12
            ShowYear = ShowYear - 1
        }
        else
        {
            ShowMonthIndex = ShowMonthIndex - 1
        }
      
        self.viewDidLoad()
        self.DateView.reloadData()
    }
    
    @IBAction func NextMonth(_ sender: UIButton) {
        if ShowMonthIndex == 12
        {
            ShowMonthIndex = 1
            ShowYear = ShowYear + 1
        }
        else
        {
            ShowMonthIndex = ShowMonthIndex + 1
        }
 
        self.viewDidLoad()
        self.DateView.reloadData()
    }
    
    @IBAction func CalendarView(_ sender: UIButton) {
        SideMenuConstraint.constant = -375
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.CalendarViewBlur.isHidden = true
        })
        isSideMenuHidden = true
    }
    
    @IBAction func BackToToday(_ sender: UIButton) {
        ShowYear = currentYear
        ShowMonthIndex = currentMonthIndex
        ShowDate = currentDate
        ShowWeekday = currentWeekday
        // back to today's date
        
        self.viewDidLoad()
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstDayofMonth = (YearCalculation(Year: ShowYear) + MonthCalculation(Year:ShowYear,Month:ShowMonthIndex)+1) % 7
        if firstDayofMonth == 0
        {
            firstDayofMonth = 7
        }
        
        presentMonth.text = MonthsArr[ShowMonthIndex - 1]
        
        //Side Mwnu
        SideMenuConstraint.constant = -375
        CalendarViewBlur.frame.size.width = 375
        CalendarViewBlur.frame.size.height = 667
        CalendarViewBlur.center = CGPoint(x: 187.5, y: 333.5)
        CalendarViewBlur.isHidden = true
        CalendarViewBlur.alpha = 0.6
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//计算每月第一天在周几
    func YearCalculation (Year:Int)-> Int
    {
        var Days = (Year - 2012) * 365 + Int(Year - 2013)/4 + 1
        return Days

    }
    func MonthCalculation (Year: Int,Month: Int) -> Int
    {
        var Days = 0
        if (Year - 2016) % 4 == 0
        {
            if Month == 1{Days = 0}
            else if Month == 2{Days = 31}
            else if Month == 3{Days = 31+29}
            else if Month == 4{Days = 31+29+31}
            else if Month == 5{Days = 31+29+31+30}
            else if Month == 6{Days = 31+29+31+30+31}
            else if Month == 7{Days = 31+29+31+30+31+30}
            else if Month == 8{Days = 31+29+31+20+31+30+31}
            else if Month == 9{Days = 31+29+31+30+31+30+31+31}
            else if Month == 10{Days = 31+29+31+30+31+30+31+31+30}
            else if Month == 11{Days = 31+29+31+30+31+30+31+31+30+31}
            else if Month == 12{Days = 31+29+31+30+31+30+31+31+30+31+30}
        }
        else
        {
            if Month == 1{Days = 0}
            else if Month == 2{Days = 31}
            else if Month == 3{Days = 31+28}
            else if Month == 4{Days = 31+28+31}
            else if Month == 5{Days = 31+28+31+30}
            else if Month == 6{Days = 31+28+31+30+31}
            else if Month == 7{Days = 31+28+31+30+31+30}
            else if Month == 8{Days = 31+28+31+30+31+30+31}
            else if Month == 9{Days = 31+28+31+30+31+30+31+31}
            else if Month == 10{Days = 31+28+31+30+31+30+31+31+30}
            else if Month == 11{Days = 31+28+31+30+31+30+31+31+30+31}
            else if Month == 12{Days = 31+28+31+30+31+30+31+31+30+31+30}
        }
        return Days
    }
    
    
    
//set up the calendar collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.WeekdayView {
            return 7
        }
        else{
            return 42
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell{
 
        if collectionView == self.WeekdayView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"WeekdayCell", for: indexPath) as! WeekdayCell
            cell.WeekdayLabel.text = WeekdayArr[indexPath.row]
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DateCell", for: indexPath) as! DateCell
            if indexPath.row < (firstDayofMonth - 1)
            {
                cell.DateLabel.textColor = UIColor.lightGray //改变上个月和下个月的日期颜色为灰色
                if ShowMonthIndex == 1
                {
                    cell.DateLabel.text = String(indexPath.row - firstDayofMonth + 33)
                    
                    cell.ThisDayYear=ShowYear-1
                    cell.ThisDayMonthIndex = 12
                    cell.ThisDayDate = indexPath.row - firstDayofMonth + 33  //有必要知道每一个cell对应的年，月，日
                }
                else
                {
                     cell.DateLabel.text = String(indexPath.row - firstDayofMonth + MonthDaysCount[ShowMonthIndex-2] + 2)
                    
                    cell.ThisDayYear=ShowYear
                    cell.ThisDayMonthIndex = ShowMonthIndex - 1
                    cell.ThisDayDate = indexPath.row - firstDayofMonth + MonthDaysCount[ShowMonthIndex-2] + 2
                }
            }
            else if ShowYear % 4 == 0 && ShowMonthIndex == 2
            {
                if (indexPath.row - (firstDayofMonth - 1) + 1) > (MonthDaysCount[ShowMonthIndex-1] + 1)
                {
                    cell.DateLabel.textColor = UIColor.lightGray
                    cell.DateLabel.text = String((indexPath.row - (firstDayofMonth - 1) + 1) - (MonthDaysCount[ShowMonthIndex
                         - 1]) - 1)
                    
                    
                    if ShowMonthIndex == 12{cell.ThisDayYear=ShowYear + 1;cell.ThisDayMonthIndex = 1}else{cell.ThisDayMonthIndex = ShowMonthIndex + 1}
                    cell.ThisDayDate = (indexPath.row - (firstDayofMonth - 1) + 1) - (MonthDaysCount[ShowMonthIndex
                        - 1])
 
                }
                else
                {
                    cell.DateLabel.textColor = UIColor.black
                    cell.DateLabel.text = String(indexPath.row - (firstDayofMonth - 1) + 1)
                    
                    cell.ThisDayYear=ShowYear
                    cell.ThisDayMonthIndex = ShowMonthIndex
                    cell.ThisDayDate = (indexPath.row - (firstDayofMonth - 1) + 1)

                }
            }
            else
            {
                
                if (indexPath.row - (firstDayofMonth - 1) + 1) >  MonthDaysCount[ShowMonthIndex - 1]
                {
                    cell.DateLabel.textColor = UIColor.lightGray
                    cell.DateLabel.text = String((indexPath.row - (firstDayofMonth - 1) + 1) - (MonthDaysCount[ShowMonthIndex - 1]))
                    
                    cell.ThisDayYear=ShowYear
                    if ShowMonthIndex == 12{cell.ThisDayYear=ShowYear + 1;cell.ThisDayMonthIndex = 1}else{cell.ThisDayMonthIndex = ShowMonthIndex + 1}
                    cell.ThisDayDate = (indexPath.row - (firstDayofMonth - 1) + 1) - (MonthDaysCount[ShowMonthIndex - 1])
                    
                }
                else
                {
                    cell.DateLabel.textColor = UIColor.black
                    cell.DateLabel.text = String(indexPath.row - (firstDayofMonth - 1) + 1)
                    
                    
                    cell.ThisDayYear = ShowYear
                    cell.ThisDayMonthIndex = ShowMonthIndex
                    cell.ThisDayDate = indexPath.row - (firstDayofMonth - 1) + 1
                }
            }
            
            if cell.ThisDayDate == currentDate && cell.ThisDayMonthIndex == currentMonthIndex && cell.ThisDayYear == currentYear
            {
                cell.DateLabel.backgroundColor = UIColor(red: 115/255, green: 140/255, blue: 199/255, alpha: 1.00)
                cell.DateLabel.textColor = UIColor.white
            }
            
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.WeekdayView
        {}
        else
        {
            let cell = collectionView.cellForItem(at: indexPath) as? DateCell
            ShowYear = (cell?.ThisDayYear)!
            ShowMonthIndex = (cell?.ThisDayMonthIndex)!
            ShowDate = (cell?.ThisDayDate)!
            performSegue(withIdentifier: "CalendarViewToMainPage", sender: self)
        }
    }
    
    
    
    
    
    
}


