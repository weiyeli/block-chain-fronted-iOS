//
//  MedicalUserProfileCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/8.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import UIKit

class MedicalUserProfileCell: UITableViewCell {
    
    lazy fileprivate var displayImage: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 38
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy fileprivate var mainTitle: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.rgb("#030303")
        return label
    }()
    lazy fileprivate var subTitle: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.rgb("#030303")
        label.alpha = 0.4
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .white
        
        self.contentView.addSubview(displayImage)
        self.contentView.addSubview(mainTitle)
        self.contentView.addSubview(subTitle)
        displayImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 76, height: 76))
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(21)
        }
        mainTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(19)
            make.left.equalTo(displayImage.snp.right).offset(20)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(28)
        }
        subTitle.snp.makeConstraints { (make) in
            make.left.equalTo(mainTitle.snp.left)
            make.top.equalTo(mainTitle.snp.bottom).offset(5)
            make.right.equalTo(mainTitle.snp.right)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renger(with item: Profile) {
        self.mainTitle.text = item.name
        self.subTitle.text = item.hospital
        self.displayImage.image = item.headProtrait
    }
}
