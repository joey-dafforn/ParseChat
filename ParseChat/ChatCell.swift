//
//  ChatCell.swift
//  ParseChat
//
//  Created by Joey Dafforn on 1/31/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageContentsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
