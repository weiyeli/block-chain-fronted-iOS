//
//  MedicalPersonalViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/4.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import UIKit

struct Profile {
    var headProtrait: UIImage
    var name: String
    var hospital: String
    var gender: Int
}

enum MedicalSettingCellType: Int {
    case doctorSettingCell = 1
    case patientSettingCell
    case logoutCell
}

class MedicalSettingController: UIViewController {
    
    //设置cell的高度
    private let userProfileCellHeight: CGFloat = 100.0
    private let settingCellHeight: CGFloat = 70.0
    
    //账号信息
    var profile: Profile = {
        let profile = Profile(headProtrait: UIImage(named: "headProtrait")!, name: "请登录", hospital: "还没有登录哦", gender: 1)
        return profile
    }()
    
    //设置信息
    var settings: [Any] = []
    
    // UI
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupTableView()
    }
}

// MARK: - 初始化
extension MedicalSettingController {
    
    private func setupData() {
        // 判断有没有登录
        if UserService.shared.isLogin {
            // 读取用户的姓名
            let name = UserService.shared.getLoginUser()?.name
            let profile = Profile(headProtrait: UIImage(named: "linus")!, name: name!, hospital: "", gender: 1)
            settings.append(profile)

            // 判断是医生还是患者
            let userType =  UserService.shared.getLoginUser()?.userType
            // 如果是患者
            if userType == 1 {
                let setting1 = MedicalSettingPresenter(image: UIImage(named: "icon_calendar")!, information: "查看病历")
                let setting2 = MedicalSettingPresenter(image: UIImage(named: "book")!, information: "预约挂号")
                settings.append(setting1)
                settings.append(setting2)
            } else {
                // 如果是医生
                let setting1 = MedicalSettingPresenter(image: UIImage(named: "icon_calendar")!, information: "我要问诊")
                settings.append(setting1)
            }
        } else {
            settings.append(profile)
        }
        let setting3 = MedicalSettingPresenter(image: UIImage(named: "icon_setting")!, information: "设置")
        settings.append(setting3)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        // iOS 11的bug，不设置下面的data source方法就不执行
        tableView.sectionHeaderHeight = 0.01
        tableView.sectionFooterHeight = 0.01
        tableView.dataSource = self
        tableView.delegate = self
        //注册cell
        tableView.register(MedicalSettingCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.register(MedicalUserProfileCell.self, forCellReuseIdentifier: "UserProfileCell")
        tableView.register(MedicalLogoutCell.self, forCellReuseIdentifier: "LogoutCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MedicalSettingController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return settings.count - 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = indexPath.row
        if indexPath.section == 1 {
            index += 1
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell") as? MedicalLogoutCell else {
                print("获取logout cell失败")
                return UITableViewCell()
            }
            cell.logoutCore = { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            return cell
        }
        let setting = settings[index]
        
        if let setting = setting as? Profile {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell") as? MedicalUserProfileCell else {
                print("获取用户信息cell失败")
                return UITableViewCell()
            }
            cell.renger(with: setting)
            return cell
        } else if let setting = setting as? MedicalSettingPresenter {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as? MedicalSettingCell else {
                print("获取setting cell失败")
                return UITableViewCell()
            }
            cell.render(presenter: setting)
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < 2 {
            let setting = settings[indexPath.section]
            if setting is Profile {
                return userProfileCellHeight
            } else if setting is MedicalSettingPresenter {
                return settingCellHeight
            }
        }
        return 50
    }
}

extension MedicalSettingController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section > 0 {
            // 判断是医生还是患者
            let userType =  UserService.shared.getLoginUser()?.userType
            // 如果是患者
            if userType == 1 {
                let row = indexPath.row
                if row == 0 {
                    // 查看我的病历
                    self.navigationController?.pushViewController(MedicalRecordTableViewController(), animated: true)
                } else if row == 1 {
                    // 预约挂号
                    self.navigationController?.pushViewController(MedicalHospitalsViewController(), animated: true)
                }
            } else {
                if indexPath.row == 0 {
                    self.navigationController?.pushViewController(MedicalPhysicianVisitsViewController(), animated: true)
                } else {
                    return
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 10
        }
        return 0
    }
}

