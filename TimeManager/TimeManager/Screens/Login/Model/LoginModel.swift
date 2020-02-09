//
//  LoginModel.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation

class LoginModel {
    
    // MARK: -
    // MARK: Properties
    
    public var data: LoginData?
    
    // MARK: -
    // MARK: Methods

    public func login(_ data: LoginData,
                    toDoIfSuccess: ((LoginResultData)->())?,
                    toDoIfError: ((LoginResultData)->())?) {
        RequesterURL.ask.loginUser(user: data, toDoIfSuccess: toDoIfSuccess, toDoIfError: toDoIfError)
    }
}
