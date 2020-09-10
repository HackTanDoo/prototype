//
//  morningCeremonyPrayerViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/03.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class CeremonyPrayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prayerText.text = text
    }
    
    @IBOutlet weak var prayerText: UILabel!
    
    var text = ""
    
    init?(coder: NSCoder, prayer content : String){
        super.init(coder: coder)
        self.text = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
