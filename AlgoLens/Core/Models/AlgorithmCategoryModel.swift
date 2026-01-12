//
//  AlgorithmCategoryModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

// MARK: - Algorithm Category Type

enum AlgorithmCategoryType: String, CaseIterable {
    case searching = "Searching"
    case sorting = "Sorting"
    case array = "Array"
    case string = "String"
    case recursion = "Recursion"
    case linkedList = "LinkedList"
    case stackQueue = "StackQueue"
    case tree = "Tree"
    case graph = "Graph"
    case greedy = "Greedy"
    case dynamicProgramming = "DynamicProgramming"
    case bitManipulation = "BitManipulation"
}

// MARK: - Algorithm Category Model

struct AlgorithmCategoryModel: Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let iconName: String
    let gradientColors: [Color]
    let categoryType: AlgorithmCategoryType
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        iconName: String,
        gradientColors: [Color],
        categoryType: AlgorithmCategoryType
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.iconName = iconName
        self.gradientColors = gradientColors
        self.categoryType = categoryType
    }
}

// MARK: - Sample Categories Data

extension AlgorithmCategoryModel {
    static let allCategories: [AlgorithmCategoryModel] = [
        AlgorithmCategoryModel(
            title: "Searching ",
            description: "Binary Search, Linear Search, Jump Search",
            iconName: "magnifyingglass.circle.fill",
            gradientColors: [Color(red: 0.4, green: 0.7, blue: 1.0), Color(red: 0.3, green: 0.5, blue: 0.9)],
            categoryType: .searching
        ),
        AlgorithmCategoryModel(
            title: "Sorting Algorithms",
            description: "Quick Sort, Merge Sort, Bubble Sort",
            iconName: "arrow.up.arrow.down.circle.fill",
            gradientColors: [Color(red: 1.0, green: 0.6, blue: 0.7), Color(red: 0.9, green: 0.4, blue: 0.5)],
            categoryType: .sorting
        ),
        AlgorithmCategoryModel(
            title: "Array Algorithms",
            description: "Two Pointers, Sliding Window, Kadane's",
            iconName: "square.grid.3x3.fill",
            gradientColors: [Color(red: 0.5, green: 0.9, blue: 0.7), Color(red: 0.3, green: 0.7, blue: 0.5)],
            categoryType: .array
        ),
        AlgorithmCategoryModel(
            title: "String Algorithms",
            description: "KMP, Rabin-Karp, Pattern Matching",
            iconName: "textformat.abc",
            gradientColors: [Color(red: 1.0, green: 0.8, blue: 0.4), Color(red: 0.9, green: 0.6, blue: 0.3)],
            categoryType: .string
        ),
        AlgorithmCategoryModel(
            title: "Recursion & Backtracking",
            description: "N-Queens, Sudoku, Permutations",
            iconName: "arrow.triangle.2.circlepath.circle.fill",
            gradientColors: [Color(red: 0.8, green: 0.5, blue: 1.0), Color(red: 0.6, green: 0.3, blue: 0.8)],
            categoryType: .recursion
        ),
        AlgorithmCategoryModel(
            title: "Linked List Algorithms",
            description: "Reversal, Cycle Detection, Merge Lists",
            iconName: "link.circle.fill",
            gradientColors: [Color(red: 0.4, green: 0.8, blue: 0.9), Color(red: 0.3, green: 0.6, blue: 0.7)],
            categoryType: .linkedList
        ),
        AlgorithmCategoryModel(
            title: "Stack & Queue Algorithms",
            description: "Monotonic Stack, Circular Queue",
            iconName: "square.stack.3d.up.fill",
            gradientColors: [Color(red: 1.0, green: 0.7, blue: 0.5), Color(red: 0.9, green: 0.5, blue: 0.3)],
            categoryType: .stackQueue
        ),
        AlgorithmCategoryModel(
            title: "Tree Algorithms",
            description: "DFS, BFS, Binary Search Tree",
            iconName: "tree.fill",
            gradientColors: [Color(red: 0.6, green: 0.9, blue: 0.5), Color(red: 0.4, green: 0.7, blue: 0.3)],
            categoryType: .tree
        ),
        AlgorithmCategoryModel(
            title: "Graph Algorithms",
            description: "Dijkstra, BFS, DFS, Topological Sort",
            iconName: "point.3.connected.trianglepath.dotted",
            gradientColors: [Color(red: 0.5, green: 0.6, blue: 1.0), Color(red: 0.3, green: 0.4, blue: 0.8)],
            categoryType: .graph
        ),
        AlgorithmCategoryModel(
            title: "Greedy Algorithms",
            description: "Activity Selection, Huffman Coding",
            iconName: "dollarsign.circle.fill",
            gradientColors: [Color(red: 0.9, green: 0.9, blue: 0.4), Color(red: 0.7, green: 0.7, blue: 0.2)],
            categoryType: .greedy
        ),
        AlgorithmCategoryModel(
            title: "Dynamic Programming",
            description: "Knapsack, LCS, Matrix Chain",
            iconName: "chart.line.uptrend.xyaxis.circle.fill",
            gradientColors: [Color(red: 1.0, green: 0.5, blue: 0.7), Color(red: 0.8, green: 0.3, blue: 0.5)],
            categoryType: .dynamicProgramming
        ),
        AlgorithmCategoryModel(
            title: "Bit Manipulation",
            description: "XOR Tricks, Bit Masking, Power of Two",
            iconName: "01.circle.fill",
            gradientColors: [Color(red: 0.7, green: 0.7, blue: 0.9), Color(red: 0.5, green: 0.5, blue: 0.7)],
            categoryType: .bitManipulation
        )
    ]
}
