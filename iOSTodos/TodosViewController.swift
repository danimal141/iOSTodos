//
//  TodosViewController.swift
//  iOSTodos
//
//  Created by Hideaki Ishii on 2/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit
import CoreData

class TodosViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Properties
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    lazy var fetchedResultController: NSFetchedResultsController = {
        guard let managedObjectContext = self.managedObjectContext else { return NSFetchedResultsController() }
        let fetchedResultController = NSFetchedResultsController(fetchRequest: self.todoFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()

    lazy var todoFetchRequest: NSFetchRequest = {
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        let sortDescriptor = NSSortDescriptor(key: "content", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }()


    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try self.fetchedResultController.performFetch()
        } catch _ {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


     // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("Edit"):
            guard let cell = sender as? UITableViewCell else { return }
            guard let indexPath = self.tableView.indexPathForCell(cell) else { return }
            let todo = self.fetchedResultController.objectAtIndexPath(indexPath) as? Todo
            let todoDetailsController = segue.destinationViewController as! TodoDetailsViewController
            todoDetailsController.todo = todo
        default: break
        }
    }


    // MARK: - UITableViewDataSource protocol


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInsection = self.fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInsection ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let todo = self.fetchedResultController.objectAtIndexPath(indexPath) as! Todo
        cell.textLabel?.text = todo.content
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let managedObject = self.fetchedResultController.objectAtIndexPath(indexPath) as? NSManagedObject else { return }
        self.managedObjectContext?.deleteObject(managedObject)
        do {
            try managedObjectContext?.save()
        } catch {
            managedObjectContext?.rollback()
        }
    }


    // MARK: - NSFetchedResultsControllerDelegate Protocol 
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }

}
