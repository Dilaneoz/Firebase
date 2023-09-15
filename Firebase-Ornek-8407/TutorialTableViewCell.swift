//
//  TutorialTableViewCell.swift
//  Firebase-Ornek-8407
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 18.03.2023.
//

import UIKit

class TutorialTableViewCell: UITableViewCell {

    
    @IBOutlet weak var txtTitle: UILabel!
    
    
    @IBOutlet weak var txtDescription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
