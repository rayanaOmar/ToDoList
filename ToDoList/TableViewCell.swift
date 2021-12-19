//
//  TableViewCell.swift
//  ToDoList
//
//  Created by admin on 19/12/2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskTitleCell: UILabel!
    @IBOutlet weak var taskDescrptionCell: UILabel!
    @IBOutlet weak var taskDateCell: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
