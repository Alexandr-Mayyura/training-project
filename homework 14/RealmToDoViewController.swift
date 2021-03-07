//
//  RealmToDoViewController.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 04.03.2021.
//


import UIKit
import RealmSwift

class RealmToDoViewController: UITableViewController {

    var realm: Realm!
    var openTask: Results<Task> {
        get {
            return realm.objects(Task.self)
        }
           
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertVC = UIAlertController(title: "Новая запись", message: "", preferredStyle: .alert)
       
            alertVC.addTextField { (UITextField) in }
       
              let cancelAction = UIAlertAction.init(title: "Закрыть", style: .default, handler: nil)

              let addAction = UIAlertAction.init(title: "Сохранить", style: .cancel) { (UIAlertAction) -> Void in
       
                let textFieldReminder = (alertVC.textFields?.first)! as UITextField
       //сохранение новых данных
                let reminderItem = Task()
                  reminderItem.notes = textFieldReminder.text!
                  reminderItem.isCompleted = false
               
                  try! self.realm.write {
                      self.realm.add(reminderItem)

                    self.tableView.insertRows(at: [IndexPath.init(row: self.openTask.count-1, section: 0)], with: .automatic)
                    
                  }
              }
        
            alertVC.addAction(cancelAction)
            alertVC.addAction(addAction)
        
          present(alertVC, animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // загрузка данных
        realm = try! Realm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return openTask.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task: Task!
        task = openTask[indexPath.row]
        cell.textLabel?.text = task!.notes
        
        if task.isCompleted == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // удаление данных
        if editingStyle == .delete {
            let item = openTask[indexPath.row]
            try! self.realm.write {
                self.realm.delete(item)
            }
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // нажатие на ячейку
        let item = openTask[indexPath.row]
        try! self.realm.write {
            item.isCompleted = !item.isCompleted
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)

    }

}
