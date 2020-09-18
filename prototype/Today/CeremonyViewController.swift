//
//  morningCeremonyViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/02.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit
import CoreData

class CeremonyQuestionViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var Question: UILabel!
    
    @IBOutlet weak var CeremonyAnswer: UITextView! {
        didSet {
            CeremonyAnswer.delegate = self
        }
    }
    var delegate : dismissCall?
    
    var morning : Bool = true
    private(set) var number : Int = 0
    private(set) var question : String = ""
    private(set) var answer : String = ""
    
    static var Today = today()
    
    override func viewDidLoad() {
        Question.text = String(number)+" : "+question
        CeremonyAnswer.text = answer
        print("CeremontQuestionViewController viewDidLoad is called")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewDidDisappear in QuestionViewController UPdated")
//        for answer in morningCeremonyQuestionViewController.Today.morningAnswers {
//            print(answer)
//        }
        if morning{
            CeremonyQuestionViewController.Today.morningAnswers[number-1] = CeremonyAnswer.text
            UserDefaults.standard.set(CeremonyQuestionViewController.Today.morningAnswers, forKey: "morningAnswers")
        } else{
            CeremonyQuestionViewController.Today.nightAnswers[number-1] = CeremonyAnswer.text
            UserDefaults.standard.set(CeremonyQuestionViewController.Today.nightAnswers, forKey: "nightAnswers")
        }
        delegate?.dismissisCalled()
        print("dismiss in viewdiddisappear is called")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    
    init?(coder: NSCoder, morning : Bool, number: Int, question : String, answer: String){
        self.morning = morning
        self.number = number
        self.question = question
        self.answer = answer
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)

    }
    
}
