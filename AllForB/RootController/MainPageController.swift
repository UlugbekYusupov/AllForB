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
    
    static let shared = MainPageController()
    let menuLauncher = MenuLauncher()
    var inOutController: InOutAttendanceController!
    var inOutView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        setupViews()
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
        
        view.addSubview(footerView)
        footerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 100))

        view.addSubview(footerLine)
        footerLine.anchor(top: nil, leading: view.leadingAnchor, bottom: footerView.topAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 1))


        inOutController = InOutAttendanceController()
        inOutView = inOutController.view
        
        view.addSubview(inOutView)
        inOutView.anchor(top: headerLine.bottomAnchor, leading: view.leadingAnchor, bottom: footerLine.topAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0))
    }
    
    func addCustomSubView(View: UIView) {
        view.willRemoveSubview(inOutView)
        view.addSubview(View)
        View.anchor(top: headerLine.bottomAnchor, leading: view.leadingAnchor, bottom: footerLine.topAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0))
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
    }
}

extension MainPageController {
    @objc fileprivate func handleMenuButton() {
        menuLauncher.showSettings()
    }
}
