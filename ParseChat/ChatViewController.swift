//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Joey Dafforn on 1/31/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatMessageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject] = []
    let chatMessage = PFObject(className: "Message")
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //self.tableView.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 200
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    @IBAction func sendButton(_ sender: Any) {
        chatMessage["text"] = chatMessageTextField.text ?? ""
        chatMessage["user"] = PFUser.current()
        //print(PFUser.current())
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageTextField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 20
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let post = messages[indexPath.row]
        let asdf = post["text"] as! String
        //print(asdf)
        cell.messageContentsLabel.text = asdf
        if let user = chatMessage["user"] as? PFUser {
            // User found! update username label with username
            cell.userNameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.userNameLabel.text = "🤖"
        }
        return cell
    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Message")
        
        query.addAscendingOrder("createdAt")
        
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                for post in posts! {
                    //print (post["text"])
                }
                self.messages = posts!
                self.tableView.reloadData()
            }
            else {
                print(error)
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
