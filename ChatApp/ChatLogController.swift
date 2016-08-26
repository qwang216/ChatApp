//
//  ChatLogController.swift
//  ChatApp
//
//  Created by Jason Wang on 8/26/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController {
    override func viewDidLoad() {
        navigationController?.title = "chat log controller"
        collectionView?.backgroundColor = .whiteColor()
        view.addSubview(inputContainerView)
        setupInputContainerComponent()
    }

    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .redColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setupInputContainerComponent() {
        inputContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        inputContainerView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        inputContainerView.heightAnchor.constraintEqualToConstant(50).active = true
    }

}
