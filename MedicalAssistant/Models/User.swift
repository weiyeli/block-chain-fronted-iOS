//
//  Patient.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/3/8.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation

struct User: Codable {
    var name: String
    var phone: String
    var userName: String
    var password: String
    var userType: Int
    var isCreated: String = "false"
}
