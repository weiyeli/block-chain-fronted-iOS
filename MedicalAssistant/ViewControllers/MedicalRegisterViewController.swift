//
//  MedicalRegisterViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/20.
//  Copyright © 2019 liweiye. All rights reserved.
//

import UIKit

class MedicalRegisterViewController: UIViewController {

    lazy var registerTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MedicalRegisterCell.self, forCellReuseIdentifier: "MedicalRegisterCell")
        return tableView
    }()

    lazy var navRightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        return btn
    }()

    private let userMessages = ["姓名","手机号","用户名","密码","确认密码","注册类型"]
    private let userMessagesPlaceholders = ["请设置姓名","请设置手机号", "请设置用户名", "请输入密码", "确认密码", "患者：1，医生：2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        doInitUI()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func doInitUI() {
        view.backgroundColor = .white
        view.addSubview(registerTableView)
        registerTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(100)
        }

        self.navigationItem.rightBarButtonItem = navRightButton
    }

    @objc private func register() {

    }
}

extension MedicalRegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalRegisterCell", for: indexPath) as! MedicalRegisterCell
        cell.renderForUser(message: userMessages[indexPath.row],
                           placeholder: userMessagesPlaceholders[indexPath.row],
                           index: indexPath.row)
        return cell
    }
}
