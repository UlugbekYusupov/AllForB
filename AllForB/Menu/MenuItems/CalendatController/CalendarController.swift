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
    
    var dailyListCollectionTable: UICollectionView?
    var fromDate = ""
    var toDate = ""
    let formatter = DateFormatter()
    var resultList = [ResultList]()

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
        
        setupCollectionView()
        setupMonthFormattedString()
        fetchCall()
    }
    
    
    func setupMonthFormattedString() {
        let nextMonth = self.calendar.currentPage.getNextMonth()
        formatter.dateFormat = "yyyy-MM-dd"
        self.fromDate = formatter.string(from: nextMonth!)
        
        let previosMonth = self.calendar.currentPage.getPreviousMonth()
        formatter.dateFormat = "yyyy-MM-dd"
        self.toDate = formatter.string(from: previosMonth!)
    }
    
    
    
    fileprivate func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        dailyListCollectionTable = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dailyListCollectionTable?.backgroundColor = .clear
        dailyListCollectionTable?.register(CalendarCell.self, forCellWithReuseIdentifier: "cellID")
        dailyListCollectionTable?.dataSource = self
        dailyListCollectionTable?.delegate = self
        dailyListCollectionTable?.showsVerticalScrollIndicator = false
        
        view.addSubview(dailyListCollectionTable!)
        dailyListCollectionTable?.anchor(top: calendar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 40, left: 40, bottom: 40, right: 40))
        
    }
        
    fileprivate func fetchCall() {
        APIService.shared.getDailyList(userId: 1, fromDate: self.fromDate + " 00:00:00", toDate: self.toDate + " 00:00:00") { (result, error) in
            guard let result = result else {return}
            self.resultList = result
            DispatchQueue.main.async {
                self.dailyListCollectionTable?.reloadData()
            }
            
            if let error = error {
                print(error)
            }
        }
    }
}


extension CalendarController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        

    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        setupMonthFormattedString()
        DispatchQueue.main.async {
            self.fetchCall()
            self.dailyListCollectionTable?.reloadData()
        }
    }
}

extension CalendarController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CalendarCell
        
        let issueDate = resultList[indexPath.row].IssueDate
        let inOutTimeInfo = resultList[indexPath.row].InOutTimeInfo
        
        cell.nalchaLabel.text = "날짜: " + issueDate!
        cell.chulTweginLabel.text = inOutTimeInfo

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (dailyListCollectionTable?.frame.width)!, height: (dailyListCollectionTable?.frame.size.height)! / 2)
    }

}
