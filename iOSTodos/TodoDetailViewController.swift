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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewController() {
        //※Can not use dismissViewControllerAnimated
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createTodo() {
        let entityDescripition = NSEntityDescription.entityForName("Todos", inManagedObjectContext: managedObjectContext!)
        let todo = Todos(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        
        todo.content = self.textLabel.text
        managedObjectContext?.save(nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        //self.createTodo()
        self.dismissViewController()
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewController()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
