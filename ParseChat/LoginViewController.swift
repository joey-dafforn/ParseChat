//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Joey Dafforn on 1/29/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    let alertController = UIAlertController(title: "Username or password is empty", message: "", preferredStyle: .alert)

    @IBAction func signupButton(_ sender: Any) {
        if !usernameText.hasText {
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        else {
            registerUser()
        }
    }
    @IBAction func loginButton(_ sender: Any) {
        if !passwordText.hasText {
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        else {
            loginUser()
        }
    }
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // add the cancel action to the alertController

        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameText.text
        newUser.password = passwordText.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    func loginUser() {
        
        let username = usernameText.text ?? ""
        let password = passwordText.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
