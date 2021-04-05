//
//  OptionsCell.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/04/05.
//

import UIKit

class OptionsCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
