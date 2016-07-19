//
//  ViewController.swift
//  Notes
//
//  Created by Bart Jacobs on 19/07/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddNoteViewControllerDelegate {

    @IBOutlet var tableView: UITableView!
    
    var coreDataManager: CoreDataManager = CoreDataManager()

    private lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Note")

        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        return fetchedResultsController
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Save Note")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }

    // MARK: - Segue Handling

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueAddNoteViewController" {
            if let navigationController = segue.destinationViewController as? UINavigationController,
                let viewController = navigationController.viewControllers.first as? AddNoteViewController {
                // Configure View Controller
                viewController.delegate = self
            }
        }
    }

    // MARK: - Table View Data Source Methods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath)

        // Fetch Note
        if let note = fetchedResultsController.objectAtIndexPath(indexPath) as? Note {
            cell.textLabel?.text = note.title
            cell.detailTextLabel?.text = note.content
        }
        
        return cell
    }

    // MARK: - Add Note View Controller Delegate Methods

    func controller(controller: AddNoteViewController, didAddNoteWithTitle title: String) {
        // Create Entity
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: coreDataManager.managedObjectContext)

        if let entity = entity {
            // Create Note
            let note = Note(entity: entity, insertIntoManagedObjectContext: coreDataManager.managedObjectContext)

            // Populate Note
            note.content = ""
            note.title = title
            note.updatedAt = NSDate().timeIntervalSinceReferenceDate
            note.createdAt = NSDate().timeIntervalSinceReferenceDate

            do {
                try note.managedObjectContext?.save()
            } catch {
                let saveError = error as NSError
                print("Unable to Save Note")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        }
    }

}
