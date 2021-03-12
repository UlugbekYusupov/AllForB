//
//  CalendarCell.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/12.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    
    let nalchaLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana-Bold", size: 15)
        return label
    }()
    
    let chulTweginLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana-Bold", size: 15)
        label.textColor = mainColor
        return label
    }()
    
    fileprivate func setupLayer() {
        layer.borderColor = mainColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayer()
        setupItems()
    }
    
    fileprivate func setupItems(){
        addSubview(nalchaLabel)
        nalchaLabel.centerXInSuperview()
        nalchaLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 5, left: 0, bottom: 0, right: 0),size: CGSize(width: 200, height: 50))
        
        addSubview(chulTweginLabel)
        chulTweginLabel.centerXInSuperview()
        chulTweginLabel.anchor(top: nalchaLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(),size: CGSize(width: 200, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
