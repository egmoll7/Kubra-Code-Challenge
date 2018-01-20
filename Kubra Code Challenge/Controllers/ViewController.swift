//
//  ViewController.swift
//  Kubra Code Challenge
//
//  Created by Eduardo Moll on 1/20/18.
//  Copyright © 2018 Eduardo Moll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var users: [User] = []
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
}

extension ViewController {
  
  func setUp() {
    
    title = "Users"
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.register(UserCell.nibForCell(), forCellReuseIdentifier: UserCell.identifierForCell)
    
    APIManager.loadUsers { (users) in
      self.users = users
      self.tableView.reloadData()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "postSegue" {
      guard let index = self.tableView.indexPathForSelectedRow else { return }
      let vc = segue.destination as! PostController
      vc.user = users[index.row]
    }
  }
}

// MARK: UITableView Data Source Methods
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifierForCell, for: indexPath) as! UserCell
    let currentUser = users[indexPath.row]
    cell.populateWith(user: currentUser)
    return cell
  }
}

// MARK: UITableView Delegate Methods
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "postSegue", sender: self)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}


