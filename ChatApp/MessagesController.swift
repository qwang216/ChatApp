//
//  ViewController.swift
//  ChatApp
//
//  Created by Jason Wang on 8/13/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))

        if FIRAuth.auth()?.currentUser?.uid == nil {
            handleLogout()
        }
    }

    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            let error = logoutError as NSError
            print("logout error == \(logoutError)")
            presentViewController(errorAlertTitle("Authntication Error", message: "Logout Error \(error.localizedFailureReason)"), animated: true, completion: nil)
        }
        let loginController = LoginControllerController()
        presentViewController(loginController, animated: true, completion: nil)
    }
}

