//
//  RootViewController.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHidingKeyboard()
    }
    

}

// MARK: -
// MARK: Extension tap gesture recogniser

extension RootViewController {
    func setupHidingKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RootViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
