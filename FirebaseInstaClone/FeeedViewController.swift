//
//  FeeedViewController.swift
//  FirebaseInstaClone
//
//  Created by İSMAİL AÇIKYÜREK on 29.03.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
   
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var useremailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userımageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        //function written to retrieve data
        let fireStroreDatabase = Firestore.firestore()
        
        //order(by: "date", descending: true) sort by date
        fireStroreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener {
            snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true  {
                    self.userımageArray.removeAll(keepingCapacity: false)
                    self.useremailArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                       let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                        
                        if let postedBy = document.get("postedBy")  as? String {
                            self.useremailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment")  as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes")  as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageURL = document.get("imageURL")  as? String {
                            self.userımageArray.append(imageURL)
                        }
    
                    }
                    self.tableView.reloadData()
                    
                }
             
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.usernameLabel.text = useremailArray[indexPath.row]
        cell.likeLbl.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userimageLbl.sd_setImage(with: URL(string: self.userımageArray[indexPath.row])) //url translation
        cell.documntıdLabel.text = documentIdArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailArray.count
    }
    

}
