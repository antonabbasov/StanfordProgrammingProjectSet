//
//  CardButton.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 23.04.2021.
//

import UIKit

/// Class responsible for view of a border on cards
@IBDesignable class ButtonBorder: UIButton {

    // MARK: - Instance properties
    
    @IBInspectable var borderColor: UIColor = DefaultValues.borderColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = DefaultValues.borderWidth {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = DefaultValues.cornerRadius {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    private struct DefaultValues {
        static let borderColor: UIColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        static let borderWidth: CGFloat = 4.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // MARK: - Instance methods
    
    private func configure() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
