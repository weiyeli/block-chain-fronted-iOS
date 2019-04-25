//
//  MedicalCollectionHeaderCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/9.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MedicalCollectionHeaderCell: UICollectionViewCell {
    
    lazy fileprivate var iconImage: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy fileprivate var contentLabel: UILabel = {
        let contentLabel = UILabel(frame: .zero)
        //加粗
        contentLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return contentLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public func setupUI() {
        contentView.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(5)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renger(icon: UIImage, content: String) {
        self.iconImage.image = icon
        self.contentLabel.text = content
    }
}
