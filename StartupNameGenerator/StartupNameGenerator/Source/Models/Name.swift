//
//  Name.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 14/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import Foundation
import CoreData

struct Name {
    let description: String
    var isFavorited: Bool

    init(description: String, isFavorited: Bool) {
        self.description = description
        self.isFavorited = isFavorited
    }

    init(description: String) {
        self.init(description: description, isFavorited: false)
    }
}

/// Core data management
extension Name {

    static func addAsFavorite(_ name: Name, using appDelegate: AppDelegate) -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext

        if !nameAlreadyFavorited(managedContext, name: name) {
            return addNewFavorite(name, managedContext: managedContext)
        }
        return false
    }

    private static func addNewFavorite(_ name: Name, managedContext: NSManagedObjectContext) -> Bool {

        if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext) {
            let favorite = NSManagedObject(entity: entity, insertInto: managedContext)

            favorite.setValue(name.description, forKeyPath: "name")

            do {
                try managedContext.save()
                return true
            } catch let error as NSError {
                print("Error while saving new favorite: \(error)")
                return false
            }
        }
        return false
    }

    private static func nameAlreadyFavorited(_ managedContext: NSManagedObjectContext, name: Name) -> Bool {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let predicate = NSPredicate(format: "name contains[c] %@", name.description)
        fetchRequest.predicate = predicate
        do {
            let count = try managedContext.count(for: fetchRequest)
            return (count > 0) ? true : false
        } catch {
            print("Error while querying name: \(error)")
        }
        return false
    }
}
