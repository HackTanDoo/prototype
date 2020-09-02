//
//  TodayViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/02.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    private var Today = today()
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "test1", sender: self)
        print("ViewDidLoad Called")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare is called")
        if !Today.morningCeremony{
            print("MorningCeremony is not set in prepare")
        }
        if segue.identifier == "test1" {
            print("test1 is called")
        } else if segue.identifier == "test2"{
            print("test2 is called")
        }
    }

}
