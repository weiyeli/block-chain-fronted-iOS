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

    private lazy var hospitalLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var doctorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var recordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    init() {
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
        view.addSubview(hospitalLabel)
        hospitalLabel.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            } else {
                make.bottom.equalTo(view.snp.top).offset(10)
            }
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }

        view.addSubview(doctorLabel)
        doctorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hospitalLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }

        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(doctorLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }

        view.addSubview(recordLabel)
        recordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}
