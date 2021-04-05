//
//  HomeController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

class HomeController: UIViewController {
    
    var noticesCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundDarkColor
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        noticesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        noticesCollectionView?.backgroundColor = .clear
        noticesCollectionView?.register(NoticeCell.self, forCellWithReuseIdentifier: "cellID")
        noticesCollectionView?.dataSource = self
        noticesCollectionView?.delegate = self
        noticesCollectionView?.showsVerticalScrollIndicator = false
        view.addSubview(noticesCollectionView!)
        noticesCollectionView?.fillSuperview(padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! NoticeCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 150)
    }
}
