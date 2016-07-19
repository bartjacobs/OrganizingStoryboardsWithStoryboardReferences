//
//  AddNoteViewContorller.swift
//  Notes
//
//  Created by Bart Jacobs on 19/07/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol AddNoteViewControllerDelegate {
    func controller(controller: AddNoteViewController, didAddNoteWithTitle title: String)
}

class AddNoteViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!

    var delegate: AddNoteViewControllerDelegate?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions

    @IBAction func save(sender: UIBarButtonItem) {
        if let title = titleTextField.text, let delegate = delegate {
            // Notify Delegate
            delegate.controller(self, didAddNoteWithTitle: title)

            // Dismiss View Controller
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
