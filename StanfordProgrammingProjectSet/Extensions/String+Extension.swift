//
//  String+Extension.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 29.04.2021.
//

extension String {
    
    // MARK: - Instance methods
    
    /// Concatenates string
    /// - Parameters:
    ///   - amount: Amount of symbols
    ///   - separator: Separator
    /// - Returns: Joined string
    func join(amount: Int, with separator: String ) -> String {
        guard amount > 1 else { return self }
        var symbols = [String]()
        
        for _ in 0..<amount {
            symbols += [self]
        }
        
        return symbols.joined(separator: separator)
    }
}
