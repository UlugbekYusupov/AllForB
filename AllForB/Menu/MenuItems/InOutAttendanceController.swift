//
//  InOutAttendanceController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit
import NVActivityIndicatorView

class InOutAttendanceController: UIViewController {
    
    let token = applicationDelegate.getCurrentLoginToken()
    var counter = 0
    var timer: Timer!
    let segmentItems = ["출근", "퇴근"]
    var qrModel: QRCodeModel!
    var expireString: String!
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = mainBackgroundDarkColor
        return view
    }()
    
    let qrImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
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
        label.text = "인증시간이 초과되었습니다 !"
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let inchinShiganView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.borderWidth = 1
        v.layer.borderColor = mainColor.cgColor
        return v
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana-Bold", size: 15)
        label.text = ""
        return label
    }()
    
    let qrCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = mainColor
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 10
        let attributedText = NSAttributedString(string: "QR Code 재생성", attributes: [.foregroundColor: mainBackgroundDarkColor,.font: UIFont(name: "Verdana", size: 18) as Any])
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
}

extension InOutAttendanceController {
    
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
                DispatchQueue.main.async { [self] in
                    self.qrModel = result
                    self.qrImageView.image = self.generateQRCode(qrString: self.qrModel.InoutQRValue)
                    
                    let expireDateString = self.qrModel.ExpireDateTime
                    let timeString = expireDateString.substring(with: 0..<19)
                    dateFormatting(expireDateString: timeString)
                }
            }
            else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func dateFormatting(expireDateString: String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
        let currentDateString = dateFormatter.string(from: date).capitalized

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let expireDate = dateFormatter.date(from: expireDateString)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
        let currentDate = dateFormatter.date(from: currentDateString)
                
        applicationDelegate.scheduleNotification(at: expireDate!)
        
        DispatchQueue.main.async { [self] in
            counter = getDateDiff(start: currentDate!, end: expireDate!)
        }
    }
    
    func getDateDiff(start: Date, end: Date) -> Int  {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from: start, to: end)
        let seconds = dateComponents.second
        return Int(seconds!)
    }
}

extension InOutAttendanceController {
    
    @objc func updateCounter() {
        if counter >= 0 {
            DispatchQueue.main.async { [self] in
                if counter == 0 {
                    timeFinishedLabel.isHidden = false
                    qrCodeButton.isEnabled = true
                    qrCodeButton.backgroundColor  = mainColor
                    timeLabel.textColor = .red
                }
            }
            
            let minutes = Int(TimeInterval(counter)) / 60 % 60
            let seconds = Int(TimeInterval(counter)) % 60
            timeLabel.text = String(format:"%02i:%02i", minutes, seconds)
            counter -= 1
        }
    }

    @objc fileprivate func handleSegmentChange(_ sender: UISegmentedControl) {
        setup()
        DispatchQueue.main.async { [self] in
            switch sender.selectedSegmentIndex {
            case 0:
                handleCreateQRCode(userId!, 1, "123214235", 3)
            case 1:
                handleCreateQRCode(userId!, 1, "123214235", 4)
            default:
                break
            }
        }
    }
    
    fileprivate func setup() {
        timer.invalidate()
        timeFinishedLabel.isHidden = true
        qrCodeButton.isEnabled = false
        qrCodeButton.backgroundColor  = .init(red: 241/244, green: 170/244, blue: 76/244, alpha: 0.7)
        timeLabel.textColor = mainColor
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func handleQRCodeButton() {
        setup()
        switch chulTeginSegmentControl.selectedSegmentIndex {
        case 0:
            handleCreateQRCode(userId!, 1, "124234", 3)
        case 1:
            handleCreateQRCode(userId!, 1, "124234", 4)
        default:
            break
        }
    }
}

extension InOutAttendanceController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0))
        setupContainerView()
        handleCreateQRCode(userId!, 1, "122234234535", 3)
//        self.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
//    override var canBecomeFirstResponder: Bool {
//        get {
//            return true
//        }
//    }
//
//    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//            switch self.chulTeginSegmentControl.selectedSegmentIndex {
//            case 0:
//                self.chulTeginSegmentControl.selectedSegmentIndex = 1
//            case 1:
//                self.chulTeginSegmentControl.selectedSegmentIndex = 0
//            default:
//                break
//            }
//            self.chulTeginSegmentControl.sendActions(for: UIControl.Event.valueChanged)
//        }
//    }
}

extension InOutAttendanceController {
    fileprivate func setupContainerView() {
        containerView.addSubview(qrImageView)
        qrImageView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 30, left: 100, bottom: 0, right: 100), size: CGSize(width: 0, height: view.frame.size.width / 2))
        
        containerView.addSubview(timeFinishedLabel)
        timeFinishedLabel.anchor(top: qrImageView.bottomAnchor, leading: qrImageView.leadingAnchor, bottom: nil, trailing: qrImageView.trailingAnchor,size: CGSize(width: 0, height: 50))
        timeFinishedLabel.isHidden = true
        
        containerView.addSubview(chulTeginSegmentControl)
//        chulTeginSegmentControl.centerInSuperview(size: CGSize(width: 250, height: 45))
        chulTeginSegmentControl.centerXInSuperview()
        chulTeginSegmentControl.anchor(top: timeFinishedLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: 250, height: 45))
        
        
        containerView.addSubview(inchinShiganView)
        inchinShiganView.centerXInSuperview()
        inchinShiganView.anchor(top: chulTeginSegmentControl.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: CGSize(width: 100, height: 30))
        
        inchinShiganView.addSubview(timeLabel)
        timeLabel.fillSuperview(padding: .init(top: 2, left: 2, bottom: 2, right: 2))
        
        containerView.addSubview(qrCodeButton)
        qrCodeButton.centerXInSuperview()
        qrCodeButton.anchor(top: inchinShiganView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 50, left: 100, bottom: 0, right: 100), size: CGSize(width: 200, height: 40))
        qrCodeButton.addTarget(self, action: #selector(handleQRCodeButton), for: .touchUpInside)
        qrCodeButton.isEnabled = false
        qrCodeButton.backgroundColor  = .init(red: 241/244, green: 170/244, blue: 76/244, alpha: 0.7)
    }
}
