//
//  APIManager.swift
//  Kubra Code Challenge
//
//  Created by Eduardo Moll on 1/20/18.
//  Copyright © 2018 Eduardo Moll. All rights reserved.
//

import Alamofire
import UIKit
class APIManager {
  
  
  /// Loads all users
  static func loadUsers(completion: @escaping ([User]) -> Void) {
    
    guard let url = URL(string: APIUrl.getUsers) else { return }
    
    Alamofire.request(url).responseJSON { (data) in
      
      guard let userData = data.data else { return }
      
      var users: [User] = []
      
      do {
        let json = try JSONSerialization.jsonObject(with: userData, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        for dict in json as! [[String: AnyObject]] {
          
          let addressDict = dict["address"] as! [String: AnyObject]
          
          guard let id = dict["id"] as? Int,
            let username = dict["username"] as? String,
            let street = addressDict["street"] as? String,
            let suite = addressDict["suite"] as? String,
            let city = addressDict["city"] as? String,
            let zip = addressDict["zipcode"] as? String else {
              return
          }
          
          let userAddress = "\(street) \(suite), \(city) \(zip)"
          
          let user = User(id: id, username: username, address: userAddress)
          users.append(user)
          completion(users)
        }
        
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    }
  }
  
  /// Load all the post of a specific user
  static func loadPostFor(user: User, completion: @escaping ([Post]) -> Void) {
    
    guard let url = URL(string: APIUrl.getPosts) else { return }
    
    let parameters = ["userId": user.id]
    
    Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
      
      
      guard let postData = data.data else { return }
      var posts: [Post] = []
      
      do {
        let json = try JSONSerialization.jsonObject(with: postData, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        for dict in json as! [[String: AnyObject]] {
          
          guard let userID = dict["userId"] as? Int,
            let postID = dict["id"] as? Int,
            let title = dict["title"] as? String,
            let body = dict["body"] as? String else {
              return
          }
          
          let post = Post(userID: userID, postID: postID, title: title, body: body)
          posts.append(post)
        }
        
        completion(posts)
        
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    }
  }
}
