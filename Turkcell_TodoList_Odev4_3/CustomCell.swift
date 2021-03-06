//
//  CustomCell.swift
//  Turkcell_TodoList_Odev4_3
//
//  Created by Gulsah Altiparmak on 25.01.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var doneImg: UIImageView!
    @IBOutlet weak var doneAmount: UILabel!
    @IBOutlet weak var doneDate: UILabel!
    @IBOutlet weak var doneTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
