//
//  FeedCell.swift
//  FirebaseInstaClone
//
//  Created by İSMAİL AÇIKYÜREK on 30.03.2022.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var userimageLbl: UIImageView!
    
    @IBOutlet weak var documntıdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeBtnClkcked(_ sender: Any) {
        
        let fireStoreDatabese = Firestore.firestore()
        if let likeCount = Int(likeLbl.text!) {
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            fireStoreDatabese.collection("Posts").document(documntıdLabel.text!).setData(likeStore, merge: true)
        }
        
        
    }
}
