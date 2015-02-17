//
//  Todos.swift
//  iOSTodos
//
//  Created by Hideaki Ishii on 2/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import Foundation
import CoreData

class Todos: NSManagedObject {

    @NSManaged var content: String
    
    func validateContent(ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>, error: NSErrorPointer) -> Bool {
        if let content = ioValue.memory as? String {
            if content == "" {
                println("Content is empty...")
                return false
            }
        } else {
            println("Content is nil...")
            return false
        }
        return true
    }
}