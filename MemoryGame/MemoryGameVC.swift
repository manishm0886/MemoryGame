//
//  MemoryGameVC.swift
//  MemoryGame
//
//  Created by Manish Kumar on 2/20/17.
//  Copyright © 2017 Manish Kumar. All rights reserved.
//

import UIKit
enum CardSelectionSatus {
    case same
    case diffirent
}


class MemoryGameVC: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var memoryCollectionView: UICollectionView!
    @IBOutlet weak var memoryViewLayout: UICollectionViewFlowLayout!
    var previousSelectedIndexPath = IndexPath.init(row: 0, section: 0)
    var currentScore = 0
    var memoryArrays  = Array<Int>()
    
    //MARK: Collection View  Cell Setup
    func setDataSource(){
     //Create an array of 16 items in it
     //It will start from picking item from images set and add another copy of it in array till we reach 
     // to 16 items,then suffle it to show it in grid
     //Apply random function between [1,8]
      var itemSet = Set<Int>()
        repeat {
            let item = arc4random_uniform(8)
            itemSet.insert(Int(item))
        } while itemSet.count < 8
     
     let item1  = Array(itemSet)
     let item2  = Array(itemSet)
     memoryArrays = item1 + item2
     memoryArrays.shuffle()
    }
    func setUpMemoryLayout(){
    self.memoryCollectionView.register(UINib.init(nibName: MemoryConstants.MEMORY_CELL_NIB,
                                                  bundle: nil),
                                       forCellWithReuseIdentifier: MemoryConstants.MEMORY_CELL_IDENTIFIER)
    }
    //MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memoryCollectionView.isExclusiveTouch = true
        self.setUpMemoryLayout()
        self.setDataSource()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animateAlongsideTransition(in: self.memoryCollectionView, animation: nil, completion: {(context) in
          self.memoryViewLayout.invalidateLayout()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
