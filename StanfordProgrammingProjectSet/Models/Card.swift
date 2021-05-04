//
//  Card.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 29.04.2021.
//

/// Model for card in the game "Set"
struct Card {
    
    // MARK: - Instance properties
    
    let amountOfSymblos: Variant
    let colorOfSymbols: Variant
    let shapeOfSymbol: Variant
    let fillOfSymbol: Variant
    
    enum Variant: Int, CustomStringConvertible {
        
        // MARK: - Instance properties
        
        case v1 = 1
        case v2 = 2
        case v3 = 3
        
        typealias RawValue = Int
        
        static var all: [Variant] {return [.v1,.v2,.v3]}
        var description: String {return String(self.rawValue)}
        var shape: Int {return (self.rawValue - 1)}
    }
    
    // MARK: - Instance methods
    
    /// Method responsible for detection "set" from three given cards
    /// - Parameter cards: Three selected cards
    /// - Returns: True if "set", and false if not
    static func isSet(cards: [Card]) -> Bool {
        guard cards.count == 3 else {return false}
        
        let sum = [
            cards.reduce(0, {$0 + $1.amountOfSymblos.rawValue}),
            cards.reduce(0, {$0 + $1.colorOfSymbols.rawValue}),
            cards.reduce(0, {$0 + $1.shapeOfSymbol.rawValue}),
            cards.reduce(0, {$0 + $1.fillOfSymbol.rawValue})
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0)})
    }
}

// MARK: - CustomStringConvertible

extension Card: CustomStringConvertible {
    
    // MARK: - Instance properties
    
    var description: String {
        return "Amount of Symbols: \(amountOfSymblos), Color of symbols: \(colorOfSymbols), Shape of symbols: \(shapeOfSymbol), Fill of symbols: \(fillOfSymbol)"
    }
}

// MARK: - Equatable

extension Card: Equatable {
    
    // MARK: - Instance Methods
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return ((lhs.amountOfSymblos == rhs.amountOfSymblos)) &&
            (lhs.colorOfSymbols == rhs.colorOfSymbols) &&
            (lhs.shapeOfSymbol == rhs.shapeOfSymbol) &&
            (lhs.fillOfSymbol == rhs.fillOfSymbol);
    }
}
