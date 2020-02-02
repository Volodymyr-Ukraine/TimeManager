//
//  LoginViewController.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

enum LoginEvents {
    case loginPressed(String)
}

class LoginViewController: RootViewController {
    
    // MARK: -
    // MARK: Properties

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LogInPressed(_ sender: Any) {
        
    }
    
}
