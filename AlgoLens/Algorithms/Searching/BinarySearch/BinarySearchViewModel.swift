//
//  BinarySearchViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

class BinarySearchViewModel: ObservableObject {
    
    // MARK: - Algorithm Information
    
    static let algorithmName = "Binary Search"
    static let shortDescription = "Divide and search in sorted data"
    static let detailedDescription = "Binary search is an efficient algorithm for finding an item from a sorted list by repeatedly dividing the search interval in half."
    static let timeComplexity = "O(log n)"
    static let spaceComplexity = "O(1)"
    
    static let keyPoints = [
        "Requires sorted data",
        "Divides search space in half",
        "Very efficient for large datasets",
        "Uses divide and conquer approach"
    ]
    
    static let useCases = [
        "Large sorted datasets",
        "Database indexing",
        "Dictionary lookups"
    ]
    
    // MARK: - Published Properties
    
    @Published var array: [Int] = [12, 23, 34, 45, 56, 67, 78, 89]
    @Published var searchInput: String = ""
    @Published var leftPointer: Int? = nil
    @Published var rightPointer: Int? = nil
    @Published var midPointer: Int? = nil
    @Published var foundIndex: Int? = nil
    @Published var searchedIndices: Set<Int> = []
    @Published var statusMessage: String? = nil
    @Published var comparisons: Int = 0
    @Published var elapsedTime: Double = 0.0
    @Published var isSearching: Bool = false
    
    // MARK: - Private Properties
    
    private var timer: Timer?
    private var startTime: Date?
    private var searchSteps: [(left: Int, right: Int, mid: Int, found: Bool)] = []
    private var currentStep: Int = 0
    
    // MARK: - Methods
    
    func startSearch() {
        guard let target = Int(searchInput), !isSearching else { return }
        
        reset()
        isSearching = true
        startTime = Date()
        statusMessage = "Searching for \(target)..."
        
        // Calculate all steps first
        calculateSearchSteps(target: target)
        
        // Animate through steps
        animateSearch()
    }
    
    private func calculateSearchSteps(target: Int) {
        var left = 0
        var right = array.count - 1
        searchSteps.removeAll()
        
        while left <= right {
            let mid = left + (right - left) / 2
            let found = array[mid] == target
            searchSteps.append((left: left, right: right, mid: mid, found: found))
            
            if found {
                break
            } else if array[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    
    private func animateSearch() {
        currentStep = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.currentStep < self.searchSteps.count {
                let step = self.searchSteps[self.currentStep]
                
                self.leftPointer = step.left
                self.rightPointer = step.right
                self.midPointer = step.mid
                self.comparisons += 1
                
                if let startTime = self.startTime {
                    self.elapsedTime = Date().timeIntervalSince(startTime)
                }
                
                self.searchedIndices.insert(step.mid)
                
                if step.found {
                    self.foundIndex = step.mid
                    if let target = Int(self.searchInput) {
                        self.statusMessage = "✅ Found \(target) at index \(step.mid)!"
                    }
                    self.finishSearch()
                } else {
                    self.currentStep += 1
                }
            } else {
                // Not found
                if let target = Int(self.searchInput) {
                    self.statusMessage = "❌ \(target) not found in the array"
                }
                self.finishSearch()
            }
        }
    }
    
    private func finishSearch() {
        timer?.invalidate()
        timer = nil
        isSearching = false
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        leftPointer = nil
        rightPointer = nil
        midPointer = nil
        foundIndex = nil
        searchedIndices.removeAll()
        statusMessage = nil
        comparisons = 0
        elapsedTime = 0.0
        isSearching = false
        searchSteps.removeAll()
        currentStep = 0
    }
    
    func generateRandomArray() {
        reset()
        array = (0..<8).map { _ in Int.random(in: 10...99) }.sorted()
    }
    
    deinit {
        timer?.invalidate()
    }
}
