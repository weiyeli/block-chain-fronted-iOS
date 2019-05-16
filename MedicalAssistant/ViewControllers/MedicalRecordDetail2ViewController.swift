//
//  MedicalRecordDetail2ViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/5/8.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit

class MedicalRecordDetail2ViewController: UITableViewController {

    private let record: Record

    init(record: Record) {
        self.record = record
        super.init(nibName: nil, bundle: nil)
        tableView.sectionHeaderHeight = 0.01
        tableView.sectionFooterHeight = 0.01
        tableView.register(MedicalRecordFirstCell.self, forCellReuseIdentifier: "FirstCell")
        tableView.register(MedicalRecordSecondCell.self, forCellReuseIdentifier: "SecondCell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section > 3 {
            return 400.0
        } else {
            return 50.0
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "合约地址"
        } else if section == 1 {
            return "创建时间"
        } else if section == 2 {
            return "医院名称"
        } else if section == 3 {
            return "医生名称"
        } else {
            return "诊疗结果"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section < 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! MedicalRecordFirstCell
            if section == 0 {
                cell.renger(text: record.address)
            } else if section == 1 {
                cell.renger(text: record.createdTime)
            } else if section == 2 {
                cell.renger(text: record.hospitalName)
            } else {
                cell.renger(text: record.doctorName)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! MedicalRecordSecondCell
            cell.renger(text: record.record)
            return cell
        }
    }
}
