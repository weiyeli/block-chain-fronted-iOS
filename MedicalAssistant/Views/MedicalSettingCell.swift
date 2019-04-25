//
//  MedicalPersonalInformationCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/6.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MedicalSettingPresenter {
    var image: UIImage?
    var information: String?
    
    init(image: UIImage, information: String) {
        self.image = image
        self.information = information
    }
}

class MedicalSettingCell: UITableViewCell {
    
    private(set) var iconView: UIImageView!
    private(set) var informationLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        accessoryType = .disclosureIndicator
        doInitUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MedicalSettingCell {
    
    private func doInitUI() {
        iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill     // 拉伸填满整个iconView
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        informationLabel = UILabel(frame: .zero)
        informationLabel.font = UIFont.systemFont(ofSize: 17)
        contentView.addSubview(informationLabel)
        informationLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func render(presenter: MedicalSettingPresenter) {
        iconView.image = presenter.image
        informationLabel.text = presenter.information
    }
}
