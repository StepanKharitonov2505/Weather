//
//  WeatherHourCell.swift
//  TzOpenWeather
//
//  Created by Степан Харитонов on 13.01.2022.
//

import UIKit

class WeatherHourCell: UICollectionViewCell {

    @IBOutlet weak var bViewHour: UIView!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var tempTitle: UILabel!
    @IBOutlet weak var weatherTitleHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
