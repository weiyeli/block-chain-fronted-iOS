//
//  MedicalRegisterCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/20.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit

class MedicalRegisterCell: UITableViewCell {

    private(set) var label: UILabel!
    private var textField: UITextField!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        doInitUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MedicalRegisterCell {

    private func doInitUI() {
        label = UILabel(frame: .zero)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }

        textField = UITextField(frame: .zero)
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
    }

    func renderForUser(message: String, placeholder: String, index: Int) {
        label.text = message
        textField.placeholder = placeholder
        if index == 3 || index == 4 {
            textField.isSecureTextEntry = true
        }
    }

    func renderForRecord(message: String, placeholder: String, index: Int) {
        label.text = message
        textField.placeholder = placeholder
        if index == 3 || index == 4 {
            textField.isSecureTextEntry = true
        }
    }
}
