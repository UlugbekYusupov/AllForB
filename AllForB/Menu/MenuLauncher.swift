//
//  MenuLauncher.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.imageName = imageName
        self.name = name
    }
}

class MenuLauncher: NSObject {
    
    fileprivate let blackView = UIView()
    fileprivate let cellID = "cellID"
    private var menuTableView: UITableView!
    private let tableHeight: CGFloat = 40
    var mainPageController: MainPageController?
    var qrScannerController: QRScannerController?
    var loginController: LoginController?

    let settings: [Setting] = {
       return [Setting(name: "홈", imageName: "home1"),
               Setting(name: "프로필", imageName: "profile"),
               Setting(name: "근무일정", imageName: "calendar"),
               Setting(name: "출퇴근인증", imageName: "qrcode"),
               Setting(name: "설정", imageName: "setting")]
    }()
     
    let menuView: UIView = {
        let cv = UIView()
        cv.backgroundColor = mainBackgroundColor
        return cv
    }()
    
    let headerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .clear
        return cv
    }()
    
    let headerLine: UIView = {
        let cv = UIView()
        cv.backgroundColor = mainColor
        return cv
    }()
    
    let tableLine: UIView = {
        let cv = UIView()
        cv.backgroundColor = mainColor
        return cv
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "my"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let profileName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        label.clipsToBounds = true
        label.text = ""
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileEmail: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana", size: 13)
        label.clipsToBounds = true
        label.text = "bilmadim.uz@gmail.com"
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gwanglijaSettingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana", size: 20)
        label.clipsToBounds = true
        label.text = "관리자설정"
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let qrScanImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "qrcode"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let logoutImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "signout"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let qrScanButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.setTitle("QR Scan", for: .normal)
        button.setTitleColor(mainColor, for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(mainColor, for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let footerLine: UIView = {
        let cv = UIView()
        cv.backgroundColor = mainColor
        return cv
    }()
    
    override init() { super.init() }

    fileprivate func uiViewAnimation() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            self.blackView.alpha = 0
            self.menuView.frame = CGRect(x: -window.frame.width, y: 0, width: self.menuView.frame.width, height: self.menuView.frame.height)
        }
    }
}

extension MenuLauncher {
    func setupContainerViews() {
        menuView.addSubview(headerView)
        headerView.anchor(top: menuView.topAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: menuView.trailingAnchor,size: CGSize(width: 0, height: 150))
        headerView.addSubview(profileImageView)
        profileImageView.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 20, bottom: 20, right: 0),size: CGSize(width: 70, height: 70))
        profileImageView.layer.cornerRadius = 18
        
        headerView.addSubview(profileName)
        profileName.centerInSuperview(size: CGSize(width: 100, height: 20))
        
        headerView.addSubview(profileEmail)
        profileEmail.anchor(top: profileName.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: headerView.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 0),size: CGSize(width: 0, height: 20))
        
        let token = application.getCurrentLoginToken()
        let accountId = application.getAnyValueFromCoreData(token!, "accountId")
        DispatchQueue.main.async { [self] in
            profileEmail.text = (accountId as! String)
        }
        
        menuView.addSubview(headerLine)
        headerLine.anchor(top: headerView.bottomAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: menuView.trailingAnchor,size: CGSize(width: 0, height: 1))
        
        setupTabelView()
        
        menuView.addSubview(tableLine)
        tableLine.anchor(top: menuTableView.bottomAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: menuView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        menuView.addSubview(gwanglijaSettingLabel)
        gwanglijaSettingLabel.centerXInSuperview()
        gwanglijaSettingLabel.anchor(top: tableLine.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 30))
        
        menuView.addSubview(qrScanImageView)
        qrScanImageView.anchor(top: gwanglijaSettingLabel.bottomAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        
        menuView.addSubview(qrScanButton)
        qrScanButton.anchor(top: qrScanImageView.topAnchor, leading: qrScanImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 30))
        qrScanButton.addTarget(self, action: #selector(handleQRscan), for: .touchUpInside)
        
        menuView.addSubview(footerLine)
        footerLine.anchor(top: nil, leading: menuView.leadingAnchor, bottom: menuView.bottomAnchor, trailing: menuView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 100, right: 0), size: CGSize(width: 0, height: 1))
        
        menuView.addSubview(logoutImageView)
        logoutImageView.anchor(top: nil, leading: menuView.leadingAnchor, bottom: menuView.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        
        menuView.addSubview(logOutButton)
        logOutButton.anchor(top: logoutImageView.topAnchor, leading: logoutImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 30))
        logOutButton.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)

    }
    
    fileprivate func setupTabelView() {
        menuTableView = UITableView(frame: .zero, style: .plain)
        menuTableView.register(MenuCell.self, forCellReuseIdentifier: cellID)
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.backgroundColor = .clear
        menuView.addSubview(menuTableView)
        menuTableView.separatorStyle = .none
        menuTableView.isScrollEnabled = false
        let height = Int(tableHeight) * settings.count
        menuTableView.anchor(top: headerLine.bottomAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: menuView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: height))
    }
    
    func showSettings() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            setupContainerViews()

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window .frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlackTapDismiss)))

            window.addSubview(menuView)
            let width: CGFloat = window.frame.size.width / 1.4
            menuView.frame = CGRect(x: -window.frame.width, y: 0, width: width, height: window.frame.height)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.blackView.alpha = 1
                self.menuView.frame = CGRect(x: 0, y: 0, width: width, height: self.menuView.frame.height)
            } completion: { (flag) in }
        }
    }
}


extension MenuLauncher: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MenuCell
        cell.selectionStyle = .none
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableHeight
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = #colorLiteral(red: 0.0355408527, green: 0, blue: 0.1415036023, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.uiViewAnimation()
        } completion: { (flag) in
            let setting = self.settings[indexPath.item]
            self.mainPageController?.setting = setting
            self.mainPageController?.showController(indexPath: indexPath)
        }
    }
}

extension MenuLauncher {
    @objc fileprivate func handleLogoutButton() {
        application.clearDatabase()
        UserDefaults.standard.removeObject(forKey: "currentLoginToken")
        ProfileController.shared.userInfo.removeAll()
        self.mainPageController?.dismiss(animated: true, completion: nil)
        loginController = LoginController()
        loginController?.modalPresentationStyle = .fullScreen
        self.mainPageController?.present(loginController!, animated: false, completion: nil)
        
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.uiViewAnimation()
        } completion: { (flag) in }
    }
    
    @objc fileprivate func handleBlackTapDismiss(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.uiViewAnimation()
        } completion: { (flag) in
            self.qrScannerController?.captureSession.startRunning()
        }
    }
    
    @objc fileprivate func handleQRscan() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.uiViewAnimation()
        } completion: { (flag) in
            self.mainPageController?.showQRScannerController()
            self.mainPageController?.qrLabel.text = "QR Scanner"
        }
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.uiViewAnimation()
        } completion: { (flag) in
        }
    }
}
