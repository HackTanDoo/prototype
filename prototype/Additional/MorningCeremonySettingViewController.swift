//
//  MorningCeremonyViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/18.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class MorningCeremonySettingViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    var morningQuestionsTexts : [String] = []
    var morningPrayerText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for morningQuestion in morningQuestions{
            morningQuestion.delegate = self
        }
        morningPrayer.delegate = self
        morningQuestionsTexts = UserDefaults.standard.value(forKey: "morningQuestions") as! [String]
        morningPrayerText = UserDefaults.standard.value(forKey: "prayerForMorning") as! String
        for(i, morningQuestion) in morningQuestions.enumerated() {
            morningQuestion.text = morningQuestionsTexts[i]
        }
        morningPrayer.text = morningPrayerText
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var morningQuestions: [UITextField]!
    @IBOutlet weak var morningPrayer: UITextView!
    
    @IBAction func change(_ sender: UIButton) {
        for(i, morningQuestion) in morningQuestions.enumerated() {
            morningQuestionsTexts[i] = morningQuestion.text!
        }
        morningPrayerText = morningPrayer.text
        UserDefaults.standard.set(morningPrayerText, forKey: "prayerForMorning")
        UserDefaults.standard.set(morningQuestionsTexts, forKey: "morningQuestions")
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
