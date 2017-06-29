//
//  HomeViewController.swift
//  Instagrama
//
//  Created by Marissa Bush on 6/27/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var post: [PFObject]!
    
    var refreshControl = UIRefreshControl()

    
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
        homeTableView.dataSource = self
        refresh()
        
        refreshControl.addTarget(self, action: #selector(HomeViewController.pullToRefresh(_:)), for: .valueChanged)
        homeTableView.insertSubview(refreshControl, at: 0)
    }

    func refresh(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.post = posts
                self.homeTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func pullToRefresh(_ refreshControl: UIRefreshControl){
        refresh()
        homeTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "instag", for: indexPath) as! InstagramPostTableViewCell
        let post = self.post![indexPath.row]
        
        cell.instagramPost = post
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return post?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        
        if let indexPath = homeTableView.indexPath(for: cell) {
            let post = self.post[indexPath.row]
            
            let vc = segue.destination as! DetailViewController
            
            vc.posts = post
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}
