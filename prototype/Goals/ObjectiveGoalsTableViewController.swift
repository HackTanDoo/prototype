//
//  ObejctiveGoalsTableViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

var objectiveGoalIndex = -1

class ObjectiveGoalsTableViewController: UITableViewController, dismissCall {
    func dismissisCalled() {
        fetchObjectGoal()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchObjectGoal()
    }

    var objectiveGoals : [ObjectiveGoals]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchObjectGoal(){
        do{
            try objectiveGoals = self.context.fetch(ObjectiveGoals.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            objectiveGoalIndex = -1
        } catch{
            fatalError("fetchObjectGoals failed")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectiveGoals?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectiveGoalCell", for: indexPath)
        cell.textLabel?.text = objectiveGoals![indexPath.row].title
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objectiveGoalIndex = indexPath.row
        performSegue(withIdentifier: "plusObjective", sender: self)
    }
    

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style:. destructive, title : "Delete"){
            (action, view, completionHandler) in
            let objectiveGoalToRemove = self.objectiveGoals![indexPath.row]
            
            self.context.delete(objectiveGoalToRemove)
            do{
                try self.context.save()
            } catch{
                fatalError("objectiveGoalToRemoveFail")
            }
            self.fetchObjectGoal()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plusObjective" {
            let vc = segue.destination as! addingObjectiveGoalsViewController
            vc.delegate = self
        }
    }
}
