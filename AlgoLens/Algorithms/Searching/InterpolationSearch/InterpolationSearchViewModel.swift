//
//  InterpolationSearchViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

final class InterpolationSearchViewModel: ObservableObject {
    
    // MARK: - Algorithm Information
    
    static let algorithmName = "Interpolation Search"
    static let shortDescription = "Estimate position using value"
    static let detailedDescription = "Interpolation search is an improved variant of binary search that works on uniformly distributed sorted arrays by calculating the probable position of the target value."
    static let timeComplexity = "O(log log n)"
    static let spaceComplexity = "O(1)"
    
    static let keyPoints = [
        "Uses value-based position estimation",
        "Best for uniformly distributed data",
        "Faster than binary search on right data",
        "Can degrade to O(n) worst case"
    ]
    
    static let useCases = [
        "Uniformly distributed sorted data",
        "Phone book searches",
        "Dictionary with uniform distribution"
    ]
    
    // Placeholder for future implementation
}
