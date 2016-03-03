//
//  ViewController.swift
//  ExerciciosTeste
//
//  Created by Hariel Giacomuzzi on 2/29/16.
//  Copyright © 2016 Giacomuzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    @IBAction func doLoginBTN(sender: AnyObject) {
        ConnectionManager.Connection.login(self.userNameText.text!, Password: self.passwordText.text!, Completion: {result in
            if result{
                self.performSegueWithIdentifier("gotoUserPage", sender: nil)
                return
            }
            self.userNameText.backgroundColor = UIColor.redColor()
            self.passwordText.backgroundColor = UIColor.redColor()
        })
    }
}

