//
//  Todos.swift
//  iOSTodos
//
//  Created by Hideaki Ishii on 2/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import Foundation
import CoreData

class Todo: NSManagedObject {

    @NSManaged var content: String
    
    func validateContent(ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>) throws {
        let error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        if let content = ioValue.memory as? String {
            if content.isEmpty {
                print("Content is empty...")
                throw error
            }
        } else {
            print("Content is nil...")
            throw error
        }
    }
    
}
