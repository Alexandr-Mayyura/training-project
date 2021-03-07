//
//  CoreDataToDoViewController.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import UIKit
import CoreData

class CoreDataToDoViewController: UITableViewController {
 
    var list: [List] = []
    
    @IBAction func addNewTask(_ sender: Any) {
        let alertVC = UIAlertController(title: "Новая запись", message: "", preferredStyle: .alert)
       
              alertVC.addTextField { (UITextField) in }
       
              let cancelAction = UIAlertAction.init(title: "Закрыть", style: .default, handler: nil)

              let addAction = UIAlertAction(title: "Сохранить", style: .cancel) { action in
       
                let textField = alertVC.textFields?[0]
                self.saveTask(taskToDo: textField!.text!, isComplit: false)
                self.tableView.reloadData()
                    
                  }
        
            alertVC.addAction(cancelAction)
            alertVC.addAction(addAction)
        
            present(alertVC, animated: true, completion: nil)

    }
    
    func context() -> NSManagedObjectContext{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func saveTask(taskToDo: String, isComplit: Bool){

        let entity = NSEntityDescription.entity(forEntityName: "List", in: context())
        let taskObject = NSManagedObject(entity: entity!, insertInto: context()) as! List
        
        taskObject.toDoTask = taskToDo
        taskObject.isComplit = isComplit
        
        try! context().save()
        list.append(taskObject)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequest: NSFetchRequest<List> = List.fetchRequest()
        list = try! context().fetch(fetchRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreCell", for: indexPath)

        let task = list[indexPath.row]
        cell.textLabel?.text = task.toDoTask
        
        if task.isComplit == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = list[indexPath.row]
            item.isComplit = !item.isComplit

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        context().delete(list[indexPath.row] as NSManagedObject)
        list.remove(at: indexPath.row)
        try! context().save()
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
