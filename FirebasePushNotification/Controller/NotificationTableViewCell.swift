//
//  NotificationTableViewCell.swift
//  FirebasePushNotification
//
//  Created by Apple on 30.06.2020.
//  Copyright © 2020 erdogan. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblServis: UILabel!
    @IBOutlet weak var lblTelefon: UILabel!
    @IBOutlet weak var lblFark: UILabel!
    @IBOutlet weak var lblSayac: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
