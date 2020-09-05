//
//  CermonyController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/04.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class CeremonyController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    lazy var Today = today()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewDidDisappear in CeremonyComonyController UPdated")
        for answer in Today.morningAnswers {
            print(answer)
        }
        UserDefaults.standard.set(Today.morningAnswers, forKey: "morningAnswers")
        
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
