//
//  TodoDetailViewController.swift
//  iOSTodos
//
//  Created by Hideaki Ishii on 2/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit
import CoreData

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var textLabel: UITextField!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var todo: Todos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todo != nil {
            self.textLabel.text = todo?.content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createTodo() {
        let entityDescripition = NSEntityDescription.entityForName("Todos", inManagedObjectContext: managedObjectContext!)
        let todo = Todos(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        
        todo.content = self.textLabel.text
        managedObjectContext?.save(nil)
    }
    
    func editTodo() {
        todo?.content = self.textLabel.text
        managedObjectContext?.save(nil)
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
