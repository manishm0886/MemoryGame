//
//  MemoryCardbutton.swift
//  MemoryGame
//
//  Created by Manish Kumar on 2/20/17.
//  Copyright © 2017 Manish Kumar. All rights reserved.
//

import UIKit
enum MemoryCardStatus {
    case on
    case off
    case matched
}

class MemoryCardButton: UIButton {
    var isCardOn = true
    var memoryIcon = ""
    func setMemoryCardButton(status: MemoryCardStatus){
        switch status{
        case .on:
            self.setImage(UIImage.init(named: memoryIcon), for: .normal)
        case .off:
            self.setImage(UIImage.init(named: ""), for: .normal)
        case .matched:
            self.isCardOn = false
            self.setImage(UIImage.init(named: ""), for: .normal)
            self.backgroundColor = UIColor.lightGray
            
        }
    }
}
