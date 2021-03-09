//
//  MenuLauncher.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class MenuLauncher: NSObject {
    
    fileprivate let blackView = UIView()
    fileprivate let cellID = "cellID"

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
        let iv = UIImageView(image: #imageLiteral(resourceName: "photo_2021-02-22 18.51.39"))
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
        label.text = "Ulugbek"
//        label.backgroundColor = .black
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
//        label.backgroundColor = .black
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
//        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let qrScanButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("QR Scan", for: .normal)
        button.setTitleColor(mainColor, for: .normal)
        button.contentMode = .scaleAspectFit
        
//        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var menuTableView: UITableView!
    private let tableSize: CGFloat = 50
    private let tableNumber: Int = 5
    private var imageStackView: UIStackView!
    let icons = [#imageLiteral(resourceName: "home1"),#imageLiteral(resourceName: "profile"),#imageLiteral(resourceName: "clander"),#imageLiteral(resourceName: "qrcode"),#imageLiteral(resourceName: "setting")]
    var iconImageViews = [UIImageView]()
    let labels = ["홈","프로필","근무일정","출퇴근인증","설정"]
    
    override init() {
        super.init()
        setupContainerViews()
    }
    
    func showSettings() {
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window .frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlackTapDismiss)))
            
            window.addSubview(menuView)
            let width: CGFloat = window.frame.size.width / 1.4
            menuView.frame = CGRect(x: -window.frame.width, y: 0, width: width, height: window.frame.height)

            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.blackView.alpha = 1
                self.menuView.frame = CGRect(x: 0, y: 0, width: width, height: self.menuView.frame.height)
            } completion: { (flag) in }
        }
    }
    
    @objc func handleBlackTapDismiss(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                self.blackView.alpha = 0
                self.menuView.frame = CGRect(x: -window.frame.width, y: 0, width: self.menuView.frame.width, height: self.menuView.frame.height)
            }
        } completion: { (flag) in }
    }

}

extension MenuLauncher {
    fileprivate func setupContainerViews() {
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
        
        setupImageStackView()
        setupTabelView()
        
        menuView.addSubview(tableLine)
        tableLine.anchor(top: menuTableView.bottomAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: menuView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        menuView.addSubview(gwanglijaSettingLabel)
        gwanglijaSettingLabel.centerXInSuperview()
        gwanglijaSettingLabel.anchor(top: tableLine.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 30))
        
        menuView.addSubview(qrScanImageView)
        qrScanImageView.anchor(top: gwanglijaSettingLabel.bottomAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        
        menuView.addSubview(qrScanButton)
        qrScanButton.anchor(top: qrScanImageView.topAnchor, leading: qrScanImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 30))
        
    }
    
    fileprivate func setupImageStackView() {
        
        icons.forEach {
            let imgView = UIImageView()
            imgView.image = $0
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFit
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            imgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            iconImageViews.append(imgView)
        }
        
        imageStackView = UIStackView(arrangedSubviews: iconImageViews)
        
        imageStackView.axis  = .vertical
        imageStackView.distribution  = .equalSpacing
        imageStackView.alignment = .center
        imageStackView.spacing = 5
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.backgroundColor = .clear
        
        menuView.addSubview(imageStackView)
        imageStackView.anchor(top: headerLine.bottomAnchor, leading: menuView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 250))
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
        menuTableView.anchor(top: headerLine.bottomAnchor, leading: imageStackView.trailingAnchor, bottom: nil, trailing: menuView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: Int(tableSize)*tableNumber))
    }
}

extension MenuLauncher: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MenuCell
        cell.selectionStyle = .none
        cell.itemLabel.text = labels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableSize
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = .black
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                self.blackView.alpha = 0
                self.menuView.frame = CGRect(x: -window.frame.width, y: 0, width: self.menuView.frame.width, height: self.menuView.frame.height)
            }
        } completion: { (flag) in}
    }
}
