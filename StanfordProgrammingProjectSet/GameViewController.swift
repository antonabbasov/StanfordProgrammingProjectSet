//
//  ViewController.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 23.04.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var hintButton: ButtonBorder!
    @IBOutlet private weak var dealPlusThreeCardsButton: ButtonBorder!
    @IBOutlet private weak var newGameButton: ButtonBorder!
    
    @IBOutlet private weak var deckCountLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [CardButton]! {
        didSet {
            for button in cardButtons {
                button.strokeWidths = strokeWidths
                button.colors = colors
                button.alphas = alphas
            }
        }
    }
    
    // MARK: - Non private variables
    
    var verticalSizeClass: UIUserInterfaceSizeClass = .regular
    var colors = [#colorLiteral(red: 1, green: 0.4163245823, blue: 0, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)]
    var strokeWidths:[CGFloat] = [-10, 10, -10]
    var alphas:[CGFloat] = [1.0, 0.60, 0.15]
    
    // MARK: - Private variables
    
    private var game = SetGame()
    private weak var timer: Timer?
    private var lastHint = 0
    
    // MARK: - Instance actions
    
    /// Action responsible for logic when any card is touched
    /// - Parameter sender: Pressed card
    @IBAction private func pressCard(_ sender: CardButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    /// Action responsible for logic when hint button touched
    /// - Parameter sender: Hint button
    @IBAction func hintButton(_ sender: ButtonBorder) {
        timer?.invalidate()
        if  game.hints.count > 0 {
            
            game.hints[lastHint].forEach {
                (hintedButtonIndex) in let button = self.cardButtons[hintedButtonIndex]
                button.setBorderColor(color: Colors.hint)
            }
            
            messageLabel.text = "Set \(lastHint + 1) Wait..."
            timer = Timer.scheduledTimer(withTimeInterval: Constants.flashTime, repeats: false) {
                [weak self] time in self?.game.hints[(self?.lastHint) ?? 0].forEach {
                    (hintedButtonIndex) in let button = self?.cardButtons[hintedButtonIndex]
                    button!.setBorderColor(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
                }
            
            self?.lastHint = (self?.lastHint)!.incrementCircle(in: (self?.game.hints.count)!)
            self?.messageLabel.text = ""
            self?.updateButtonsFromModel()
            }
        }
    }
    
    /// Action responsible for logic when new game button pressed
    /// - Parameter sender: New game button
    @IBAction private func newGameButton(_ sender: UIButton) {
        game = SetGame()
        cardButtons.forEach { $0.setCard = nil }
        updateViewFromModel()
    }
    
    /// Action responsible for logic when deal+3 button pressed
    /// - Parameter sender: Deal+3 button
    @IBAction private func dealThreeMoreCards(_ sender: UIButton) {
        if (game.cardsOnTable.count + 3) <= cardButtons.count {
            game.dealThreeAdditionalCards()
            updateViewFromModel()
        }
    }
    
    // MARK: - Instance methods
    
    /// Method responsible for updating label of amount of sets in Hint button
    private func updateHintButton() {
        hintButton.setTitle("\(game.hints.count) sets", for: .normal)
        lastHint = 0
    }
    
    /// Method responsible for updating labels in whole view
    private func updateViewFromModel() {
        updateButtonsFromModel()
        updateHintButton()
        deckCountLabel.text = "Deck: \(game.deckCount)"
        scoreLabel.text = "Score: \(game.score) / \(game.numberSets)"
        
        dealPlusThreeCardsButton.isEnabled = !((game.cardsOnTable.count) >= cardButtons.count || game.deckCount == 0)
        hintButton.isEnabled = game.hints.count != 0
    }
    
    /// Method responsible for updating cards on view
    private func updateButtonsFromModel() {
        messageLabel.text = ""
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cardsOnTable.count {
                let card = game.cardsOnTable[index]
                button.setCard = card
                button.setBorderColor(color: game.selectedCards.contains(card) ? Colors.selected : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
                if let itIsSet = game.isSet {
                    if game.tryMatchedCards.contains(card) {
                        button.setBorderColor(color: itIsSet ? Colors.matched: Colors.misMatched)
                    }
                    messageLabel.text = itIsSet ? "Set" :"Not set"
                }
            } else {
                button.setCard = nil
            }
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        updateViewFromModel()
    }
}

// MARK: - GameViewControllersExtension

extension GameViewController {
    
    // MARK: - Instance Constants
    
    private enum Colors {
        static let hint: UIColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        static let selected: UIColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        static let matched: UIColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        static let misMatched: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private struct Constants {
        static let flashTime = 1.5
    }
}
