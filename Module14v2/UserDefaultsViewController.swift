//
//  UserDefaultsViewController.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import UIKit

class UserDefaultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = Persistance.shared.userName
        lastNameTextField.text = Persistance.shared.userLastName
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBAction func nameEdited(_ sender: Any) {
        Persistance.shared.userName = nameTextField.text
    }
    @IBAction func lastNameEdited(_ sender: Any) {
        Persistance.shared.userLastName = lastNameTextField.text
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
