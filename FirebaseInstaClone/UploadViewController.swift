//
//  UploadViewController.swift
//  FirebaseInstaClone
//
//  Created by İSMAİL AÇIKYÜREK on 29.03.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.isUserInteractionEnabled = true //tıklanabilir
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choseimage))
        imageview.addGestureRecognizer(gestureRecognizer)
        
        
    }
    @objc func choseimage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func UploadBtn(_ sender: Any) {
        
        let storagee = Storage.storage()
        let storangeReference = storagee.reference()
        let mediaFolder = storangeReference.child("media")
       
        
        if let data = imageview.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata,error) in
                if error != nil {
                    self.makeAlert(title: "error", message: error!.localizedDescription)
                   
                    
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageURL = url?.absoluteString
                        
                            //DATABASE
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            let fireStorePost = ["imageURL" : imageURL!, "postedBy" : Auth.auth().currentUser!.email, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]  // FieldValue.serverTimestamp() -> güncel zaman
                           
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: fireStorePost , completion: { error in
                                if error != nil {
                                    self.makeAlert(title: "erorr", message: error!.localizedDescription)
                                } else {
                                    self.imageview.image = UIImage(named: "select")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0 //yani feed/e git
                                }
                            })
                        }
                    }
                    
                }
            }
        }
            
    }
    func makeAlert(title : String , message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert,animated: true)

    }
    
    
}
