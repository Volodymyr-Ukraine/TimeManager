//
//  LoginViewController.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

enum LoginEvents {
    case loginPressed(LoginResultData?)
}

class LoginViewController: RootViewController, StoryboardLoadable{
    
    // MARK: -
    // MARK: Properties

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
        if let data = self.model.data {
            self.mainView?.setData(data)
        }
    }
    
    // MARK: -
    // MARK: Methods
    
    @IBAction func LogInPressed(_ sender: Any) {
        guard let loginData = self.mainView?.getData() else {return}
        
        let success: (LoginResultData)->() = { [weak self] result in
            self?.eventHandler?(.loginPressed( result ))
        }
        let error: (LoginResultData)->() = { [weak self] result in
            guard let this = self else {return}
            
            let alert = UIAlertController(title: "Error in the fields", message: result.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            this.present(alert, animated: true)
        }
        
        self.model.login(loginData, toDoIfSuccess: success, toDoIfError: error)
    }
    
}

