//
//  TodoDetailViewController.swift
//  iOSTodos
//
//  Created by Hideaki Ishii on 2/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit
import CoreData

class TodoDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var todo: Todos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        
        if todo != nil {
            self.textField.text = todo?.content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "Content is empty!", preferredStyle: .Alert)
        let dafaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dafaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func checkContentAndSave() {
        var error: NSError?
        if !managedObjectContext!.save(&error) {
            showAlert()
            managedObjectContext!.rollback()
        }
    }
    
    func createTodo() {
        let entity = NSEntityDescription.entityForName("Todos", inManagedObjectContext: managedObjectContext!)
        let todo = Todos(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        todo.content = self.textField.text
        self.checkContentAndSave()
    }
    
    func editTodo() {
        todo?.content = self.textField.text
        self.checkContentAndSave()
    }
    
    @IBAction func save(sender: AnyObject) {
        if todo != nil {
            self.editTodo()
        } else {
            self.createTodo()
        }
        self.dismissViewController()
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewController()
    }
}