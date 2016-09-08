//
//  JackpotGame.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 08/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import Foundation

class JackpotGame {
    
    var name : String
    var jackpot : Int
    var date : String
    
    init (name: String, jackpot: Int, date: String) {
        self.name = name
        self.jackpot = jackpot
        self.date = date
    }
}