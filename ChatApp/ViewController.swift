//
//  ViewController.swift
//  ChatApp
//
//  Created by Jason Wang on 8/13/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
    }

    func handleLogout() {
        let loginController = LoginControllerController()
        presentViewController(loginController, animated: true, completion: nil)
    }
}

