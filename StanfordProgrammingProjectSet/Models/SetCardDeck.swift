//
//  Set.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 29.04.2021.
//

/// Model for deck of cards to play "Set" game
struct SetCardDeck {
    
    // MARK: - Instance properties
    
    private(set) var cards = [Card]()
    
    // MARK: - Initialization
    
    init() {
        for amountOfSymbols in Card.Variant.all {
            for colorOfSymbols in Card.Variant.all {
                for shapeOfSymbol in Card.Variant.all {
                    for fillOfSymbol in Card.Variant.all {
                        cards.append(Card(amountOfSymblos: amountOfSymbols, colorOfSymbols: colorOfSymbols, shapeOfSymbol: shapeOfSymbol, fillOfSymbol: fillOfSymbol))
                    }
                }
            }
        }
    }
    
    // MARK: - Instance methods
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}
