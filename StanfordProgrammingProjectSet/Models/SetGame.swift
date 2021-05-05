//
//  SetGame.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 29.04.2021.
//

/// Logic of the game "Set"
struct SetGame {
    
    // MARK: - Instance properties
    
    private(set) var cardsOnTable = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var tryMatchedCards = [Card]()
    private(set) var removedCards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private(set) var numberSets = 0
    private var deck = SetCardDeck()
    
    private struct Constants {
        static let startNumberCards = 12
    }
    
    private struct Points {
        static let matchBonus = 20
        static let missMatchPenalty = 10
        static var maxTimePenalty = 10
        static var flipOverPenalty = 1
    }
    
    /// Calculate user points and if he is found "set"
    var isSet: Bool? {
        get {
            guard tryMatchedCards.count == 3 else { return nil }
            return Card.isSet(cards: tryMatchedCards)
        }
        
        set {
            if newValue != nil {
                if newValue! {
                    score += Points.matchBonus
                    numberSets += 1
                } else {
                    score -= Points.missMatchPenalty
                }
                
                tryMatchedCards = selectedCards
                selectedCards.removeAll()
            } else {
                tryMatchedCards.removeAll()
            }
        }
    }
    
    /// Calculate hint of "set" cards for user
    var hints: [[Int]] {
        var hints = [[Int]]()
        if cardsOnTable.count > 2 {
            
            for i in 0..<cardsOnTable.count {
                for j in (i+1)..<cardsOnTable.count {
                    for k in (j+1)..<cardsOnTable.count {
                        let cards = [cardsOnTable[i], cardsOnTable[j], cardsOnTable[k]]
                        if Card.isSet(cards: cards) {
                            hints.append([i,j,k])
                        }
                    }
                }
            }
        }
        
        if let itIsSet = isSet, itIsSet {
            let matchIndices = cardsOnTable.indices(of: tryMatchedCards)
            return hints.map{ Set($0) }
                .filter{$0.intersection(Set(matchIndices)).isEmpty}
                .map{Array($0)}
        }
        
        return hints
    }
    
    var deckCount: Int { return deck.cards.count }
    
    // MARK: - Instance Methods
    
    /// Get additional three cards
    /// - Returns: Recieved cards
    private mutating func additionalThreeCards() -> [Card]? {
        var threeCards = [Card]()
        
        for _ in 0...2 {
            if let card = deck.draw() {
                threeCards += [card]
            } else {
                return nil
            }
        }
        
        return threeCards
    }
    
    /// Replace cards, if user pressed deal+3 button with maximum amount of cards on table. Or delete "seted" cards
    private mutating func replaceOrRemoveThreeCards() {
        if cardsOnTable.count == Constants.startNumberCards, let threeCards = additionalThreeCards() {
            cardsOnTable.replaceElements(elements: tryMatchedCards, with: threeCards)
        } else {
            cardsOnTable.removeAll(where: { tryMatchedCards.contains($0) })
        }
        
        removedCards += tryMatchedCards
        tryMatchedCards.removeAll()
    }
    
    /// Deal additional three cards
    mutating func dealThreeAdditionalCards() {
        if let additionalCards = additionalThreeCards() {
            cardsOnTable += additionalCards
        }
    }
    
    /// Logic when user pressed card
    /// - Parameter index: Index of that card
    mutating func chooseCard(at index: Int) {
        assert(cardsOnTable.indices.contains(index), "SetGame.chooseCard at index: (\(index)) index out of range.")
        
        let choosenCard = cardsOnTable[index]
        
        if !removedCards.contains(choosenCard) && !tryMatchedCards.contains(choosenCard) {
            if isSet != nil {
                if isSet! { replaceOrRemoveThreeCards() }
                isSet = nil
            }
        }
        
        if selectedCards.count == 2, !selectedCards.contains(choosenCard) {
            selectedCards += [choosenCard]
            isSet = Card.isSet(cards: selectedCards)
        } else {
            selectedCards.inOut(element: choosenCard)
        }
        
        flipCount += 1
        score -= Points.flipOverPenalty
    }
    
    // MARK: - Initialization
    
    init() {
        for _ in 1...Constants.startNumberCards {
            if let card = deck.draw() {
                cardsOnTable += [card]
            }
        }
    }
}


