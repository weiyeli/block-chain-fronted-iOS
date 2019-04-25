//
//  UserService.swift
//  
//
//  Created by liweiye on 2019/4/21.
//

import Foundation

class UserService {

    static var shared = UserService()

    private var loginUser: User?

    var isLogin: Bool = false

    public func getLoginUser() -> User? {
        return loginUser
    }

    public func setLoginUser(user: User) {
        self.loginUser = user
    }
}
