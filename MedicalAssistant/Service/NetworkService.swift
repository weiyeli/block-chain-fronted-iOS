//
//  NetworkService.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/20.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {

    static let shared = NetworkService()

    let parameters = ["name": "lhb",
                                  "phone": "999",
                                  "username": "pesw123",
                                  "password": "123456",
                                  "password2": "123456",
                                  "userType": "1",
                                  "isCreated": "false"]

    // 用户注册
    func register(user: User) {
        DispatchQueue.global().async { [weak self] in
            AF.request("http://localhost:5000/user/register",
                       method: .post,
                       parameters: self?.encodeUser(user: user)).responseJSON { response in
                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            print("Data: \(utf8Text)") // original server data as UTF8 string
                        }
            }
        }
    }

    // 用户登录
    func login(userName: String, password: String) {
        DispatchQueue.global().async { [weak self] in
            AF.request("http://localhost:5000/user/login",
                       method: .post,
                       parameters: self?.encodeLoginMsg(userName: userName, password: password)).responseJSON { response in

                        if let data = response.data {
                            do {
                                let res = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                                if let error = res["errors"] {
                                    UserService.shared.isLogin = false
                                    print(error)
                                } else {
                                    UserService.shared.isLogin = true
                                    // 保存用户的信息
                                    let user = User(name: res["name"] as! String,
                                                    phone: "",
                                                    userName: "",
                                                    password: "",
                                                    userType: res["userType"] as! Int,
                                                    isCreated: "")
                                    UserService.shared.setLoginUser(user: user)
                                }
                            } catch let error as NSError {
                                print(error)
                            }
                        }
            }
        }
    }

    // 拿医院的信息
    func getHospitalMsg(completionHandler: @escaping (_ resArray: [[String: Any]]) -> Void) {
        DispatchQueue.global().async {
            AF.request("http://localhost:5000/home/hospitals",
                       method: .get).responseJSON { response in
                if let data = response.data {
                    do {
                        if let hospitalDictionaryArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                            // 把数据传输给VC
                            completionHandler(hospitalDictionaryArray)
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
    }

    // 预约挂号
    func authorization(hospitalName: String, completionHandler: @escaping (_ status: Int) -> Void) {
        DispatchQueue.global().async {
            let url = URL(string: "http://localhost:5000/home/hospitals")?.appendingPathComponent(hospitalName).appendingPathComponent("reservation")
            AF.request(url!.absoluteString,
                       method: .post).responseJSON { response in
                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            do {
                                print(utf8Text)
                                if utf8Text == "1" {
                                    completionHandler(1)
                                } else {
                                    completionHandler(0)
                                }
                            }
                        }
            }
        }
    }

    // 拿病历
    func getRecords(name: String, completionHandler: @escaping (_ res: [[String: Any]]) -> Void) {
        DispatchQueue.global().async {
            let url = URL(string: "http://localhost:5000/home/checkinfo")?.appendingPathComponent(name)
            AF.request(url!.absoluteString,
                       method: .get).responseJSON { response in
                        if let data = response.data {
                            do {
                                if let res = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                                    // 把数据传输给VC
                                    completionHandler(res)
                                }
                            } catch let error as NSError {
                                print(error)
                            }
                        }
            }
        }
    }

    // 写病历
    func createNewRecords(name: String, record: Record, completionHandler: @escaping (_ res: [String: Any]) -> Void) {
        DispatchQueue.global().async {
            let url = URL(string: "http://localhost:5000/home/edit")?.appendingPathComponent(name)
            AF.request(url!.absoluteString,
                       method: .post,
                       parameters: self.encodeRecord(patientRecord: record)).responseJSON { response in
                        if let data = response.data {
                            do {
                                let res = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                                // 把数据传输给VC
                                completionHandler(res)
                            } catch let error as NSError {
                                print(error)
                            }
                        }
            }
        }
    }
}


extension NetworkService {
    private func encodeUser(user: User) -> [String: Any] {
        var parameters = [String: Any]()
        parameters["name"] = user.name
        parameters["phone"] = user.phone
        parameters["username"] = user.userName
        parameters["password"] = user.password
        parameters["password2"] = user.password
        parameters["userType"] = user.userType
        parameters["isCreated"] = user.isCreated
        return parameters
    }

    private func encodeLoginMsg(userName: String, password: String) -> [String: Any] {
        var parameters = [String: Any]()
        parameters["username"] = userName
        parameters["password"] = password
        return parameters
    }

    private func encodeRecord(patientRecord: Record) -> [String: Any] {
        var parameters = [String: Any]()
        parameters["record"] = patientRecord.record
        parameters["doctor"] = patientRecord.doctorName
        parameters["date"] = patientRecord.createdTime
        parameters["hospital"] = patientRecord.hospitalName
        return parameters
    }
}
