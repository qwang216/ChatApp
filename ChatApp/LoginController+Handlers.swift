//
//  LoginController+Handlers.swift
//  ChatApp
//
//  Created by Jason Wang on 8/14/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func handleRegisterLogin() {
        activityIndicator.startAnimating()
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
        emailTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    func handleLogin() {
        guard let email = emailTextField.text where email != "", let password = passwordTextField.text where password != "" else {
            return presentViewController(errorAlertTitle("Invalid Field", message: "Please enter valid Email/Password"), animated: true, completion: nil)
        }
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            self.activityIndicator.stopAnimating()
            if error != nil {
                self.presentViewController(errorAlertTitle("Login Failed", message: (error?.localizedDescription)!), animated: true, completion: nil)
                return
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }

    func handleRegister() {
        guard let email = emailTextField.text where email != "", let password = passwordTextField.text where password != "", let name = nameTextField.text else {
            return presentViewController(errorAlertTitle("Invalid Field", message: "Please enter valid Email/Password"), animated: true, completion: nil)
        }
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
            self.activityIndicator.stopAnimating()
            if error != nil {
                if let registerError = error?.localizedDescription {
                    self.presentViewController(errorAlertTitle("Register Error", message: registerError), animated: true, completion: nil)
                }
                return
            }
            guard let uid = user?.uid else { return }

            let ref = FIRDatabase.database().referenceFromURL("https://chatapp-ef905.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print("save login erro = \(err)")
                    return
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            })  
        })
    }
    
    func handleLoginRegisterSegmentedControler() {
        let title = loginRegisterSegmentedControl.titleForSegmentAtIndex(loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, forState: .Normal)

        // change height of inputContainerView ???
        inputContainerHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150

        // change height of nameTextField
        nameTextFieldHeightAnchor?.active = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.active = true

        emailTextFieldHeighAnchor?.active = false
        emailTextFieldHeighAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeighAnchor?.active = true

        passwordTextFieldHeighAnchor?.active = false
        passwordTextFieldHeighAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeighAnchor?.active = true
    }

    func handleprofileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            print(originalImage.size)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}
