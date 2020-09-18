//
//  addingAbstractGoalsViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit
import CoreData

protocol dismissCall {
    func dismissisCalled()
}

class addingAbstractGoalsViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate {
    
    
    var delegate : dismissCall?
    var isByPlus = false
    var AbstractGoalsCollection : [AbstractGoals]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleTextField.delegate = self
        ContentTextView.delegate = self
        // Do any additional setup after loading the view.
        isByPlus = abstractGoalIndex == -1 ? true : false
        if !isByPlus {
            do{
                try AbstractGoalsCollection = context.fetch(AbstractGoals.fetchRequest())
            } catch{
                fatalError("Can't fetch AbstractGoals in modifying")
            }
            TitleTextField.text = AbstractGoalsCollection![abstractGoalIndex].title
            ContentTextView.text = AbstractGoalsCollection![abstractGoalIndex].content
        }
        
    }
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var ContentTextView: UITextView!
    
    private var Title = ""
    private var Content = ""
    
    @IBAction func makeAbstractGoal(_ sender: UIButton) {
        if isByPlus{
            makeNewGoal()
        } else {
            modifyTheGoal()
        }
    }
    
    func makeNewGoal() {
       let newAbstractGoal = AbstractGoals(context: context)
        
        Title = TitleTextField.text!
        Content = ContentTextView.text!
        
        newAbstractGoal.title = Title
        newAbstractGoal.content = Content
        newAbstractGoal.clear = false
        
        do{
            try self.context.save()
            print("AbstractGoal is saved")
        }catch {
            fatalError("makeAbstractGoalError Occur")
        }
        delegate?.dismissisCalled()
        dismiss(animated: true)
    }
    
    func modifyTheGoal(){
        let AbstractGoal = AbstractGoalsCollection![goalIndex]
        AbstractGoal.title = TitleTextField.text!
        AbstractGoal.content = ContentTextView.text!
        
        do{
            try self.context.save()
            print("AbstractGoal is modified")
        }catch {
            fatalError("making GoalError Occur")
        }
        
        delegate?.dismissisCalled()
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

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)

    }
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}
