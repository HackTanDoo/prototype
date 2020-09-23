//
//  NightCeremonySettingViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/18.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class NightCeremonySettingViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var textView: UITextView!
    
    var nightQuestions : [String] = []
    var nightPrayerText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for nightQuestion in textFields {
            nightQuestion.delegate = self
        }
        textView.delegate = self
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)

    }
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
