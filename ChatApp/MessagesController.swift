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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_message_icon"), style: .Plain, target: self, action: #selector(handleNewMessage))
        validateUserLogin()
    }
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        presentViewController(navController, animated: true, completion: nil)
    }
    func validateUserLogin() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
        } else {
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                FIRDatabase.database().reference().child("users").child(uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
                    if let dict = snapshot.value as? [String: AnyObject] {
                        self.navigationItem.title = dict["name"] as? String
                    }
                })
            }
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

