//
//  Record.swift
//  MedicalAssistant
//
//  Created by liweiye on 2019/4/23.
//  Copyright © 2019 liweiye. All rights reserved.
//

import Foundation

// 电子病历
struct Record {
    var id: Int                     // 用于TableView中演示，无实际意义
    var record: String
    var doctorName: String
    var hospitalName: String
    var createdTime: String
    var address: String
}
