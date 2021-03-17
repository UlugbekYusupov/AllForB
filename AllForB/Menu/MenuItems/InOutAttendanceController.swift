//
//  InOutAttendanceController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit
import NVActivityIndicatorView

class InOutAttendanceController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = mainBackgroundColor
        return view
    }()
    
    let qrImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    var activityIndicatorView: NVActivityIndicatorView?
    
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
        label.textColor = .white
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
        let attributedText = NSAttributedString(string: "QR Code 재생성", attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: "Verdana", size: 18) as Any])
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    let token = application.getCurrentLoginToken()
    var userId: Int?
    var counter = 5
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0))
        
        setupContainerView()
        
        userId = (application.getAnyValueFromCoreData(token!, "userId") as! Int)
        handleCreateQRCode(userId!, 1, "122234234535", 3)
        Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            let minutes = Int(TimeInterval(counter)) / 60 % 60
            let seconds = Int(TimeInterval(counter)) % 60
            timeLabel.text = String(format:"%02i:%02i", minutes, seconds)
            counter -= 1
        } else {
            timeFinishedLabel.isHidden = false
        }
    }
    
    fileprivate func setupContainerView() {
        containerView.addSubview(qrImageView)
        qrImageView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 50, left: 100, bottom: 0, right: 100), size: CGSize(width: 0, height: view.frame.size.width / 2))
        containerView.addSubview(timeFinishedLabel)
        timeFinishedLabel.anchor(top: qrImageView.bottomAnchor, leading: qrImageView.leadingAnchor, bottom: nil, trailing: qrImageView.trailingAnchor,size: CGSize(width: 0, height: 50))
        timeFinishedLabel.isHidden = true
        
        containerView.addSubview(chulTeginSegmentControl)
        chulTeginSegmentControl.centerInSuperview(size: CGSize(width: 250, height: 45))
        
        containerView.addSubview(inchinShiganView)
        inchinShiganView.centerXInSuperview()
        inchinShiganView.anchor(top: chulTeginSegmentControl.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: CGSize(width: 100, height: 30))
        
        inchinShiganView.addSubview(timeLabel)
        timeLabel.fillSuperview(padding: .init(top: 2, left: 2, bottom: 2, right: 2))
        
        containerView.addSubview(qrCodeButton)
        qrCodeButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 100, bottom: 100, right: 100), size: CGSize(width: 0, height: 40))
        qrCodeButton.addTarget(self, action: #selector(handleQRCodeButton), for: .touchUpInside)
    }
    
    @objc fileprivate func handleSegmentChange(_ sender: UISegmentedControl) {
        DispatchQueue.main.async {
            switch sender.selectedSegmentIndex {
            // change the userId getting it from LoginData when getAnyValueFromCoreData works!
            case 0:
                self.handleCreateQRCode(1, 1, "123214235", 3)
            case 1:
                self.handleCreateQRCode(1, 1, "123214235", 4)
            default:
                break
            }
        }
        
    }
    
    @objc fileprivate func handleQRCodeButton() {
        DispatchQueue.main.async { [self] in
            if counter == 0 {
                timeFinishedLabel.isHidden = true
                handleCreateQRCode(userId!, 1, "124234", 4)
//                Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            }
        }
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
    
    var qrModel = [QRCodeModel]()
    fileprivate func handleCreateQRCode(_ userId: Int, _ companyId: Int, _ phoneNo: String, _ inOutTypeId: Int) {
        APIService.shared.qrCodeCreate(userId: userId, companyId: companyId, phoneNo: phoneNo, inOutTypeId: inOutTypeId) { (result, error) in
            if let result = result {
                DispatchQueue.main.async {
                    self.qrModel.append(result)
                    self.qrImageView.image = self.generateQRCode(qrString: self.qrModel[0].InoutQRValue)
                    self.qrModel.removeAll()
                }
            }
            else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
