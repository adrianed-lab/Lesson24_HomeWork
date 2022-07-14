//
//  HourlyCollectionViewCell.swift
//  HomeWork24_RomanGushchik
//
//  Created by admin on 30.06.22.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let key = "HourlyCollectionViewCell"
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var hoursLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with model: Hourly, textForHour: String) {
        self.tempLabel.text = "\(Int(model.temperature))°"
        self.hoursLabel.text = textForHour
        guard let iconImage = model.weather.first?.icon else {return}
        self.iconImageView.getWeatherImage(id: iconImage)
    }
}
