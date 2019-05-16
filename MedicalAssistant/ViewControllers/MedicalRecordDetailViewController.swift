//
//  MedicalRecordDetailViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/25.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit
import SnapKit

class MedicalRecordDetailViewController: UIViewController {

    private lazy var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private lazy var hospitalLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private lazy var doctorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private lazy var recordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private let record: Record
    
    init(record: Record) {
        self.record = record
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        doInitUI()
    }

    private func doInitUI() {
        view.backgroundColor = .white

        view.addSubview(addressLabel)
        addressLabel.text = "合约地址:\n\(record.address)"
        addressLabel.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            } else {
                make.bottom.equalTo(view.snp.top).offset(5)
            }
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }

        view.addSubview(hospitalLabel)
        hospitalLabel.text = "医院名称:\n\(record.hospitalName)"
        hospitalLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }

        view.addSubview(doctorLabel)
        doctorLabel.text = "医生名称:\n\(record.doctorName)"
        doctorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hospitalLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }

        view.addSubview(dateLabel)
        dateLabel.text = "创建时间:\n\(record.createdTime)"
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(doctorLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }

        view.addSubview(recordLabel)
        recordLabel.text = "诊断结果:\n\(record.record)"
        recordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
    }
}
