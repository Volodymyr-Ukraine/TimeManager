//
//  LoginResultData.swift
//  TimeManager
//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation

public struct LoginResultData: Codable {
    
    // MARK: -
    // MARK: Internal structures

    public struct Field: Codable{
        public let password: [String]?
        public let email: [String]?
    }
    
    // MARK: -
    // MARK: Properties
    
    public let token: String?
    public let message: String?
    public let fields: Field?
}
