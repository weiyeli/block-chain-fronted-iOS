//
//  MedicalLogoutCellTableViewCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/25.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit
import SnapKit

class MedicalLogoutCell: UITableViewCell {

    private lazy var logoutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("退出登录", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(logoutCore), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        doInitUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func doInitUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    @objc private func logoutCore() {
        
    }
}
