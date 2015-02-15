//
//  TodoDetailViewController.swift
//  iOSTodos
//
//  Created by Hideaki Ishii on 2/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var textLabel: UITextField!
    
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
    
    @IBAction func save(sender: AnyObject) {
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
