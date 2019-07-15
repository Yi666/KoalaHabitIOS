//
//  DateCell.swift
//  CalendarDemo
//
//  Created by Yi Liu on 1/12/18.
//  Copyright © 2018 Yi Liu. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CalendarNotesTableView: UITableView!
    
    var ThisDayYear:Int = 0
    var ThisDayMonthIndex:Int = 0
    var ThisDayDate:Int = 0 //依次为每一天的年，月，日
    var CalendarNotesTag:[(Int)] = []
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        CalendarNotesTableView.delegate = self
        CalendarNotesTableView.dataSource = self
      
    }
    

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            for i in 0..<NotesStrings.count
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
            
            return CalendarNotesTag.count
    }
    
    
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier:"CalendarNotesCell", for: indexPath) as! CalendarNotesCell
            cell.CalendarNotesLabel.text = NotesStrings[CalendarNotesTag[indexPath.row]]
            return cell
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
                return 10//Choose your custom row height
        }
    

}
