//
//  Array+Extension.swift
//  StanfordProgrammingProjectSet
//
//  Created by Anton on 29.04.2021.
//

extension Array where Element: Equatable {
    
    // MARK: - Instance methods
    
    /// If element not in array - append, if an element in array - remove
    /// - Parameter element: Element for inout
    mutating func inOut(element: Element) {
        if let from = self.firstIndex(of: element) {
            self.remove(at: from)
        } else {
            self.append(element)
        }
    }
    
    /// Delete array of elements from array
    /// - Parameter elements: Array of elements for deleting
    mutating func removeElements(elements: [Element]) {
        self = self.filter { !elements.contains($0) }
    }
    
    /// Replace elements in array witn new ones
    /// - Parameters:
    ///   - elements: Replaced elements
    ///   - new: New elements
    mutating func replaceElements(elements: [Element], with new: [Element]) {
        guard elements.count == new.count else { return }
        for id in 0..<new.count {
            if let indexMatched = self.firstIndex(of: elements[id]) {
                self [indexMatched] = new[id]
            }
        }
    }
    
    /// Return indices of an array
    /// - Parameter elements: Array
    /// - Returns: Indices
    func indices(of elements: [Element]) -> [Int] {
        guard self.count >= elements.count, elements.count > 0 else { return [] }
        return elements.map{self.firstIndex(of: $0)}.compactMap{$0}
    }
}
