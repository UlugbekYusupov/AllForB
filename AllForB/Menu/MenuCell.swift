//
//  MenuCell.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class MenuCell: UITableViewCell {
    
    let itemImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "setting"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var setting: Setting? {
        didSet {
            itemLabel.text = setting?.name
            itemImageView.image = UIImage(named: setting!.imageName)
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            itemLabel.textColor = !isHighlighted ? mainColor : #colorLiteral(red: 0.0355408527, green: 0, blue: 0.1415036023, alpha: 1)
            itemImageView.tintColor = isHighlighted ? .clear : #colorLiteral(red: 0.0355408527, green: 0, blue: 0.1415036023, alpha: 1)
        }
    }
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
//        label.textColor = mainColor
        label.font = UIFont(name: "Verdana", size: 16)
        label.clipsToBounds = true
        label.text = "Ulugbek"
        label.backgroundColor = .clear
        label.contentMode = .scaleAspectFill
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        
        addSubview(itemImageView)
        itemImageView.centerYInSuperview()
        itemImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(), size: CGSize(width:35, height: 35))
        
        addSubview(itemLabel)
        itemLabel.centerYInSuperview()
        itemLabel.anchor(top: nil, leading: itemImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: CGSize(width: 100, height: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
