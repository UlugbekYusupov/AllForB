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
//        iv.backgroundColor = .red
        return iv
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 25
//        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        view.layer.borderWidth = 1
        view.layer.borderColor = mainColor.cgColor
        return view
    }()
    
    let stayConnectedLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .left
        label.text = "Stay connected with\neveryone!"
        label.textColor = mainColor
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana-Bold", size: 28)
        return label
    }()
    
    let signLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .left
        label.text = "Sign in with account"
        label.textColor = mainColor
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana", size: 15)
        return label
    }()
    
    let loginButon: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = mainColor
        button.setTitle("Log in  >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        setupContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }

    
    fileprivate func setupContainer() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 50, left: 50, bottom: 0, right: 50), size: CGSize(width: 0, height: 250))
        
        view.addSubview(containerView)
        containerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: view.frame.size.height / 2.4))
        
        containerView.addSubview(stayConnectedLabel)
        stayConnectedLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 40, left: 30, bottom: 0, right: 20), size: CGSize(width: 0, height: 80))
        
        containerView.addSubview(signLabel)
        signLabel.anchor(top: stayConnectedLabel.bottomAnchor, leading: stayConnectedLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 20))
        
        containerView.addSubview(loginButon)
        loginButon.centerXInSuperview()
        loginButon.anchor(top: nil, leading: nil, bottom: containerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 30, right: 0),size: CGSize(width: 150, height: 50))
        loginButon.layer.cornerRadius = 50/2
    }
    
    @objc fileprivate func handleLogin() {
        if application.getCurrentLoginToken() == nil {
            let login = LoginController()
            login.modalPresentationStyle = .fullScreen
//            view.addSubview(login.view)
//            login.didMove(toParent: self)

            present(login, animated: true, completion: nil)
        }
        else {
            let mainPageController = MainPageController()
            mainPageController.modalPresentationStyle = .fullScreen

            present(mainPageController, animated: true, completion: nil)
        }
    }
}
