//
//  Int+Extension.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 29.04.2021.
//
import Foundation

extension Int {
    
    // MARK: - Instance properties
    
    /// Property to get random integer
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
    
    // MARK: - Instance methods
    
    /// Circular increment
    /// - Parameter number: Number in which increment
    /// - Returns: Return to the first position once the end of the array is reached, or self
    func incrementCircle(in number: Int) -> Int {
        return (number - 1) > self ? self + 1 : 0
    }
}
