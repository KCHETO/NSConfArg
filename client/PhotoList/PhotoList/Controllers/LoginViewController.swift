//
//  ViewController.swift
//  PhotoList
//
//  Created by Nicolas Purita on 8/2/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var username: UITextField! {
        didSet {
            username.drawLine(.Bottom, color: UIColor.blackColor())
        }
    }

    @IBOutlet weak var password: UITextField! {
        didSet {
            password.drawLine(.Bottom, color: UIColor.blackColor())
        }
    }
    
    @IBOutlet weak var loginButton: RoundedButton! {
        didSet {
            loginButton.cornerRadius = 20
            loginButton.borderWidth = 2
            loginButton.borderColor = UIColor(red: 0.220, green: 0.792, blue: 0.992, alpha: 1.0)
        }
    }
    
    // Private variables
    private let _operationQueue = OperationQueue()
    private var _loginOperation: LoginOperation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.username.becomeFirstResponder()
    }

    @IBAction func login(sender: AnyObject) {
        if canDoLogin() {
            if let username = self.username.text, password = self.password.text {
                _loginOperation = LoginOperation(username: username, password: password) {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                _operationQueue.addOperation(_loginOperation!)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Credenciales invalidas", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(ok)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}

// MARK: - Private

extension LoginViewController {
    
    private func canDoLogin() -> Bool {
        return self.username.text?.length > 0 && self.password.text?.length > 0
    }
    
}

