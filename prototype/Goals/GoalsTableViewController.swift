//
//  GoalsTableViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/08.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

var goalIndex = -1

class GoalsTableViewController: UITableViewController, dismissCall {
    func dismissisCalled() {
        fetchGoals()
        goalIndex = -1
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var GoalsCollection : [Goals]?
    
    
    func fetchGoals(){
        do{
            GoalsCollection = try context.fetch(Goals.fetchRequest())

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            goalIndex = -1
            
        } catch{
            fatalError("Can't fetch Goals")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGoals()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GoalsCollection?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath)
        
        let Goal = GoalsCollection![indexPath.row]
        cell.textLabel?.text = Goal.title

        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goalIndex = indexPath.row
        performSegue(withIdentifier: "plusGoal", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style:. destructive, title : "Delete"){
            (action, view, completionHandler) in
            let GoalToRemove = self.GoalsCollection![indexPath.row]
            
            self.context.delete(GoalToRemove)
            do{
                try self.context.save()
            } catch{
                fatalError("GoalCollectionToRemoveFail")
            }
            self.fetchGoals()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plusGoal" {
            let vc = segue.destination as! addingGoalsViewController
            vc.delegate = self
        }
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

}
