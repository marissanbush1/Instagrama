//
//  HomeViewController.swift
//  Instagrama
//
//  Created by Marissa Bush on 6/27/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBAction func logOutButton(_ sender: Any) {
        
        PFUser.logOutInBackground { (error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
            } else{
                print("Log out successful")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(LoginViewController, animated: true, completion: {
                })
            }
                
            // PFUser.currentUser() will now be nil
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func refresh(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                // do something with the data fetched
            } else {
                // handle error
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
