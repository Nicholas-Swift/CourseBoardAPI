//
//  ViewController.swift
//  CourseBoardAPI
//
//  Created by Nicholas Swift on 10/4/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let comp = Competency()
        comp.name = "Python"
        comp.kind = "Character"
        comp.level = 5
        
        CourseBoardAPI.login(email: "nswift", password: "q1w2e3", complete: { (bool: Bool, error: NSError?) in
            CourseBoardAPI.updateCompetence(userId: "58474d69422e26a1340476b2", competency: comp, complete: { (bool: Bool?, error: NSError?) in
                if error == nil {
                    print(bool)
                }
                else {
                    print("ERROR")
                }
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

