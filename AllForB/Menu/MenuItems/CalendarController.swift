//
//  CalendarController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit
import FSCalendar

class CalendarController: UIViewController {
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "Calendar"
        label.textAlignment = .center
        label.font = UIFont(name: "Veradana", size: 25)
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        
        return label
    }()
    
    let calendar: FSCalendar = {
       let c = FSCalendar()
        c.layer.borderWidth = 1
        c.scrollDirection = .vertical
        c.layer.borderColor = mainColor.cgColor
        c.appearance.headerTitleColor = mainColor
        c.appearance.titleWeekendColor = .red
        c.appearance.headerDateFormat = "YYYY년 MM월"
        c.appearance.selectionColor = mainColor
        c.appearance.titleTodayColor = .white
        c.appearance.titleDefaultColor = mainColor
        c.appearance.titleFont = UIFont(name: "Verdana", size: 15)
        c.appearance.headerTitleFont = UIFont(name: "Verdana-Bold", size: 16)
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        let weekDayLabel = calendar.calendarWeekdayView.weekdayLabels
        for weekDay in weekDayLabel {
            weekDay.textColor = mainColor
            weekDay.font = UIFont(name: "Verdana", size: 15)
        }

        view.addSubview(calendar)
        calendar.delegate = self
        calendar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: view.frame.size.height / 2.5))
        
    }
}

extension CalendarController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected: ", date)
    }
}
