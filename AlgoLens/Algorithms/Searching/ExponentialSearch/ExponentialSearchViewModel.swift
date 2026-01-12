//
//  ExponentialSearchViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

final class ExponentialSearchViewModel: ObservableObject {
    
    // MARK: - Algorithm Information
    
    static let algorithmName = "Exponential Search"
    static let shortDescription = "Expand range then binary search"
    static let detailedDescription = "Exponential search finds the range where the element might be present by exponentially increasing the search range, then performs binary search within that range."
    static let timeComplexity = "O(log n)"
    static let spaceComplexity = "O(1)"
    
    static let keyPoints = [
        "Finds range exponentially (2^i)",
        "Then applies binary search",
        "Good for unbounded searches",
        "Efficient for elements near beginning"
    ]
    
    static let useCases = [
        "Unbounded or infinite arrays",
        "When target is close to beginning",
        "Searching in unknown size arrays"
    ]
    
    // Placeholder for future implementation
}
