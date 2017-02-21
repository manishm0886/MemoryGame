//
//  MemoryCollectionViewHandler.swift
//  MemoryGame
//
//  Created by Manish Kumar on 2/20/17.
//  Copyright © 2017 Manish Kumar. All rights reserved.
// GRID  Size is of 4*4

import UIKit


extension MemoryGameVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemoryConstants.MEMORY_NUMBER_OF_ITEMS_IN_SECTION
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MemoryConstants.MEMORY_NUMBER_OF_SECTION
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoryConstants.MEMORY_CELL_IDENTIFIER,
                                                      for: indexPath) as! MemoryCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.memoryCard.memoryIcon = String(describing:memoryArrays[indexPath.row])
        cell.setMemoryCardIcon()
        return cell
    }
}
extension MemoryGameVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
       return CGSize.init(width: (collectionView.frame.size.width-30)/4,
                          height: (collectionView.frame.size.width-30)/4)
     
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize.init(width: collectionView.frame.size.width,
                          height:CGFloat(MemoryConstants.MEMORY_LINE_SPACING))
    }
}

extension MemoryGameVC : MemoryCellDelegate{
    func onCardTapped(indexPath : IndexPath) {
        if previousSelectedIndexPath == indexPath{
           //User has selected same card
        }
        else{
        //User picked diffirent card
           let previousCell = memoryCollectionView.cellForItem(at: previousSelectedIndexPath) as? MemoryCell ?? MemoryCell()
             let currentCell = memoryCollectionView.cellForItem(at: indexPath) as? MemoryCell ?? MemoryCell()
           
            if previousCell.memoryCard.isCardOn && currentCell.memoryCard.isCardOn{
             //Both cards are visible to user -> Make both cards in off state
                if String(describing:memoryArrays[indexPath.row]) == String(describing:memoryArrays[previousSelectedIndexPath.row]) {
                    //Matched
                    currentScore = currentScore + 2
                    let delayInSeconds = 1.0 // 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                        previousCell.setUpCard(status: .disabled)
                        currentCell.setUpCard(status: .disabled)
                        self.scoreLabel.text =  "Your Current Score is \(self.currentScore)"
                        //Reset Index Path
                        self.previousSelectedIndexPath = IndexPath.init(row: 0, section: 0)
                    }
                  
                }else{
                    //Failed
                    currentScore = currentScore - 1
                    let delayInSeconds = 1.0 // 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                        self.scoreLabel.text =  "Your Current Score is \(self.currentScore)"
                        previousCell.setUpCard(status: .enabled)
                        currentCell.setUpCard(status: .enabled)
                    }
                    
                }
            }else{
              //No Need to do anything -> Only one card is visible
                previousSelectedIndexPath = indexPath
            }
            
            
        }
        
    }
}
