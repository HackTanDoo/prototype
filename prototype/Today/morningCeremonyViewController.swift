//
//  morningCeremonyViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/02.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class morningCeremonyQuestionViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var morningQuestion: UILabel!
    
    @IBOutlet weak var morningCeremonyAnswer: UITextView! {
        didSet {
            morningCeremonyAnswer.delegate = self
        }
    }
    
    private var number : Int = 0
    private var question : String = ""
    private var answer : String = ""
    
    override func viewDidLoad() {
        morningQuestion.text = String(number)+" : "+question
        print("morningCeremontQuestionViewController viewDidLoad is called")
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        morningCeremonyAnswer.resignFirstResponder()
        return true
    }

    
    init?(coder: NSCoder, number: Int, question : String){
        self.number = number
        self.question = question
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
