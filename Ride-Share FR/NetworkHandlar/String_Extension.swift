//
//  String_Extension.swift
//  Freeluancer
//
//  Created by Imran malik on 17/03/20.
//  Copyright © 2020 virtualEmployee. All rights reserved.
//

import Foundation

extension String{
    
    func trimmedText() -> String
    {
        return (self.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func containsOnlyDigits() -> Bool{
        
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(self).isSubset(of: nums)
            //self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil && self.rangeOfCharacter(from: CharacterSet.letters) == nil
    }
    
}

