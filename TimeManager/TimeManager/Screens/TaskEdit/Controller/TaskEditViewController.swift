//
//  TaskEditController.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class TaskEditViewController: RootViewController, StoryboardLoadable {
    // MARK: -
    // MARK: Init and Deinit
    
    static public func startVC() -> TaskEditViewController {
        let contr = self.loadFromStoryboard(storyboardName: "TaskEditStoryboard")
        return contr
    }
    
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

}
