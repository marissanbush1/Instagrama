//
//  InstagramPostTableViewCell.swift
//  Instagrama
//
//  Created by Marissa Bush on 6/28/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstagramPostTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: PFImageView!

    @IBOutlet weak var captionText: UILabel!
    var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["media"] as? PFFile
            self.captionText.text = instagramPost["caption"] as! String
            self.photoView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
