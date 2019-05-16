//
//  MedicalRecordFirstCellTableViewCell.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/5/8.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit
import SnapKit

class MedicalRecordFirstCell: UITableViewCell {

    private lazy var textField: UILabel = {
        let tf = UILabel(frame: .zero)
        return tf
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

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
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.right.bottom.equalToSuperview()
        }
    }

    func renger(text: String) {
        self.textField.text = text
    }
}
