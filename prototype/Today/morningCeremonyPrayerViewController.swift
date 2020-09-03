//
//  morningCeremonyPrayerViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/03.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class morningCeremonyPrayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var prayerText: UILabel!
    
    init(prayer content : String){
        prayerText.text = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
