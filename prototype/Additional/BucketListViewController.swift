//
//  BucketListViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/08.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    var bucketLists : [BucketList]?
    
    func fetchBucketList(){
        do{
            bucketLists = try context.fetch(BucketList.fetchRequest())
        }catch{
            fatalError("fetchingBucktlist fail")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addBucketList(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add BucketList", message: "What do you want to do?", preferredStyle: .alert)
        alert.addTextField()
        let submitButton = UIAlertAction(title: "Add", style: .default, handler: {
            action in
            let textfield = alert.textFields![0]
            let bucket = BucketList(context: self.context)
            bucket.name = textfield.text!
            do{
                try self.context.save()
            } catch{
                fatalError("BucketListSaving Failed")
            }
            self.fetchBucketList()
        })
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBucketList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bucketLists?.count ?? 0
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketListCell", for: indexPath)
        cell.textLabel!.text = bucketLists![indexPath.row].name
        // Configure the cell...

        return cell
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style:. destructive, title : "Delete"){
            (action, view, completionHandler) in
            let bucketToRemove = self.bucketLists![indexPath.row]
            
            self.context.delete(bucketToRemove)
            do{
                try self.context.save()
            } catch{
                fatalError("bucketListRemove Fail")
            }
            self.fetchBucketList()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}
