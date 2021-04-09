//
//  SettingsController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class SettingsController: UIViewController {
    let firstPageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = mainColor
        button.setTitle("Default", for: .normal)
        button.setTitleColor(mainBackgroundDarkColor, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var chosenPageName: String?
    let tableView = UITableView()
    var selectedButton = UIButton()
    var selectButtonTapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundDarkColor
        setupButton()
    }
    
    fileprivate func setupButton() {
        view.addSubview(firstPageButton)
        firstPageButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 40))
        firstPageButton.addTarget(self, action: #selector(handleFirstPageButton), for: .touchUpInside)
        
        if applicationDelegate.getCurrentPage() != nil {
            firstPageButton.setTitle(applicationDelegate.getCurrentPage(), for: .normal)
        }
    }

    func addFrames(frames: CGRect) {
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        view.addSubview(tableView)
        tableView.register(OptionsCell.self, forCellReuseIdentifier: "cellid")
        tableView.backgroundColor = mainBackgroundDarkColor
        tableView.layer.cornerRadius = 5
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) { [self] in
            tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(dataSource.count * 50))
        } completion: { (flag) in}
    }
    
    
    @objc func handleFirstPageButton(_ sender: Any) {
        if selectButtonTapped == false {
            selectButtonTapped = true
            dataSource = ["홈", "프로필", "근무일정", "출퇴근인증", "Default"]
            selectedButton = firstPageButton
            addFrames(frames: firstPageButton.frame)
        } else {
            selectButtonTapped = false
            uiViewAnimation(frames: firstPageButton.frame)
        }
    }
    func uiViewAnimation(frames: CGRect) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        } completion: { (flag) in}
    }
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let backgroundView = UIView()
        backgroundView.backgroundColor = mainBackgroundDarkColor
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! OptionsCell
        cell.textLabel!.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = mainBackgroundDarkColor
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frames = selectedButton.frame
        chosenPageName = dataSource[indexPath.row]
        selectedButton.setTitle(chosenPageName, for: .normal)
        applicationDelegate.saveCurrentPage(dataSource[indexPath.row])
        selectButtonTapped = false
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = mainColor
        uiViewAnimation(frames: frames)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
