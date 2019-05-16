//
//  MedicalRecordCellTableViewCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/21.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit
import SnapKit

class MedicalRecordCell: UITableViewCell {

    private lazy var numberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var hospitalNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var createdTimeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height

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

    private func doInitUI() {
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
        }

        contentView.addSubview(hospitalNameLabel)
        hospitalNameLabel.snp.makeConstraints { make in
            make.left.equalTo(numberLabel.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo((screenWidth / 2) - 20)
        }

        contentView.addSubview(createdTimeLabel)
        createdTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(hospitalNameLabel.snp.right)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    func render(record: Record) {
        numberLabel.text = String(record.id)
        hospitalNameLabel.text = record.hospitalName
        createdTimeLabel.text = record.createdTime
    }
}
