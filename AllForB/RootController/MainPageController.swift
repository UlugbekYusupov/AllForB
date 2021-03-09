//
//  MainPageController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/04.
//

import UIKit

class MainPageController: UIViewController {
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let containerView: UIView = {
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
//        button.backgroundColor = .red
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
        label.text = "QR Scan"
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        let attributedText = NSAttributedString(string: "Start", attributes: [.foregroundColor: mainColor,.font: UIFont(name: "Verdana", size: 18) as Any])
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    let qrImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let segmentItems = ["출근", "퇴근"]
    lazy var chulTeginSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: segmentItems)
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 10
        segment.layer.masksToBounds = true
        segment.backgroundColor = .clear
        segment.layer.borderWidth = 1
        segment.layer.borderColor = mainColor.cgColor
        segment.selectedSegmentTintColor = mainColor
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segment.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return segment
    }()

    let timeFinishedLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont(name: "Verdana-Bold", size: 17)
        label.text = "Time is finished !"
        return label
    }()
    
    let inchinShiganView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    let qrCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = mainColor
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 10
        let attributedText = NSAttributedString(string: "QR Code 재생성", attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: "Verdana", size: 18) as Any])
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    var time = 0
    let menuLauncher = MenuLauncher()
    let token = application.getCurrentLoginToken()
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        setupViews()
        
        userId = (application.getAnyValueFromCoreData(token!, "userId") as! Int)
        handleCreateQRCode(userId!, 1, "122234234535", 3)
        
    }
}



extension MainPageController {
    
    // Setup views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override open var shouldAutorotate: Bool {
        return false
    }
    
    fileprivate func setupMainViews() {
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: CGSize(width: 0, height: 90))
        view.addSubview(headerLine)
        headerLine.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 1))
        view.addSubview(containerView)
        containerView.anchor(top: headerLine.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: view.frame.size.height - 180))
        view.addSubview(footerLine)
        footerLine.anchor(top: containerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 1))
        view.addSubview(footerView)
        footerView.anchor(top: footerLine.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func setupViews() {
        setupMainViews()
        headerView.addSubview(qrLabel)
        qrLabel.centerXInSuperview()
        qrLabel.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 150, height: 50))
        headerView.addSubview(menuButton)
        menuButton.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 12, right: 0), size: CGSize(width: 25, height: 25))
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
        
        footerView.addSubview(startButton)
        startButton.centerXInSuperview()
        startButton.anchor(top: footerView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 50))
        setupContainerView()
    }
    
    fileprivate func setupContainerView() {
        containerView.addSubview(qrImageView)
        qrImageView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 50, left: 100, bottom: 0, right: 100), size: CGSize(width: 0, height: view.frame.size.width / 2))
        containerView.addSubview(timeFinishedLabel)
        timeFinishedLabel.anchor(top: qrImageView.bottomAnchor, leading: qrImageView.leadingAnchor, bottom: nil, trailing: qrImageView.trailingAnchor,size: CGSize(width: 0, height: 50))
        containerView.addSubview(chulTeginSegmentControl)
        chulTeginSegmentControl.centerInSuperview(size: CGSize(width: 250, height: 45))
        
        containerView.addSubview(inchinShiganView)
        inchinShiganView.centerXInSuperview()
        inchinShiganView.anchor(top: chulTeginSegmentControl.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: CGSize(width: 100, height: 30))
        
        containerView.addSubview(qrCodeButton)
        qrCodeButton.anchor(top: nil, leading: footerLine.leadingAnchor, bottom: footerLine.topAnchor, trailing: footerLine.trailingAnchor,padding: .init(top: 0, left: 100, bottom: 100, right: 100), size: CGSize(width: 0, height: 40))
        qrCodeButton.addTarget(self, action: #selector(handleQRCodeButton), for: .touchUpInside)
    }
}

extension MainPageController {
    
    // methods
    @objc fileprivate func handleSegmentChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {

        // change the userId getting it from LoginData when getAnyValueFromCoreData works!
        case 0:
            DispatchQueue.main.async {
                self.handleCreateQRCode(self.userId!, 1, "123214235", 3)
            }
        case 1:
            DispatchQueue.main.async {
                self.handleCreateQRCode(self.userId!, 1, "123214235", 4)
            }
        default:
            break
        }
    }
    
    @objc fileprivate func handleQRCodeButton() {
        if time == 0 {
            DispatchQueue.main.async {
                self.handleCreateQRCode(self.userId!, 1, "124234", 4)
            }
            time = 5
        } else {
            DispatchQueue.main.async {
                self.handleCreateQRCode(self.userId!, 1, "124234", 3)
            }
            time = 0
        }
    }
    
    @objc fileprivate func handleMenuButton() {
        menuLauncher.showSettings()
    }
    
    fileprivate func generateQRCode(qrString: String) -> UIImage? {
        let string_data = qrString.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(string_data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    fileprivate func handleCreateQRCode(_ userId: Int, _ companyId: Int, _ phoneNo: String, _ inOutTypeId: Int) {
        APIService.shared.qrCodeCreate(userId: userId, companyId: companyId, phoneNo: phoneNo, inOutTypeId: inOutTypeId) { (result, error) in
            if let result = result {
                DispatchQueue.main.async {
                    self.qrImageView.image = self.generateQRCode(qrString: result["InoutQRValue"] as! String)
                }
            }
            else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
