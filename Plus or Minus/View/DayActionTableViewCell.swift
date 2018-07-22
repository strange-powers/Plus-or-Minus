//
//  DayActionTableViewCell.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 22.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class DayActionTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    func prepareCellWithData(from action: DayAction) {
        label.text = action.desc
    }

}
