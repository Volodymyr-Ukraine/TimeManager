//
//  LoginMainView.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class LoginMainView: UIView {
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var registerSwitch: UISwitch?
    
    // MARK: -
    // MARK: Methods

    public func setData(_ data: LoginData) {
        self.emailTextField?.text = data.mail
        self.passwordTextField?.text = data.password
        self.registerSwitch?.isOn = data.doRegister
    }
    
    public func getData() -> LoginData {
        return LoginData(mail: self.emailTextField?.text ?? "",
        password: self.passwordTextField?.text ?? "",
        doRegister: self.registerSwitch?.isOn ?? false)
    }

}
