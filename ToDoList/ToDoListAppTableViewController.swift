//
//  ToDoListAppTableViewController.swift
//  ToDoList
//
//  Created by admin on 20/12/2021.
//

import UIKit
import CoreData

class ToDoListAppTableViewController: UITableViewController {
    

    let managedObjectContetext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjectSaveContetext = (UIApplication.shared.delegate as! AppDelegate).saveContext
        
        var tasks: [ToDoListEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchTaskItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //fetchTaskItem()
            }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchTaskItem()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
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
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }catch{
            
            print("\(error)")
        }
    }
}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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


