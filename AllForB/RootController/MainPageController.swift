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
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let footerView: UIView = {
        let view = UIView()
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
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .red
        return button
    }()
    
    let qrLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.textColor = mainColor
        label.font = UIFont(name: "Verdana-Bold", size: 25)
        label.text = "QR Scan"
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

}

extension MainPageController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override open var shouldAutorotate: Bool {
        return false
    }
}
