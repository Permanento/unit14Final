//
//  TasksTableViewController.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import UIKit


protocol TasksTableViewControllerDelegate {
    func addTask()
}

class TasksTableViewController: UITableViewController {
    
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view")
        PersistanceRealm.shared.test()
        
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
        print(PersistanceRealm.shared.getTasks().count+1)
        return PersistanceRealm.shared.getTasks().count+1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TasksTableViewCell
            cell.delegate = self
        
        if indexPath.row < PersistanceRealm.shared.getTasks().count{
            cell.TaskDescriptionLabel.isHidden = false
            cell.TaskDescriptionLabel.text = PersistanceRealm.shared.getTaskByIndex(index: indexPath.row).taskDescription
            cell.TaskDescriptionTextField.isHidden = true
            cell.AddButton.isHidden = true
            print("taskRow")
        } else {
            cell.TaskDescriptionLabel.isHidden = true
            cell.TaskDescriptionTextField.isHidden = false
            cell.AddButton.isHidden = false
            print("addTaskRow")
        }
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

     
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < PersistanceRealm.shared.getTasks().count{
            if editingStyle == .delete {
                PersistanceRealm.shared.deleteTask(index: indexPath.row)
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //            let cell = TasksTableViewCell()
    //            cell.textLabel.text =
                print("addRow")
                tableView.insertRows(at: [indexPath], with: .left)
                tableView.reloadData()
            }
        }
    }
    

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

extension TasksTableViewController: TasksTableViewControllerDelegate{
    func addTask(){
        print("knopka2")
        let position = IndexPath(row: PersistanceRealm.shared.getTasks().count, section: 0)
        tableView.insertRows(at: [position], with: .left)
        tableView.reloadData()
        print("knopka3")
        
    }
}
