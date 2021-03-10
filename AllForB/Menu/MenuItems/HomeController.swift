//
//  HomeController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class HomeController: UIViewController {
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.textAlignment = .center
        label.textColor = mainColor
        label.font = UIFont(name: "Veradana-Bold", size: 30)
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        
        view.addSubview(homeLabel)
        homeLabel.centerInSuperview(size: CGSize(width: 200, height: 100))
    }
}
