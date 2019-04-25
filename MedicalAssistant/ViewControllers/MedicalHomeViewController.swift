//
//  MedicalHomeViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/4.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import UIKit

class MedicalHomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let headerCellHeight = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册cell
        collectionView.register(MedicalCollectionHeaderCell.self, forCellWithReuseIdentifier: "CollectionHeaderCell")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MedicalHomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionHeaderCell", for: indexPath) as! MedicalCollectionHeaderCell
        cell.renger(icon: UIImage(named: "病历本.png")!, content: "病历\(indexPath.row)")
        return cell
    }
}

extension MedicalHomeViewController: UICollectionViewDelegate {
    
}

extension MedicalHomeViewController: UICollectionViewDelegateFlowLayout {
    /// 设置每个cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 每行4个cell
        let screenWidth = collectionView.frame.size.width
        let cellWidth = screenWidth * 0.25
        return CGSize(width: cellWidth, height: CGFloat(headerCellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
