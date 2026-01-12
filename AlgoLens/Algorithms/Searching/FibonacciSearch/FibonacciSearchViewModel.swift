//
//  FibonacciSearchViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

final class FibonacciSearchViewModel: ObservableObject {
    
    // MARK: - Algorithm Information
    
    static let algorithmName = "Fibonacci Search"
    static let shortDescription = "Search using Fibonacci intervals"
    static let detailedDescription = "Fibonacci search uses Fibonacci numbers to divide the array into unequal parts. It's similar to binary search but uses addition and subtraction instead of division."
    static let timeComplexity = "O(log n)"
    static let spaceComplexity = "O(1)"
    
    static let keyPoints = [
        "Uses Fibonacci numbers for division",
        "No division operation needed",
        "Good for systems where division is costly",
        "Similar efficiency to binary search"
    ]
    
    static let useCases = [
        "Systems with costly division operations",
        "Embedded systems",
        "Memory-constrained environments"
    ]
    
    // Placeholder for future implementation
}
