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
    ///   - n: Amount of symbols
    ///   - separator: Separator
    /// - Returns: Joined string
    func join(n: Int, with separator: String ) -> String {
        guard n > 1 else { return self }
        var symbols = [String]()
        for _ in 0..<n {
            symbols += [self]
        }
        return symbols.joined(separator: separator)
    }
}
