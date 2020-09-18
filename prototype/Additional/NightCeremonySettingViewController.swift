//
//  NightCeremonySettingViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/18.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class NightCeremonySettingViewController: UIViewController {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var textView: UITextView!
    
    var nightQuestions : [String] = []
    var nightPrayerText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nightQuestions = UserDefaults.standard.value(forKey: "nightQuestions") as! [String]
        nightPrayerText = UserDefaults.standard.value(forKey: "prayerForNight") as! String
        for (i,textField) in textFields.enumerated() {
            textField.text = nightQuestions[i]
        }
        textView.text = nightPrayerText
        // Do any additional setup after loading the view.
    }
    @IBAction func change(_ sender: UIButton) {
        for (i,textField) in textFields.enumerated() {
            nightQuestions[i] = textField.text!
        }
        nightPrayerText = textView.text
        UserDefaults.standard.set(nightQuestions, forKey: "nightQuestions")
        UserDefaults.standard.set(nightPrayerText, forKey: "prayerForNight")
        dismiss(animated: true)
    }
    
}
