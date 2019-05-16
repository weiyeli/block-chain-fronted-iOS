//
//  MedicalLoginViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/4.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MedicalLoginViewController: UIViewController {

    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo")!)
        return logo
    }()
    
    private lazy var actorSegmentControl: UISegmentedControl = {
        let items = ["患者", "医生"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        return customSC
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "账号"
        return label
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "密码"
        return label
    }()

    private lazy var accountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入账号"
        textField.delegate = self
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入密码"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.rgb("99CE66")
        button.setTitle("登录", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.rgb("99CE66")
        button.setTitle("注册", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private func setupSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(accountLabel)
        view.addSubview(passwordLabel)
        view.backgroundColor = .white
        view.addSubview(actorSegmentControl)
        view.addSubview(accountTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)

        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(120)
        }

        accountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(view).offset(310)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }

        passwordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(accountLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }

        actorSegmentControl.snp.makeConstraints { make in
            make.bottom.equalTo(accountTextField.snp.top).offset(-40)
            make.centerX.equalToSuperview()
        }
        
        accountTextField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(310)
            make.left.equalTo(accountLabel.snp.right).offset(10)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(accountTextField.snp.bottom).offset(20)
            make.left.equalTo(passwordLabel.snp.right).offset(10)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.left.equalTo(view).offset(80)
            make.right.equalTo(view).offset(-80)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.left.equalTo(view).offset(80)
            make.right.equalTo(view).offset(-80)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "医疗助手"
        setupSubViews()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func loginButtonClicked() {
        guard let account = accountTextField.text, let password = passwordTextField.text else { return }
        NetworkService.shared.login(userName: account, password: password)
        showLoginStatus()
    }

    @objc private func registerButtonClicked() {
        self.navigationController?.pushViewController(MedicalRegisterViewController(), animated: true)
    }

    private func showLoginStatus() {
        let alert = UIAlertController(title: nil, message: "登录成功", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.present(UINavigationController(rootViewController: MedicalSettingController()), animated: true, completion: nil)
        }))
        self.present(alert, animated: false, completion: nil)
    }
}

extension MedicalLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

//UIColor扩展
extension UIColor {
    
    class func rgb(_ rgb: String) -> UIColor {
        var hexString: String
        if rgb.hasPrefix("#") {
            let index = rgb.index(after: rgb.startIndex)
            hexString = String(rgb[index...])
        } else {
            hexString = rgb
        }
        var rgbValue: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        return UIColor.color(
            CGFloat((rgbValue & 0xFF0000) >> 16),
            CGFloat((rgbValue & 0x00FF00) >> 8),
            CGFloat((rgbValue & 0x0000FF))
        )
    }
    
    class func color(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

