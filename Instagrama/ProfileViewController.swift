//
//  ProfileViewController.swift
//  Instagrama
//
//  Created by Marissa Bush on 6/30/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profilePhotosCollectionView: UICollectionView!
    
    var userPost: [PFObject]?
    var user: PFUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        profilePhotosCollectionView.dataSource = self
        user = PFUser.current()
        let username = user!.username
        
        
        profileNameLabel.text = username!
        
        refresh()

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return userPost?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = profilePhotosCollectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotosCollectionViewCell", for: indexPath) as! ProfilePhotosCollectionViewCell
        let post = self.userPost![indexPath.row]
        cell.instagramPost = post
        
        return cell
    }
    
    func refresh(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.userPost = posts
                self.profilePhotosCollectionView.reloadData()
                
            } else {
                print(error?.localizedDescription)
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
