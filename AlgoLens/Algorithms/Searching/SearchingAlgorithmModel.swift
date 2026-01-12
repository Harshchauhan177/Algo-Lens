//
//  SearchingAlgorithmModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

// MARK: - Searching Algorithm Type

enum SearchingAlgorithmType: String, CaseIterable {
    case linear = "Linear Search"
    case binary = "Binary Search"
    case jump = "Jump Search"
    case interpolation = "Interpolation Search"
    case exponential = "Exponential Search"
    case fibonacci = "Fibonacci Search"
}

// MARK: - Searching Algorithm Model

struct SearchingAlgorithmModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let iconName: String
    let timeComplexity: String
    let spaceComplexity: String
    let gradientColors: [Color]
    let algorithmType: SearchingAlgorithmType
    let detailedDescription: String
    let keyPoints: [String]
    let useCases: [String]
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        iconName: String,
        timeComplexity: String,
        spaceComplexity: String,
        gradientColors: [Color],
        algorithmType: SearchingAlgorithmType,
        detailedDescription: String,
        keyPoints: [String],
        useCases: [String]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.iconName = iconName
        self.timeComplexity = timeComplexity
        self.spaceComplexity = spaceComplexity
        self.gradientColors = gradientColors
        self.algorithmType = algorithmType
        self.detailedDescription = detailedDescription
        self.keyPoints = keyPoints
        self.useCases = useCases
    }
}

// MARK: - Sample Data

extension SearchingAlgorithmModel {
    static let allSearchingAlgorithms: [SearchingAlgorithmModel] = [
        SearchingAlgorithmModel(
            name: LinearSearchViewModel.algorithmName,
            description: LinearSearchViewModel.shortDescription,
            iconName: "arrow.right.circle.fill",
            timeComplexity: LinearSearchViewModel.timeComplexity,
            spaceComplexity: LinearSearchViewModel.spaceComplexity,
            gradientColors: [Color(red: 0.4, green: 0.7, blue: 1.0), Color(red: 0.3, green: 0.5, blue: 0.9)],
            algorithmType: .linear,
            detailedDescription: LinearSearchViewModel.detailedDescription,
            keyPoints: LinearSearchViewModel.keyPoints,
            useCases: LinearSearchViewModel.useCases
        ),
        SearchingAlgorithmModel(
            name: BinarySearchViewModel.algorithmName,
            description: BinarySearchViewModel.shortDescription,
            iconName: "arrow.left.arrow.right.circle.fill",
            timeComplexity: BinarySearchViewModel.timeComplexity,
            spaceComplexity: BinarySearchViewModel.spaceComplexity,
            gradientColors: [Color(red: 1.0, green: 0.6, blue: 0.7), Color(red: 0.9, green: 0.4, blue: 0.5)],
            algorithmType: .binary,
            detailedDescription: BinarySearchViewModel.detailedDescription,
            keyPoints: BinarySearchViewModel.keyPoints,
            useCases: BinarySearchViewModel.useCases
        ),
        SearchingAlgorithmModel(
            name: JumpSearchViewModel.algorithmName,
            description: JumpSearchViewModel.shortDescription,
            iconName: "arrow.up.right.circle.fill",
            timeComplexity: JumpSearchViewModel.timeComplexity,
            spaceComplexity: JumpSearchViewModel.spaceComplexity,
            gradientColors: [Color(red: 0.5, green: 0.9, blue: 0.7), Color(red: 0.3, green: 0.7, blue: 0.5)],
            algorithmType: .jump,
            detailedDescription: JumpSearchViewModel.detailedDescription,
            keyPoints: JumpSearchViewModel.keyPoints,
            useCases: JumpSearchViewModel.useCases
        ),
        SearchingAlgorithmModel(
            name: InterpolationSearchViewModel.algorithmName,
            description: InterpolationSearchViewModel.shortDescription,
            iconName: "chart.line.uptrend.xyaxis.circle.fill",
            timeComplexity: InterpolationSearchViewModel.timeComplexity,
            spaceComplexity: InterpolationSearchViewModel.spaceComplexity,
            gradientColors: [Color(red: 1.0, green: 0.8, blue: 0.4), Color(red: 0.9, green: 0.6, blue: 0.3)],
            algorithmType: .interpolation,
            detailedDescription: InterpolationSearchViewModel.detailedDescription,
            keyPoints: InterpolationSearchViewModel.keyPoints,
            useCases: InterpolationSearchViewModel.useCases
        ),
        SearchingAlgorithmModel(
            name: ExponentialSearchViewModel.algorithmName,
            description: ExponentialSearchViewModel.shortDescription,
            iconName: "arrow.up.forward.circle.fill",
            timeComplexity: ExponentialSearchViewModel.timeComplexity,
            spaceComplexity: ExponentialSearchViewModel.spaceComplexity,
            gradientColors: [Color(red: 0.8, green: 0.5, blue: 1.0), Color(red: 0.6, green: 0.3, blue: 0.8)],
            algorithmType: .exponential,
            detailedDescription: ExponentialSearchViewModel.detailedDescription,
            keyPoints: ExponentialSearchViewModel.keyPoints,
            useCases: ExponentialSearchViewModel.useCases
        ),
        SearchingAlgorithmModel(
            name: FibonacciSearchViewModel.algorithmName,
            description: FibonacciSearchViewModel.shortDescription,
            iconName: "function",
            timeComplexity: FibonacciSearchViewModel.timeComplexity,
            spaceComplexity: FibonacciSearchViewModel.spaceComplexity,
            gradientColors: [Color(red: 0.4, green: 0.8, blue: 0.9), Color(red: 0.3, green: 0.6, blue: 0.7)],
            algorithmType: .fibonacci,
            detailedDescription: FibonacciSearchViewModel.detailedDescription,
            keyPoints: FibonacciSearchViewModel.keyPoints,
            useCases: FibonacciSearchViewModel.useCases
        )
    ]
}
