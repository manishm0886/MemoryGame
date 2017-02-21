//
//  MemoryCell.swift
//  MemoryGame
//
//  Created by Manish Kumar on 2/20/17.
//  Copyright © 2017 Manish Kumar. All rights reserved.
//

import UIKit

enum MemoryCellStatus{
    case enabled
    case disabled
}
protocol MemoryCellDelegate {
     func onCardTapped(indexPath : IndexPath)
}

class MemoryCell: UICollectionViewCell {
    @IBOutlet weak var memoryCard: MemoryCardButton!
    var delegate : MemoryCellDelegate?
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.memoryCard.layer.borderColor = UIColor.black.cgColor
        self.memoryCard.layer.borderWidth = 1
        self.memoryCard.isExclusiveTouch = true
        self.isExclusiveTouch = true
    }
    func setUpCard(status: MemoryCellStatus){
        switch status {
        case .enabled:
            self.setMemoryCardIcon()
            self.isUserInteractionEnabled = true
        case .disabled:
            self.memoryCard.setMemoryCardButton(status: .matched)
            self.isUserInteractionEnabled = false
        }
    }
    func setMemoryCardIcon(){
      memoryCard.isCardOn = !memoryCard.isCardOn
      memoryCard.isCardOn ?self.memoryCard.setMemoryCardButton(status: .on) : self.memoryCard.setMemoryCardButton(status: .off)
    }
   @IBAction  func cellTapped(_ sender: Any) {
     self.setMemoryCardIcon()
     self.delegate?.onCardTapped(indexPath: self.indexPath!)
    }
}
