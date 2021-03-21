//
//  TasksTableViewCell.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var TaskDescriptionLabel: UILabel!
    @IBOutlet weak var TaskDescriptionTextField: UITextField!
    
    @IBOutlet weak var AddButton: UIButton!
    
    var delegate:TasksTableViewControllerDelegate?
    
    @IBAction func addNewTask(_ sender: Any) {
        PersistanceRealm.shared.addTask(description: TaskDescriptionTextField.text!)

        delegate?.addTask()
    
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
