//
//  StartupName.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 14/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import Foundation
import CoreData

struct StartupName {
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

/// Enabling the usage of the array contains method by conforming to Equatable
extension StartupName: Equatable {
    public static func == (lhs: StartupName, rhs: StartupName) -> Bool {
        return lhs.description == rhs.description
    }
}

/// Core data management
extension StartupName {
    static func addAsFavorite(_ startupName: StartupName, using appDelegate: AppDelegate) -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext

        if !nameAlreadyFavorited(managedContext, startupName: startupName) {
            return addNewFavorite(startupName, managedContext: managedContext)
        }
        return false
    }

    private static func addNewFavorite(_ startupName: StartupName, managedContext: NSManagedObjectContext) -> Bool {

        if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext) {
            let favorite = NSManagedObject(entity: entity, insertInto: managedContext)

            favorite.setValue(startupName.description, forKeyPath: "name")
            favorite.setValue(Date(), forKey: "creationDate")

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

    private static func nameAlreadyFavorited(_ managedContext: NSManagedObjectContext,
                                             startupName: StartupName) -> Bool {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let predicate = NSPredicate(format: "name contains[c] %@", startupName.description)
        fetchRequest.predicate = predicate
        do {
            let count = try managedContext.count(for: fetchRequest)
            return (count > 0) ? true : false
        } catch let error as NSError {
            print("Error while querying name: \(error.description)")
            return false
        }
    }

    static func loadFavorites(using appDelegate: AppDelegate) -> [StartupName] {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let names = try managedContext.fetch(fetchRequest)
            var favorites = [StartupName]()

            for name in names {
                guard let description = name.value(forKey: "name") as? String else {
                    fatalError("Error while creating favorite list")
                }
                favorites.append(StartupName(description: description, isFavorited: true))
            }
            return favorites

        } catch let error as NSError {
            print("Error while fetching favorites: \(error.description)")
            return []
        }
    }
}
