//
//  addingObjectiveGoalsViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class addingObjectiveGoalsViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate : dismissCall?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var abstractGoals : [AbstractGoals]?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return abstractGoals?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return abstractGoals![row].title
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        abstractGoalPicker.delegate = self
        abstractGoalPicker.dataSource = self
        do{
            try abstractGoals = context.fetch(AbstractGoals.fetchRequest())
        } catch {
            fatalError("fetching abstractGoals in addingObjectiveGoalsViewController is failed")
        }
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var abstractGoalPicker: UIPickerView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
