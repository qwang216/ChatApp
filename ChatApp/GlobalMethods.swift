//
//  GlobalMethods.swift
//  ChatApp
//
//  Created by Jason Wang on 8/14/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

func errorAlertTitle(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let ok = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
    alert.addAction(ok)
    return alert
}