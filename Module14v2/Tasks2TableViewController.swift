//
//  Tasks2TableViewController.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import UIKit
import CoreData

protocol Tasks2TableViewControllerDelegate {
    func addTask(desciption:String?)
}


class Tasks2TableViewController: UITableViewController {
    
    var tasks: [TaskCore] = []
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<TaskCore> = TaskCore.fetchRequest()
        
        do {
            tasks =  try context.fetch(fetchRequest)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return tasks.count+1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell2", for: indexPath) as! Tasks2TableViewCell

        cell.delegate = self
    
    if indexPath.row < tasks.count{
        cell.descriptionLabel.isHidden = false
        cell.descriptionLabel.text = tasks[indexPath.row].taskDescription
        cell.descriptionTextFieald.isHidden = true
        cell.addButton.isHidden = true
        print("taskRow")
    } else {
        cell.descriptionLabel.isHidden = true
        cell.descriptionTextFieald.isHidden = false
        cell.addButton.isHidden = false
        
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
        if indexPath.row < tasks.count{
            if editingStyle == .delete {
                // Delete the row from the data source
                
       
                let appDelegate =  UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                //let fetchRequest: NSFetchRequest<TaskCore> = TaskCore.fetchRequest()
                
                
                context.delete(tasks[indexPath.row])
                
                do {
                    try context.save()
                } catch let error as NSError{
                    print(error.localizedDescription)
                }
                tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


extension Tasks2TableViewController:Tasks2TableViewControllerDelegate{
    func addTask(desciption:String?){
        //print(desciption)//А вот тут уже значение неверное
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "TaskCore", in: context) else {return}
        
        let taskObject = TaskCore(entity: entity, insertInto: context)
        taskObject.taskDescription = desciption
        
        do{
            try context.save()
            tasks.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        let position = IndexPath(row: tasks.count, section: 0)
        tableView.insertRows(at: [position], with: .left)
        tableView.reloadData()
        print("knopka3")
        
    }
}
