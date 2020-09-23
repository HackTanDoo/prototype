//
//  addingGoalsViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class addingGoalsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{

    var delegate : dismissCall?
    
    @IBOutlet weak var GoalTextField: UITextField!
    @IBOutlet weak var ContentTextView: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isByPlus = false
    
    var GoalsCollection : [Goals]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoalTextField.delegate = self
        ContentTextView.delegate = self
        // Do any additional setup after loading the view.
        isByPlus = goalIndex == -1 ? true : false
        if !isByPlus {
            do{
                GoalsCollection = try context.fetch(Goals.fetchRequest())
            } catch{
                fatalError("Can't fetch Goals in modifying")
            }
            GoalTextField.text = GoalsCollection![goalIndex].title
            ContentTextView.text = GoalsCollection![goalIndex].content
        }
    }
    
    private var Title = ""
    private var Content = ""
    
    @IBAction func makingGoalAction(_ sender: UIButton) {
        if isByPlus{
            makeNewGoal()
        } else {
            modifyTheGoal()
        }
    }
    
    func makeNewGoal() {
        let newGoal = Goals(context: context)
        
        Title = GoalTextField.text!
        Content = ContentTextView.text!
        
        newGoal.title = Title
        newGoal.content = Content
        newGoal.clear = false
        
        do{
            try self.context.save()
            print("Goal is saved")
        }catch {
            fatalError("making GoalError Occur")
        }
        delegate?.dismissisCalled()
        dismiss(animated: true)
    }
    
    func modifyTheGoal(){
        let Goal = GoalsCollection![goalIndex]
        Goal.title = GoalTextField.text!
        Goal.content = ContentTextView.text!
        
        do{
            try self.context.save()
            print("Goal is modified")
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
    
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}
