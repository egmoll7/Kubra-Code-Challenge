//
//  PostCell.swift
//  Kubra Code Challenge
//
//  Created by Eduardo Moll on 1/20/18.
//  Copyright © 2018 Eduardo Moll. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension PostCell {
  
  public func populateWith(post: Post) {
    
    titleLabel.text = post.title
    bodyLabel.text = post.body
  }
}

extension PostCell: KubraCell {
  static var identifierForCell: String = "postCell"
  static func nibForCell() -> UINib {
    return UINib(nibName: "PostCell", bundle: Bundle.main)
  }
}
