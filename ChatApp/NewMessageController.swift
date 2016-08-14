//
//  NewMessageController.swift
//  ChatApp
//
//  Created by Jason Wang on 8/14/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class NewMessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(handleCancel))
    }

    func handleCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
