//
//  LoginControllerViewController.swift
//  ChatApp
//
//  Created by Jason Wang on 8/13/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class LoginControllerController: UIViewController {

    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        return button
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(inputContainerView)
        view.addSubview(loginRegisterButton)
        setupInputContainerView()
        setupLoginRegisterButton()
    }

    func setupInputContainerView() {
        //need x, y, width, height constraings
        inputContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        inputContainerView.heightAnchor.constraintEqualToConstant(150).active = true

        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeparatorView)

        //need x, y, width, height constraings
        nameTextField.leftAnchor.constraintEqualToAnchor(inputContainerView.leftAnchor, constant: 12).active = true
        nameTextField.topAnchor.constraintEqualToAnchor(inputContainerView.topAnchor).active = true
        nameTextField.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        nameTextField.heightAnchor.constraintEqualToAnchor(inputContainerView.heightAnchor, multiplier: 1/3).active = true

        nameSeparatorView.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        nameSeparatorView.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        nameSeparatorView.heightAnchor.constraintEqualToConstant(1).active = true

    }

    func setupLoginRegisterButton() {
        //need x, y, width, height constraings
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputContainerView.bottomAnchor, constant: 12).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputContainerView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
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