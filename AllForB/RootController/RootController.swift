//
//  RootController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/02/26.
//

import UIKit

class RootController: UIViewController {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Logo_Orange"))
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = mainColor.cgColor
        return view
    }()
    
    let stayConnectedLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .left
        label.text = "로그인 후 사용하세요!"
        label.textColor = mainColor
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana-Bold", size: 30)
        return label
    }()

    let loginButon: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = mainColor
        button.setTitle("Log in  >", for: .normal)
        button.setTitleColor(mainBackgroundDarkColor, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}

extension RootController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundDarkColor
        setupContainer()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
    override open var shouldAutorotate: Bool {return false}
}

extension RootController {
    fileprivate func setupContainer() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 50, left: 50, bottom: 0, right: 50), size: CGSize(width: 0, height: 250))
        
        view.addSubview(containerView)
        containerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10), size: CGSize(width: 0, height: view.frame.size.height / 2.4))
        
        containerView.addSubview(stayConnectedLabel)
        stayConnectedLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 40, left: 30, bottom: 0, right: 20), size: CGSize(width: 0, height: 80))
        
        
        containerView.addSubview(loginButon)
        loginButon.centerXInSuperview()
        loginButon.anchor(top: nil, leading: nil, bottom: containerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 30, right: 0),size: CGSize(width: 150, height: 50))
        loginButon.layer.cornerRadius = 50/2
    }
}

extension RootController {
    @objc fileprivate func handleLogin() {
        if applicationDelegate.getCurrentLoginToken() == nil {
            let login = LoginController()
            login.modalPresentationStyle = .fullScreen
            present(login, animated: true, completion: nil)
        }
        else {
            userId = (applicationDelegate.getAnyValueFromCoreData(applicationDelegate.getCurrentLoginToken()!, "userId") as! Int)
            let mainPageController = MainPageController()
            mainPageController.modalPresentationStyle = .fullScreen
            present(mainPageController, animated: true, completion: nil)
        }
    }
}
