//
//  morningCeremonyViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/02.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit
import CoreData

class morningCeremonyQuestionViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var morningQuestion: UILabel!
    
    @IBOutlet weak var morningCeremonyAnswer: UITextView! {
        didSet {
            morningCeremonyAnswer.delegate = self
        }
    }
    
    private(set) var number : Int = 0
    private(set) var question : String = ""
    private(set) var answer : String = ""
    
    static var Today = today()
    
    override func viewDidLoad() {
        morningQuestion.text = String(number)+" : "+question
        morningCeremonyAnswer.text = answer
        print("morningCeremontQuestionViewController viewDidLoad is called")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewDidDisappear in morningQuestionViewController UPdated")
        morningCeremonyQuestionViewController.Today.morningAnswers[number-1] = morningCeremonyAnswer.text
//        for answer in morningCeremonyQuestionViewController.Today.morningAnswers {
//            print(answer)
//        }
        UserDefaults.standard.set(morningCeremonyQuestionViewController.Today.morningAnswers, forKey: "morningAnswers")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    
    init?(coder: NSCoder, number: Int, question : String, answer: String){
        self.number = number
        self.question = question
        self.answer = answer
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
