//
//  MenuCell.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class MenuCell: UITableViewCell {
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana", size: 16)
        label.clipsToBounds = true
        label.text = "Ulugbek"
//        label.backgroundColor = .red
        label.contentMode = .scaleAspectFill
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(itemLabel)
        itemLabel.centerYInSuperview()
        itemLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: CGSize(width: 100, height: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
