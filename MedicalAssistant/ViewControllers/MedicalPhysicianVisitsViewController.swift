//
//  MedicalPhysicianVisitsViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/23.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import SnapKit

class MedicalPhysicianVisitsViewController: UIViewController {

    private var data = [Record]()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入患者名称"
        textField.delegate = self
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return textField
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.rgb("99CE66")
        button.setTitle("搜索", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(searchButtonCliked), for: .touchUpInside)
        return button
    }()

    private lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero)
        tb.register(MedicalRecordCell.self, forCellReuseIdentifier: "MedicalRecordCell")
        tb.separatorColor = .clear
        tb.backgroundColor = .white
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()

    private lazy var navRightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "新增", style: .plain, target: self, action: #selector(addRecord))
        btn.isEnabled = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        doInitUI()
    }

    private func loadData() {
        guard let userName = searchTextField.text else {
            print("患者名为空")
            return
        }

        // 清空原来的数据
        data.removeAll()

        NetworkService.shared.getRecords(name: userName) { [weak self] res in
            guard res.count > 0 else {
                self?.showNoRecord()
                self?.navRightButton.isEnabled = false
                // 清空原来的数据
                self?.data.removeAll()
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
                return
            }
            self?.navRightButton.isEnabled = true
            for i in 1...res.count {
                guard let hospitalName = res[i-1]["hospital"] as? String,
                    let doctorName = res[i-1]["doctor"] as? String,
                    let createdTime = res[i-1]["date"] as? String,
                    let address = res[i-1]["contract"] as? String,
                    let msg = res[i-1]["record"] as? String else {
                        print("医院数据获取错误")
                        return
                }
                let record = Record(id: i,
                                    record: msg,
                                    doctorName: doctorName,
                                    hospitalName: hospitalName,
                                    createdTime: createdTime,
                                    address: address)
                self?.data.append(record)
            }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private func doInitUI() {
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = navRightButton

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalTo(searchTextField.snp.right).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }

    @objc func addRecord() {
        guard let name = searchTextField.text else {
            print("患者姓名为空")
            return
        }
        self.navigationController?.pushViewController(MedicalCreateRegisterViewController(patientName: name), animated: true)
    }

    @objc func searchButtonCliked() {
        loadData()
    }
}

extension MedicalPhysicianVisitsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension MedicalPhysicianVisitsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalRecordCell", for: indexPath) as! MedicalRecordCell
        cell.render(record: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MedicalRecordDetail2ViewController(record: data[indexPath.row]), animated: true)
    }
}

extension MedicalPhysicianVisitsViewController {
    private func showNoRecord() {
        let alert = UIAlertController(title: nil, message: "您可能没有权限访问该患者的病历", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
}

