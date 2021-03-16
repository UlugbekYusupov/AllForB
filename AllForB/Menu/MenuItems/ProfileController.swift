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
    
    let stackViewContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = "이름 :"
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()
    
    let jobRankNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = "직급 :"
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()

    let dutyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = "직책 :"
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()

    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = "회사명 :"
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()
    
    
    let profileName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = ""
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()
    
    let ProfileName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = ""
        label.font = UIFont(name: "Verdana-Bold", size: 22)
        return label
    }()
    
    let jobRankName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = ""
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()

    let dutyName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = ""
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()

    let companyName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = mainColor
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.text = ""
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()

    let bottomLine: UIView = {
        let v = UIView()
        v.backgroundColor = mainColor
        return v
    }()
    
    var labelStackView: UIStackView?
    var nameStackView: UIStackView?
    
    static let shared = ProfileController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        view.addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: 50, left: 20, bottom: 50, right: 20))
        containerView.addSubview(profileImageView)
       
        setupChildViews()
        fetchUserInfo()
    }
    
    fileprivate func setupChildViews() {
        profileImageView.centerXInSuperview()
        profileImageView.anchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0),size: CGSize(width: 100, height: 100))
        profileImageView.layer.cornerRadius = 20
        
        containerView.addSubview(bottomLine)
        bottomLine.centerYInSuperview()
        bottomLine.anchor(top: nil, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 1))
        containerView.addSubview(ProfileName)
        ProfileName.centerXInSuperview()
        ProfileName.anchor(top: nil, leading: nil, bottom: bottomLine.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 30, right: 0), size: CGSize(width: 100, height: 30))
        
        containerView.addSubview(stackViewContainer)
        stackViewContainer.anchor(top: bottomLine.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 70, right: 40), size: CGSize(width: 0, height: 0))
        
        labelStackView = UIStackView(arrangedSubviews: [profileNameLabel, jobRankNameLabel,dutyNameLabel,companyNameLabel])
        labelStackView!.axis  = .vertical
        labelStackView!.distribution  = .equalCentering
        labelStackView!.alignment = .center
        labelStackView!.spacing   = 0
        labelStackView?.translatesAutoresizingMaskIntoConstraints = false
        labelStackView?.backgroundColor = .clear

        stackViewContainer.addSubview(labelStackView!)
        labelStackView?.anchor(top: stackViewContainer.topAnchor, leading: stackViewContainer.leadingAnchor, bottom: stackViewContainer.bottomAnchor, trailing: nil ,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: stackViewContainer.frame.size.width / 2, height: 0))
        
        
        nameStackView = UIStackView(arrangedSubviews: [profileName, jobRankName,dutyName,companyName])
        nameStackView!.axis  = .vertical
        nameStackView!.distribution  = .equalCentering
        nameStackView!.alignment = .center
        nameStackView!.spacing   = 0
        nameStackView?.translatesAutoresizingMaskIntoConstraints = false
        nameStackView?.backgroundColor = .clear

        stackViewContainer.addSubview(nameStackView!)
        nameStackView!.centerYInSuperview()
        nameStackView?.anchor(top: stackViewContainer.topAnchor, leading: labelStackView?.trailingAnchor, bottom: stackViewContainer.bottomAnchor, trailing: stackViewContainer.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 0))
        
    }
    
    var userInfo = [UserInfo]()
    fileprivate func fetchUserInfo() {
        APIService.shared.getInfo(userId: 1, companyId: 1) { [self] (result, error) in
            guard let result = result else {return}
            userInfo.append(result)
            print(userInfo)
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async { [self] in
                userInfo.forEach { (user) in
                    ProfileName.text = user.PersonName
                    profileName.text = user.PersonName
                    jobRankName.text = user.JobRankCodeName
                    dutyName.text = user.DutyCodeName
                    companyName.text = user.CompanyName
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.userInfo.removeAll()
    }
}
