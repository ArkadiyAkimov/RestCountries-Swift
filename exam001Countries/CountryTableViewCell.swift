//
//  CountryTableViewCell.swift
//  exam001Countries
//
//  Created by Arkadiy Akimov on 16/08/2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    var nativeName: String = "testNativeName"
    var englishName: String = "testEnglishName"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let nativeNameLabel = UILabel()
        nativeNameLabel.text = nativeName
        nativeNameLabel.numberOfLines = -1
        nativeNameLabel.adjustsFontSizeToFitWidth = true
        
        let englishNameLabel = UILabel()
        englishNameLabel.text = englishName
        englishNameLabel.numberOfLines = -1
        englishNameLabel.adjustsFontSizeToFitWidth = true
        
        let HStack = UIStackView(arrangedSubviews: [englishNameLabel,nativeNameLabel])
        HStack.spacing = 20
        HStack.axis = .horizontal
        HStack.frame = CGRect(x: 20, y: 0, width: contentView.bounds.width - 40, height: contentView.bounds.height)
        contentView.addSubview(HStack)
    }
}
