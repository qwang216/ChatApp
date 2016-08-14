//
//  LoginControllerViewController.swift
//  ChatApp
//
//  Created by Jason Wang on 8/13/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit
import Firebase

class LoginControllerController: UIViewController {

    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.addTarget(self, action: #selector(handleRegister), forControlEvents: .TouchUpInside)
        return button
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .EmailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.secureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameofthrones_splash")
        imageView.contentMode = .ScaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.whiteColor()
        sc.selectedSegmentIndex = 0
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(inputContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)

        setupInputContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
    }

    func setupInputContainerView() {
        //need x, y, width, height constraings
        inputContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        inputContainerView.heightAnchor.constraintEqualToConstant(150).active = true

        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeparatorView)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSeparatorView)
        inputContainerView.addSubview(passwordTextField)

        //need x, y, width, height constraings
        nameTextField.leftAnchor.constraintEqualToAnchor(inputContainerView.leftAnchor, constant: 12).active = true
        nameTextField.topAnchor.constraintEqualToAnchor(inputContainerView.topAnchor).active = true
        nameTextField.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        nameTextField.heightAnchor.constraintEqualToAnchor(inputContainerView.heightAnchor, multiplier: 1/3).active = true

        //need x, y, width, height constraings
        nameSeparatorView.leftAnchor.constraintEqualToAnchor(inputContainerView.leftAnchor).active = true
        nameSeparatorView.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        nameSeparatorView.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        nameSeparatorView.heightAnchor.constraintEqualToConstant(1).active = true

        //need x, y, width, height constraings
        emailTextField.leftAnchor.constraintEqualToAnchor(inputContainerView.leftAnchor, constant: 12).active = true
        emailTextField.topAnchor.constraintEqualToAnchor(nameSeparatorView.bottomAnchor).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        emailTextField.heightAnchor.constraintEqualToAnchor(inputContainerView.heightAnchor, multiplier: 1/3).active = true

        //need x, y, width, height constraings
        emailSeparatorView.leftAnchor.constraintEqualToAnchor(inputContainerView.leftAnchor).active = true
        emailSeparatorView.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        emailSeparatorView.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        emailSeparatorView.heightAnchor.constraintEqualToConstant(1).active = true

        //need x, y, width, height constraings
        passwordTextField.leftAnchor.constraintEqualToAnchor(inputContainerView.leftAnchor, constant: 12).active = true
        passwordTextField.topAnchor.constraintEqualToAnchor(emailSeparatorView.bottomAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        passwordTextField.heightAnchor.constraintEqualToAnchor(inputContainerView.heightAnchor, multiplier: 1/3).active = true
    }

    func setupLoginRegisterButton() {
        //need x, y, width, height constraings
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputContainerView.bottomAnchor, constant: 12).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
    }

    func setupProfileImageView() {
        //need x, y, width, height constraings
        profileImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        profileImageView.bottomAnchor.constraintEqualToAnchor(loginRegisterSegmentedControl.topAnchor, constant: -12).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(150).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(150).active = true
    }

    func setupLoginRegisterSegmentedControl() {
        //need x, y, width, height constraings
        loginRegisterSegmentedControl.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterSegmentedControl.bottomAnchor.constraintEqualToAnchor(inputContainerView.topAnchor, constant: -12).active = true
        loginRegisterSegmentedControl.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        loginRegisterSegmentedControl.heightAnchor.constraintEqualToConstant(30).active = true
    }
    func handleRegister() {
        guard let email = emailTextField.text where email != "", let password = passwordTextField.text where password != "", let name = nameTextField.text where name != "" else {
            return errorAlertWithMessage("Invalid Field", message: "Please enter valid Email/Password")
        }

        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
            if error != nil {
                print("login email error === \(error)")
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
                self.emailTextField.resignFirstResponder()
                self.nameTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                self.dismissViewControllerAnimated(true, completion: nil)
            })

        })
    }
    private func errorAlertWithMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}






