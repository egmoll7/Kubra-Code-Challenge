//
//  UserCell.swift
//  Kubra Code Challenge
//
//  Created by Eduardo Moll on 1/20/18.
//  Copyright © 2018 Eduardo Moll. All rights reserved.
//

import UIKit

protocol KubraCell {
  
  static var identifierForCell: String  { get }
  static func nibForCell() -> UINib
}

class UserCell: UITableViewCell {
  
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UserCell {
  
  public func populateWith(user: User) {
    
    usernameLabel.text = user.username
    addressLabel.text = user.address
  }
}

extension UserCell: KubraCell {
  static var identifierForCell: String = "cell"
  static func nibForCell() -> UINib {
    return UINib(nibName: "UserCell", bundle: Bundle.main)
  }
}
