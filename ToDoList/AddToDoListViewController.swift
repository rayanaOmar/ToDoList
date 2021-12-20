//
//  AddToDoListViewController.swift
//  ToDoList
//
//  Created by admin on 19/12/2021.
//

import UIKit

class AddToDoListViewController: UIViewController {

    @IBOutlet weak var taskTitleField: UITextField!
    @IBOutlet weak var taskDescrptionField: UITextField!
    @IBOutlet weak var taskDate: UIDatePicker!
    
    let managedObjectContetext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjectSaveContetext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addItemAction(_ sender: UIButton) {
        //make sure the user enter something (validate the user input )
        if taskTitleField.text == "" || taskDescrptionField.text == ""{
            dismiss(animated: true, completion: nil)
        }else{
            let task = ToDoListEntity(context: managedObjectContetext)
            task.taskTitle = taskTitleField.text!
            task.taskDescription = taskDescrptionField.text!
            task.taskDate = taskDate.date
            
            
            
            managedObjectSaveContetext()
            
            print(task)
            dismiss(animated: true, completion: nil)
        }
    }
}
