//
//  MainPageController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/04.
//

import UIKit

class MainPageController: UIViewController {
    
    let headerNfooterHeight = 50
    static let shared = MainPageController()
    let menuLauncher = MenuLauncher()
    var qrScannerController: QRScannerController?
    var inOutController: InOutAttendanceController!
    var inOutView: UIView!
    let settingsController = SettingsController()

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let headerLine: UIView = {
        let view = UIView()
        view.backgroundColor = mainColor
        return view
    }()
    
    let footerLine: UIView = {
        let view = UIView()
        view.backgroundColor = mainColor
        return view
    }()
    
    let menuButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        return button
    }()
    
    let qrLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        label.text = "출퇴근인증"
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        let attributedText = NSAttributedString(string: "출퇴근", attributes: [.foregroundColor: mainColor,.font: UIFont(name: "Verdana", size: 18) as Any])
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    var setting: Setting? {
        didSet {
            qrLabel.text = setting?.name
        }
    }
    
    @objc fileprivate func handleMenuButton() {
        menuLauncher.showSettings()
        menuLauncher.qrScannerController?.captureSession.stopRunning()
        menuLauncher.mainPageController = self
    }
}

extension MainPageController {
    fileprivate func setupMainViews() {
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: CGSize(width: 0, height: headerNfooterHeight))
        view.addSubview(headerLine)
        headerLine.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 1))
        
        view.addSubview(footerView)
        footerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: headerNfooterHeight))

        view.addSubview(footerLine)
        footerLine.anchor(top: nil, leading: view.leadingAnchor, bottom: footerView.topAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 1))

        inOutController = InOutAttendanceController()
        inOutView = inOutController.view
        view.addSubview(inOutView)
        inOutView.anchor(top: headerLine.bottomAnchor, leading: view.leadingAnchor, bottom: footerLine.topAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func setupViews() {
        setupMainViews()
        headerView.addSubview(qrLabel)
        qrLabel.text = applicationDelegate.getCurrentPage()
        qrLabel.centerXInSuperview()
        qrLabel.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 150, height: 50))
        headerView.addSubview(menuButton)
        menuButton.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 12, right: 0), size: CGSize(width: 25, height: 25))
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
        
        footerView.addSubview(startButton)
        startButton.centerXInSuperview()
        startButton.anchor(top: footerView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 50))
    }
}

extension MainPageController {
    func showController(indexPath: IndexPath? , currentPageString: String?) {
        
        if indexPath != nil {
            removeQrScannerController()
            switch indexPath!.row {
            case 0:
                let homeController = HomeController()
                controllerCreation(viewController: homeController)
            case 1:
                let profileController = ProfileController()
                DispatchQueue.main.async {
                    profileController.ProfileName.text = userInfo?.PersonName
                    profileController.profileName.text = userInfo?.PersonName
                    profileController.jobRankName.text = userInfo?.JobRankCodeName
                    profileController.dutyName.text = userInfo?.DutyCodeName
                    profileController.companyName.text = userInfo?.CompanyName
                }
                controllerCreation(viewController: profileController)
            case 2:
                let calendarController = CalendarController()
                controllerCreation(viewController: calendarController)
            case 3:
                self.controllerCreation(viewController: inOutController)
            case 4:
                controllerCreation(viewController: settingsController)
            default:
                break
            }
        }
        
        if currentPageString != nil {
            removeQrScannerController()
            switch currentPageString {
            case "홈":
                let homeController = HomeController()
                controllerCreation(viewController: homeController)
            case "프로필":
                let profileController = ProfileController()
                DispatchQueue.main.async {
                    profileController.ProfileName.text = userInfo?.PersonName
                    profileController.profileName.text = userInfo?.PersonName
                    profileController.jobRankName.text = userInfo?.JobRankCodeName
                    profileController.dutyName.text = userInfo?.DutyCodeName
                    profileController.companyName.text = userInfo?.CompanyName
                }
                controllerCreation(viewController: profileController)
            case "근무일정":
                let calendarController = CalendarController()
                controllerCreation(viewController: calendarController)
            case "출퇴근인증", "Default":
                let inOutController = InOutAttendanceController()
                self.controllerCreation(viewController: inOutController)
            default:
                break
            }
        }
    }
    
    func removeQrScannerController() {
        menuLauncher.qrScannerController?.removeFromParent()
        menuLauncher.qrScannerController?.view.removeFromSuperview()
        menuLauncher.qrScannerController?.captureSession.stopRunning()
    }
    
    func showQRScannerController() {
        qrScannerController = QRScannerController()
        menuLauncher.qrScannerController = qrScannerController
        self.controllerCreation(viewController: qrScannerController!)
    }
    
    func controllerCreation(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.anchor(top: headerLine.bottomAnchor, leading: view.leadingAnchor, bottom: footerLine.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        viewController.didMove(toParent: self)
    }
}

extension MainPageController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundDarkColor
        setupViews()
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            Vibration.heavy.vibrate()
            switch inOutController.chulTeginSegmentControl.selectedSegmentIndex {
            case 0:
                print("Chulgin")
            case 1:
                print("Twegin")
            default:
                break
            }
        }
    }
    
    override open var shouldAutorotate: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
}
