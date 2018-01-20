//
//  PostController.swift
//  Kubra Code Challenge
//
//  Created by Eduardo Moll on 1/20/18.
//  Copyright © 2018 Eduardo Moll. All rights reserved.
//

import UIKit

class PostController: UIViewController {
  
  var user: User!
  var posts: [Post] = []
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setUp()
  }
}

extension PostController {
  
  func setUp() {
    
    title = "Posts - \(user.username)"
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.register(PostCell.nibForCell(), forCellReuseIdentifier: PostCell.identifierForCell)
    
    APIManager.loadPostFor(user: user) { (posts) in
      self.posts = posts
      self.tableView.reloadData()
    }
  }
}

extension PostController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifierForCell, for: indexPath) as! PostCell
    
    let currentPost = posts[indexPath.row]
    cell.populateWith(post: currentPost)
    
    return cell
  }
}
