//
//  Array+Extensions.swift
//  MemoryGame
//
//  Created by Manish Kumar on 2/20/17.
//  Copyright © 2017 Manish Kumar. All rights reserved.
//

import UIKit

extension Array{
    mutating func shuffle(){
        for _ in 0..<10{
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
