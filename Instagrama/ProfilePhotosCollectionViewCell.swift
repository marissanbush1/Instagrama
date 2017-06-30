//
//  ProfilePhotosCollectionViewCell.swift
//  Instagrama
//
//  Created by Marissa Bush on 6/30/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfilePhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profilePhotos: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.profilePhotos.file = instagramPost["media"] as? PFFile
            //self.captionText.text = instagramPost["caption"] as! String
            self.profilePhotos.loadInBackground()
        }
    }

    
}
