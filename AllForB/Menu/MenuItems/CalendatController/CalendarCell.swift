//
//  CalendarCell.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/12.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.borderColor = mainColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
