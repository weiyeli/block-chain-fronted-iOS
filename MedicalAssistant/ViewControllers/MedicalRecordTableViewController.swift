//
//  MedicalRecordTableViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/21.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit

struct RecordPresender {
    var number: String
    var hospitalName: String
    var createdTime: String
}

class MedicalRecordTableViewController: UITableViewController {

    private var data = [RecordPresender]()

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
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalRecordCell", for: indexPath) as! MedicalRecordCell
        cell.render(record: data[indexPath.row])
        return cell
    }

    private func loadData() {
        guard let userName = UserService.shared.getLoginUser()?.name else {
            print("用户没有登录")
            return
        }
        NetworkService.shared.getRecords(name: userName) { [weak self] res in
            for i in 1...res.count {
                guard let hospitalName = res[i-1]["hospital"],
                    let time = res[i-1]["date"] else {
                        print("医院数据获取错误")
                        return
                }
                let recordPresender = RecordPresender(number: String(i),
                                                      hospitalName: hospitalName as! String,
                                                      createdTime: time as! String)
                self?.data.append(recordPresender)
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
