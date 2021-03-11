//
//  ProfileController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class ProfileController: UIViewController {
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textAlignment = .center
        label.font = UIFont(name: "Veradana", size: 25)
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "my"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.heightAnchor.constraint(equalToConstant: 130).isActive = true
//        iv.widthAnchor.constraint(equalToConstant: 130).isActive = true
        return iv
    }()

    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = mainBackgroundColor
        v.layer.cornerRadius = 20
        v.layer.borderWidth = 1
        v.layer.borderColor = mainColor.cgColor
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        
        view.addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: 50, left: 20, bottom: 50, right: 20))
        
        containerView.addSubview(profileImageView)
        profileImageView.centerXInSuperview()
        profileImageView.anchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: CGSize(width: 100, height: 100))
        
        profileImageView.layer.cornerRadius = 20
    }
}
