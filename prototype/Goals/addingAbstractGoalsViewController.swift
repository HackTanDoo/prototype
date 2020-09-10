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

class addingAbstractGoalsViewController: UIViewController {

    var delegate : dismissCall?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var ContentTextField: UITextField!
    
    private var Title = ""
    private var Content = ""
    
    @IBAction func makeAbstractGoal(_ sender: UIButton) {
        let newAbstractGoal = AbstractGoals(context: context)
        
        Title = TitleTextField.text!
        Content = ContentTextField.text!
        
        newAbstractGoal.title = Title
        newAbstractGoal.content = Content
    
        do{
            try self.context.save()
            print("AbstractGoal is saved")
        }catch {
            fatalError("makeAbstractGoalError Occur")
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

}
