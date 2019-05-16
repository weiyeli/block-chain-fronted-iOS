//
//  MedicalHospitalTableViewCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/23.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit
import SnapKit

protocol MedicalHospitalTableViewCellProtocal: class {
    func showAuthorizationStatus(msg: String)
}

class MedicalHospitalTableViewCell: UITableViewCell {

    weak var delegate: MedicalHospitalTableViewCellProtocal?

    private lazy var hospitalName: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var bookButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("授权", for: .normal)
        button.addTarget(self, action: #selector(authorization), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        doInitUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func doInitUI() {
        contentView.addSubview(hospitalName)
        hospitalName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
        }

        contentView.addSubview(bookButton)
        bookButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
    }

    func render(hospitalName: String) {
        self.hospitalName.text = hospitalName
    }

    @objc private func authorization() {
        NetworkService.shared.authorization(hospitalName: hospitalName.text!) { [weak self] res in
            if res == 1 {
                self?.delegate?.showAuthorizationStatus(msg: "授权成功")
            } else {
                self?.delegate?.showAuthorizationStatus(msg: "授权失败")
            }
        }
    }
}
