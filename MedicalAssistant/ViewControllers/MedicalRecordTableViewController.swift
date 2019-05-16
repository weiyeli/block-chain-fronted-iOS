//
//  MedicalRecordTableViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/21.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit

class MedicalRecordTableViewController: UITableViewController {

    private var records = [Record]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTableView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalRecordCell", for: indexPath) as! MedicalRecordCell
        cell.render(record: records[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = records[indexPath.row]
        self.navigationController?.pushViewController(MedicalRecordDetail2ViewController(record: record), animated: true)
    }

    private func loadData() {
        guard let userName = UserService.shared.getLoginUser()?.name else {
            print("用户没有登录")
            return
        }
        NetworkService.shared.getRecords(name: userName) { [weak self] res in
            guard res.count > 0 else {
                print("病历数据为空")
                return
            }
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
                self?.records.append(record)
            }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.register(MedicalRecordCell.self, forCellReuseIdentifier: "MedicalRecordCell")
        tableView.separatorColor = .clear
    }
}

extension MedicalRecordTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
