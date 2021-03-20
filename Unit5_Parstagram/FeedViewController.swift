//
//  FeedViewController.swift
//  Unit5_Parstagram
//
//  Created by Aryum Jeon on 3/12/21.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let commentBar = MessageInputBar()
    
    var posts = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    override var inputAccessoryView: UIView?
    {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
//        let user = post["author"] as! PFUser
//        cell.usernameLabel.text = user.username
//        cell.captionLabel.text = post["caption"] as! String
//
//        let imageFile = post["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//        cell.photoView.af_setImage(withURL: url)
//
//        return cell
        
//
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell


            let user = post["author"] as! PFUser
            cell.usernameLabel.text = user.username
            cell.captionLabel.text = post["caption"] as! String

            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!

            cell.photoView.af_setImage(withURL: url)

            return cell
        } else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell

            //cause error - part 2.4
//            let comment = comments[indexPath.row - 1]
//            cell.commentLabel.text = comment["text"] as? String
//
//            let user = comment["author"] as! PFUser
//            cell.nameLabel.text = user.username

            return cell

        }
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        query.findObjectsInBackground{(posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let post = posts[indexPath.row]
        let comment = PFObject(className: "Comments")
        comment["text"] = "This is a random comment"
        comment["post"] = post
        comment["author"] = PFUser.current()!
        post.add(comment, forKey: "comments")
        post.saveInBackground{(success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            }
        }
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        PFUser.logOut()
        self.performSegue(withIdentifier: "logoutSeque", sender: nil)

        
        
        
        
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
//        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        delegate.window?.rootViewController = loginViewController
        
    }
    
}
