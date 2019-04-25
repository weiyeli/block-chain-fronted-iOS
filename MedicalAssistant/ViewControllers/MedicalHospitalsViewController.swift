//
//  MedicalHospitalsViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/22.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit
import SnapKit

class MedicalHospitalsViewController: UITableViewController {

    private var hospitals: [[String: Any]]?

    init() {
        super.init(nibName: nil, bundle: nil)
        loadData()
        tableView.register(MedicalHospitalTableViewCell.self, forCellReuseIdentifier: "MedicalHospitalCell")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hospitals = hospitals else {
            print("医院数据不存在")
            return 0
        }
        return hospitals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalHospitalCell", for: indexPath) as! MedicalHospitalTableViewCell
        guard let hospitals = hospitals else {
            print("医院信息不存在")
            return cell
        }
        let name = hospitals[indexPath.row]["name"] as! String
        cell.render(hospitalName: name)
        cell.delegate = self
        return cell
    }

    private func loadData() {
        NetworkService.shared.getHospitalMsg { res in
            self.hospitals = res
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension MedicalHospitalsViewController: MedicalHospitalTableViewCellProtocal {
    func showAuthorizationStatus(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: false, completion: nil)
    }
}
