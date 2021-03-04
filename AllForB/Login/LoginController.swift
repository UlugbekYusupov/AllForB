//
//  LoginController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/03.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Logo_Orange"))
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .red
        return iv
    }()
    
    var seePasswordStatus: Bool = true
    
    //아이디, 비밀번호
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .left
        label.textColor = mainColor
        label.text = "아이디"
//        label.backgroundColor = .yellow
        label.numberOfLines  = 0
        label.font = UIFont(name: "Verdana-Bold", size: 28)
        return label
    }()
    
    let yourUsernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = tf.placeholder ?? ""
        tf.clipsToBounds = true
        tf.contentMode = .scaleAspectFit
        tf.attributedPlaceholder = NSAttributedString(string: "Your username", attributes: [
            .foregroundColor: mainColor,
            .font: UIFont(name: "Verdana", size: 13) as Any
        ])
        tf.textColor = .white
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let userImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "user"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .red
        return iv
    }()
    
    let seePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "eye-o"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
//        button.backgroundColor = .red'
        button.addTarget(self, action: #selector(handleSeePassword), for: .touchUpInside)
        return button
    }()
    
    let passwordImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "lock"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .red
        return iv
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .left
        label.textColor = mainColor
        label.text = "비밀번호"
        label.numberOfLines  = 0
        label.font = UIFont(name: "Verdana-Bold", size: 28)
        return label
    }()
    
    let yourPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = tf.placeholder ?? ""
        tf.clipsToBounds = true
        tf.textColor = .white
        tf.contentMode = .scaleAspectFit
        tf.attributedPlaceholder = NSAttributedString(string: "Your password", attributes: [
            .foregroundColor: mainColor,
            .font: UIFont(name: "Verdana", size: 13) as Any
        ])
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
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
    
    
    let idLine: UIView = {
        let v = UIView()
        v.backgroundColor = mainColor
        return v
    }()
    
    let passwordLine: UIView = {
        let v = UIView()
        v.backgroundColor = mainColor
        return v
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = mainColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        setupContainer()
    }
}

extension LoginController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override open var shouldAutorotate: Bool {
        return false
    }
    
    @objc fileprivate func handleLogin() {
        
        guard let username = yourUsernameTextField.text else {return}
        guard let password = yourPasswordTextField.text else {return}
        let IsLoginSave: Bool = true
        
        if username.isEmpty || password.isEmpty {
            SharedClass.sharedInstance.alert(view: self, title: "Please enter", message: "")
            return
        } else {
            APIService.shared.loginRequest(username: username, password: password, IsLoginSave: IsLoginSave) { (result, error) in
                if let result = result {
                    if result["ReturnCode"] as! Int == 0 && result["AccountId"] as! String == username {
                        DispatchQueue.main.async {
                            let mainController  = MainPageController()
                            self.present(mainController, animated: false, completion: nil)
                        }
                    }
                    else {
                        SharedClass.sharedInstance.alert(view: self, title: "Incorrect !", message: "")
                    }
                }
                else if let error = error {
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc fileprivate func handleSeePassword() {
        if seePasswordStatus {
            seePasswordButton.setImage(#imageLiteral(resourceName: "eys"), for: .normal)
            seePasswordStatus = false
            yourPasswordTextField.isSecureTextEntry = false
        }
        else {
            seePasswordButton.setImage(#imageLiteral(resourceName: "eye-o"), for: .normal)
            seePasswordStatus = true
            yourPasswordTextField.isSecureTextEntry = true
        }
    }
}

extension LoginController {
    fileprivate func setupContainer() {
        view.addSubview(logoImageView)
        logoImageView.centerXInSuperview()
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0),size: CGSize(width: 180, height: 80))
        
        view.addSubview(containerView)
        containerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: view.frame.size.height / 1.3))
        
        //anchoring ID
        
        containerView.addSubview(idLabel)
        idLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 40, left: 40, bottom: 0, right: 40),size: CGSize(width: 150, height: 30))
        containerView.addSubview(userImageView)
        userImageView.anchor(top: idLabel.bottomAnchor, leading: idLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0),size: CGSize(width: 25, height: 25))
        containerView.addSubview(yourUsernameTextField)
        yourUsernameTextField.anchor(top: idLabel.bottomAnchor, leading: userImageView.trailingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 3, bottom: 0, right:40),size: CGSize(width: 0, height: 20))
        containerView.addSubview(idLine)
        idLine.anchor(top: userImageView.bottomAnchor, leading: userImageView.leadingAnchor, bottom: nil, trailing: yourUsernameTextField.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        //anchoring Password
        
        containerView.addSubview(passwordLabel)
        passwordLabel.anchor(top: idLine.bottomAnchor, leading: idLine.leadingAnchor, bottom: nil, trailing: idLine.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 30))
        containerView.addSubview(passwordImageView)
        passwordImageView.anchor(top: passwordLabel.bottomAnchor, leading: passwordLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0),size: CGSize(width: 25, height: 25))
        containerView.addSubview(yourPasswordTextField)
        yourPasswordTextField.anchor(top: passwordLabel.bottomAnchor, leading: passwordImageView.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 3, bottom: 0, right:40),size: CGSize(width: 250, height: 20))
        containerView.addSubview(passwordLine)
        passwordLine.anchor(top: passwordImageView.bottomAnchor, leading: passwordImageView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 40), size: CGSize(width: 0, height: 1))
        containerView.addSubview(seePasswordButton)
        seePasswordButton.anchor(top: nil, leading: nil, bottom: passwordLine.topAnchor, trailing: passwordLine.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: CGSize(width: 20, height: 20))
        
        // log in button
        
        containerView.addSubview(loginButton)
        loginButton.centerInSuperview(size: CGSize(width: 200, height: 50))
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
}
