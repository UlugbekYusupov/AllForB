//
//  NoticeCell.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/04/05.
//

import UIKit

class NoticeCell: UICollectionViewCell {
    
    let nameOfNotice: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.text = "Title of Notice"
        label.textColor = mainColor
        label.backgroundColor = .clear
        label.font = UIFont(name: "Verdana", size: 18)
        return label
    }()
    
    let descriptionOfNotice: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.text = "Description of Notice, explanations and examples"
        label.textColor = mainColor
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1
        v.layer.borderColor = mainColor.cgColor
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCellItems(){
        addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: 5, left: 15, bottom: 5, right: 15))
        containerView.addSubview(nameOfNotice)
        nameOfNotice.centerXInSuperview()
        nameOfNotice.anchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 50))
        
        containerView.addSubview(descriptionOfNotice)
        descriptionOfNotice.centerXInSuperview()
        descriptionOfNotice.anchor(top: nameOfNotice.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 300, height: 50))
    }
}
