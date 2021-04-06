//
//  OptionsCell.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/04/05.
//

import UIKit

class OptionsCell: UITableViewCell {
    let lineView: UIView = {
        let v = UIView()
        v.backgroundColor = mainBackgroundDarkColor
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = mainColor
        
        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 5), size: CGSize(width: 0, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
