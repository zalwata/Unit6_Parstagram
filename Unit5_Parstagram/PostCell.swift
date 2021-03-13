//
//  PostCell.swift
//  Unit5_Parstagram
//
//  Created by Aryum Jeon on 3/12/21.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
