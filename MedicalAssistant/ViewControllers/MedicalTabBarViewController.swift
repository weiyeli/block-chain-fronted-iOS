//
//  MedicalTabBarViewController.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/4.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import UIKit

class MedicalTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createChildController()
    }
    
    /// 通过自定义方法添加所有子控制器
    func createChildController() {
        let loginViewController = MedicalLoginViewController()
        loginViewController.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "首页.png"), selectedImage: UIImage(named: "首页.png"))
        let personalViewController = MedicalSettingController()
        personalViewController.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "我的.png"), selectedImage: UIImage(named: "我的.png"))
        let tabBarList:[UIViewController] = [loginViewController, personalViewController]
        viewControllers = tabBarList
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
