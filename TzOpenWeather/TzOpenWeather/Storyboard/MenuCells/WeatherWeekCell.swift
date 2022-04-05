//
//  WeatherWeekCell.swift
//  TzOpenWeather
//
//  Created by Степан Харитонов on 13.01.2022.
//

import UIKit

class WeatherWeekCell: UITableViewCell {

    @IBOutlet weak var numberDay: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var bVWeek: UIView!
    @IBOutlet weak var monthName: UILabel!
    @IBOutlet weak var weekTempDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
