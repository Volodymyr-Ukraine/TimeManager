//
//  LoginViewController.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

enum LoginEvents {
    case loginPressed(LoginData?)
}

class LoginViewController: RootViewController, StoryboardLoadable{
    
    // MARK: -
    // MARK: Properties

    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var registerSwitch: UISwitch?
    public var model = LoginModel()
    public var eventHandler: ((LoginEvents)->())?
    private var mainView: LoginMainView? {
        return self.view as? LoginMainView
    }
    
    // MARK: -
    // MARK: Init and Deinit
    
    public static func startVC() -> LoginViewController {
        let contr = self.loadFromStoryboard(storyboardName: "LoginView")
        return contr	
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = self.model.data else {return}
        self.emailTextField?.text = data.mail
        self.passwordTextField?.text = data.password
        self.registerSwitch?.isOn = data.doRegister
    }
    
    @IBAction func LogInPressed(_ sender: Any) {
        let state = self.registerSwitch
        self.eventHandler?(.loginPressed(
            LoginData(mail: self.emailTextField?.text ?? "",
                      password: self.passwordTextField?.text ?? "",
                      doRegister: self.registerSwitch?.isOn ?? false)
            ))
    }
    
}
