//
//  MedicalCreateRegisterViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/23.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit
import SwiftyJSON

class MedicalCreateRegisterViewController: UIViewController {

    lazy var navRightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "提交", style: .plain, target: self, action: #selector(upload))
        return btn
    }()

    private lazy var doctorNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "医生姓名"
        return label
    }()

    private lazy var doctorNameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "请填写医生姓名"
        tf.delegate = self
        return tf
    }()

    private lazy var hospitalNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "医院科室"
        return label
    }()

    private lazy var hospitalNameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "请填写医院名称和医院科室"
        tf.delegate = self
        return tf
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "日期"
        return label
    }()

    private lazy var dateTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "请填写日期"
        tf.delegate = self
        return tf
    }()

    private lazy var recordTextFile: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "请填写问诊信息"
        tf.delegate = self
        return tf
    }()

    private var patientName: String?

    init(patientName: String) {
        super.init(nibName: nil, bundle: nil)
        self.patientName = patientName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = navRightButton
        doInitUI()
    }

    @objc private func upload() {
        // 拿到患者的姓名
        guard let name = patientName else {
            print("用户没有登录")
            return
        }
        // 创建一张新的病历
        guard let record = recordTextFile.text,
            let doctorName = doctorNameTextField.text,
            let hospitalName = hospitalNameTextField.text,
            let createdTime = dateTextField.text else {
                print("信息输入不对")
                return
        }
        let newRecord = Record(record: record, doctorName: doctorName, hospitalName: hospitalName, createdTime: createdTime)
        NetworkService.shared.createNewRecords(name: name, record: newRecord, completionHandler: { [weak self] (res) in
                let json = JSON(arrayLiteral: res)
                print(json)
                self?.showLoginStatus()
            })
    }

    private func doInitUI() {
        view.addSubview(doctorNameLabel)
        doctorNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }

        view.addSubview(doctorNameTextField)
        doctorNameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalTo(doctorNameLabel.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }

        view.addSubview(hospitalNameLabel)
        hospitalNameLabel.snp.makeConstraints { make in
            make.top.equalTo(doctorNameLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }

        view.addSubview(hospitalNameTextField)
        hospitalNameTextField.snp.makeConstraints { make in
            make.top.equalTo(doctorNameLabel.snp.bottom).offset(20)
            make.left.equalTo(doctorNameLabel.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }

        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(hospitalNameTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }

        view.addSubview(dateTextField)
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(hospitalNameTextField.snp.bottom).offset(20)
            make.left.equalTo(doctorNameLabel.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }

        view.addSubview(recordTextFile)
        recordTextFile.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}

extension MedicalCreateRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension MedicalCreateRegisterViewController {
    private func showLoginStatus() {
        let alert = UIAlertController(title: nil, message: "提交成功", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: false, completion: nil)
    }
}
