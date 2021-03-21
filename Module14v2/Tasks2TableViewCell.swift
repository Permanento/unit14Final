//
//  Tasks2TableViewCell.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import UIKit

class Tasks2TableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextFieald: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var delegate:Tasks2TableViewControllerDelegate?
    @IBAction func addTask(_ sender: Any) {
        print(descriptionTextFieald.text!) //Здесь в консоль выводится нормальное значение
        delegate?.addTask(desciption: descriptionTextFieald.text)
        
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
