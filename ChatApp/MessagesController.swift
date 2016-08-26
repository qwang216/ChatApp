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
            fetchUserAndSetupNavBarTitle()
        }
    }

    func fetchUserAndSetupNavBarTitle() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            FIRDatabase.database().reference().child("users").child(uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
                if let dict = snapshot.value as? [String: AnyObject] {
                    let user = User()
                    user.setValuesForKeysWithDictionary(dict)
                    self.setupNavBarWithUser(user)
                }
            })
    }

    func setupNavBarWithUser(user: User) {
        navigationItem.title = user.name
        let titleView = UIView()
        titleView.frame = CGRectMake(0, 0, 100, 40)

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)

        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .ScaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.layer.masksToBounds = true
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        titleView.addSubview(profileImageView)
        // x, y, height, width constrain
        profileImageView.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor).active = true
        profileImageView.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(40).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(40).active = true

        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLabel)
        // x, y, height, width constrain
        nameLabel.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor).active = true
        nameLabel.rightAnchor.constraintEqualToAnchor(containerView.rightAnchor).active = true
        nameLabel.leftAnchor.constraintEqualToAnchor(profileImageView.rightAnchor, constant: 8).active = true
        nameLabel.heightAnchor.constraintEqualToAnchor(profileImageView.heightAnchor).active = true

        containerView.centerXAnchor.constraintEqualToAnchor(titleView.centerXAnchor).active = true
        containerView.centerYAnchor.constraintEqualToAnchor(titleView.centerYAnchor).active = true

        navigationItem.titleView = titleView
        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTitleViewTap)))
    }

    let chatLogController: ChatLogController = {
        let chatlogC = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        return chatlogC
    }()

    func handleTitleViewTap() {
        navigationController?.pushViewController(chatLogController, animated: true)
    }

    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            let error = logoutError as NSError
            print("logout error == \(logoutError)")
            presentViewController(errorAlertTitle("Authntication Error", message: "Logout Error \(error.localizedFailureReason)"), animated: true, completion: nil)
        }
        let loginController = LoginController()
        loginController.messagesController = self
        presentViewController(loginController, animated: true, completion: nil)
    }
}

