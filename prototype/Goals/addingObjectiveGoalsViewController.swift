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
    
    var isByPlus = false
    var ObjectiveGoalsCollection : [ObjectiveGoals]?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GoalTextField.delegate = self
        ContentTextView.delegate = self
        isByPlus = objectiveGoalIndex == -1 ? true : false
        if !isByPlus{
            do{
                try ObjectiveGoalsCollection
                    = context.fetch(ObjectiveGoals.fetchRequest())
            } catch {
                fatalError("fetching ObjectiveGoals in addingObjectiveGoalsViewController is failed")
            }
            GoalTextField.text = ObjectiveGoalsCollection![objectiveGoalIndex].title
            ContentTextView.text = ObjectiveGoalsCollection![objectiveGoalIndex].content
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var GoalTextField: UITextField!
    @IBOutlet weak var ContentTextView: UITextView!
    
    
    @IBAction func makeObjectiveGoal(_ sender: UIButton) {
        if isByPlus{
            makeNewGoal()
        } else {
            modifyTheGoal()
        }
    }
    
    func makeNewGoal(){
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
    
    func modifyTheGoal(){
          let ObjectiveGoal = ObjectiveGoalsCollection![objectiveGoalIndex]
          ObjectiveGoal.title = GoalTextField.text!
          ObjectiveGoal.content = ContentTextView.text!
          
          do{
              try self.context.save()
              print("ObjectiveGoal is modified")
          }catch {
              fatalError("making Goal Error Occur")
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
