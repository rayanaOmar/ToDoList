//
//  ViewController.swift
//  ToDoList
//
//  Created by admin on 19/12/2021.
//

import UIKit
import CoreData

class ToDoListTableViewController: UITableViewController {
    
    let managedObjectContetext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjectSaveContetext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var tasks: [ToDoListEntity] = []
    
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchTaskItem()
        tableView.reloadData()
        
     
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! TableViewCell
        
        let task = tasks[indexPath.row]
        cell.taskTitleCell.text = task.taskTitle!
        cell.taskDescrptionCell.text = task.taskDescription!
        
        //date Section
        let date = DateFormatter()
        date.dateStyle = .short
        date.timeStyle = .none
        
        let dateText = date.string(from: task.taskDate!)
        cell.taskDateCell.text = dateText
        
        //status section
        if task.taskStatus{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        task.taskStatus = !task.taskStatus
        if task.taskStatus {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        managedObjectSaveContetext()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        managedObjectContetext.delete(task)
        
        managedObjectSaveContetext()
        
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func fetchTaskItem(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoListEntity")
        do{
            let results = try managedObjectContetext.fetch(request)
            tasks = results as! [ToDoListEntity]
        }catch{
            print("\(error)")
        }
    }
}













































