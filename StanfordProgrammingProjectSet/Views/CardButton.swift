//
//  SetCardButton.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 29.04.2021.
//

import UIKit

/// Class responsible for a view of cards
@IBDesignable class CardButton: ButtonBorder {
    
    // MARK: - Instance properties
    
    var colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    var alphas: [CGFloat] = [1.0, 0.40, 0.15]
    var strokeWidths: [CGFloat] = [-8, 8, -8]
    var symbols = ["▲", "●", "■"]
    
    var setCard: Card? = Card(amountOfSymblos: Card.Variant.v3,
                              colorOfSymbols: Card.Variant.v3,
                              shapeOfSymbol: Card.Variant.v3,
                              fillOfSymbol: Card.Variant.v3)
    { didSet {updateButton()} }
    
    /// Vertical size class for correct location of the views
    var verticalSizeClass: UIUserInterfaceSizeClass {
        return UIScreen.main.traitCollection.verticalSizeClass
    }
    
    /// Constants
    private struct Constants {
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 5.0
        static let borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    // MARK: - Instance Methods
    
    /// Create attributed string to use it on card
    /// - Parameter card: Card to use on
    /// - Returns: Attributed string with correct symbols location, and attributes for card view (stroke color, stroke width, foreground color)
    private func setAttributedString(card: Card) -> NSAttributedString {
        let symbol = symbols[card.shapeOfSymbol.shape]
        let separator = verticalSizeClass == .regular ? "\n" : " "
        let symbolsString = symbol.join(n: card.amountOfSymblos.rawValue, with: separator)
        let attributes:[NSAttributedString.Key : Any] = [
            .strokeColor: colors[card.colorOfSymbols.shape],
            .strokeWidth: strokeWidths[card.fillOfSymbol.shape],
            .foregroundColor: colors[card.colorOfSymbols.shape].withAlphaComponent(alphas[card.fillOfSymbol.shape])
        ]
        return NSAttributedString(string: symbolsString, attributes: attributes)
    }
    
    /// Updates view of a card button
    private func updateButton() {
        if let card = setCard {
            let attributedString = setAttributedString(card: card)
            setAttributedTitle(attributedString, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            isEnabled = true
        } else {
            setAttributedTitle(nil, for: .normal)
            setTitle(nil, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            isEnabled = false
        }
    }
    
    /// Configure attributes from constants
    private func configure() {
        cornerRadius = Constants.cornerRadius
        titleLabel?.numberOfLines = 0
        borderColor = Constants.borderColor
        borderWidth = -Constants.borderWidth
    }
    
    func setBorderColor(color: UIColor) {
        borderColor = color
        borderWidth = Constants.borderWidth
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Lay out subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButton()
    }
}
