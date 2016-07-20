### Exploring the Fetched Results Controller Delegate Protocol

#### Author: Bart Jacobs

The `NSFetchedResultsController` class is pretty nice, but you are probably convinced yet by what you learned in the [previous tutorial](https://cocoacasts.com/managing-records-with-fetched-results-controllers/). In this tutorial, we explore the `NSFetchedResultsControllerDelegate` protocol. This protocol enables us to respond to changes in the managed object context the fetched results controller monitors. Let me show you what that means and how it works.

## Where We Left Off

In the [previous tutorial](https://cocoacasts.com/managing-records-with-fetched-results-controllers/), we ran into a problem I promised we would solve in this tutorial. Whenever the user adds a new note, the table view is not updated with the new note. Visit [GitHub](https://github.com/bartjacobs/ManagingRecordsWithFetchedResultsControllers) to clone or download the project we created in the [previous tutorial](https://cocoacasts.com/managing-records-with-fetched-results-controllers/) and open the project in Xcode.

## Monitoring a Managed Object Context

Previously, I wrote that a fetched results controller monitors the managed object context it keeps a reference to. It does this to update the results of its fetch request. But how does it monitor the managed object context? How does the fetched results controller know when a record is added, updated, or deleted?

A managed object context broadcasts notifications for three types of events:

- when one of its managed objects changes
- when the managed object context is about to save its changes
- when the managed object context has saved its changes

If an object would like to be notified of these events, they can add themselves as observers for the following notifications:

- `NSManagedObjectContextObjectsDidChangeNotification`
- `NSManagedObjectContextWillSaveNotification`
- `NSManagedObjectContextDidSaveNotification`

With this in mind, the `NSFetchedResultsController` class is starting to lose some of its magic. A fetched results controller inspects the fetch request it was initialized with and it adds itself as an observer for `NSManagedObjectContextObjectsDidChangeNotification` notifications. This gives the fetched results controller enough information to keep the collection of managed objects it manages updated and synchronized with the state of the managed object context it observes.

You probably know that a notification has a name and, optionally, a `userInfo` dictionary. The notifications I listed earlier have a `userInfo` dictionary, which contains three key-value pairs. The dictionary includes which managed objects have been:

- **inserted**
- **updated**
- **deleted**

That is how the fetched results controller updates its collection of managed objects. The last piece of the puzzle is the `NSFetchedResultsControllerDelegate` protocol. The object that manages the fetched results controller, a view controller, for example, doesn't need to inspect the collection of managed objects the fetched results controller manages. It only needs to set itself as the delegate of the fetched results controller.

**Read this article on [Cocoacasts](https://cocoacasts.com/exploring-the-fetched-results-controller-delegate-protocol/)**.
