//
//  addingObjectiveGoalsViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class addingObjectiveGoalsViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate {
    
    var delegate : dismissCall?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var abstractGoals : [AbstractGoals]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GoalTextField.delegate = self
        ContentTextView.delegate = self
        do{
            try abstractGoals = context.fetch(AbstractGoals.fetchRequest())
        } catch {
            fatalError("fetching abstractGoals in addingObjectiveGoalsViewController is failed")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var GoalTextField: UITextField!
    @IBOutlet weak var ContentTextView: UITextView!
    
    
    @IBAction func makeObjectiveGoal(_ sender: UIButton) {
        let newObjectiveGoal = ObjectiveGoals(context: context)
        newObjectiveGoal.clear = false
        newObjectiveGoal.content = ContentTextView.text!
        newObjectiveGoal.title = GoalTextField.text!
        
        do{
            try self.context.save()
            print("ObjectiveGoal is saved")
        }catch {
            fatalError("makeObjectiveGoalError Occur")
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
