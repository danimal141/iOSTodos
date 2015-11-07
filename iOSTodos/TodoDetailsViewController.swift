//
//  TodoDetailViewController.swift
//  iOSTodos
//
//  Created by Hideaki Ishii on 2/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit
import CoreData

class TodoDetailsViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var todo: Todo?


    // MARK: - IBOutlets

    @IBOutlet weak var textField: UITextField!


    // MARK: - IBActions
    
    @IBAction func save(sender: AnyObject) {
        if let _ = self.todo {
            self.editTodo()
        } else {
            self.createTodo()
        }
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewController()
    }


    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self

        if let todo = self.todo {
            self.textField.text = todo.content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - UITextFieldDelegate Protocol
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    // MARK: - Private methods

    private func dismissViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: (message ?? ""), preferredStyle: .Alert)
        let dafaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dafaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func saveTodo() {
        do {
            try self.managedObjectContext?.save()
            self.dismissViewController()
        } catch let error as NSError {
            self.showAlert(error.localizedDescription)
            self.managedObjectContext?.rollback()
        }
    }
    
    private func createTodo() {
        guard let managedObjectContext = self.managedObjectContext else { return }
        guard let text = self.textField.text else { return }

        let entity = NSEntityDescription.entityForName("Todo", inManagedObjectContext: managedObjectContext)
        let todo = Todo(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        todo.content = text
        self.saveTodo()
    }
    
    private func editTodo() {
        guard let todo = self.todo, let text = self.textField.text else { return }
        todo.content = text
        self.saveTodo()
    }

}
