//
//  AddingQuoteViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/18.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class AddingQuoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{

    @IBOutlet weak var QuoteTextView: UITextView!
    @IBOutlet weak var artistTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var Quotes : [Quote]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistTextField.delegate = self
        QuoteTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func Add(_ sender: UIButton) {
        let newQuote = Quote(context: context)
        newQuote.artist = artistTextField.text
        newQuote.content = QuoteTextView.text
        do{
            try self.context.save()
        } catch{
            fatalError("Adding Quotes Failed")
        }
        dismiss(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)

    }
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
