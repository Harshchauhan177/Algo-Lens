//
//  LinearSearchViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

class LinearSearchViewModel: ObservableObject {
    
    // MARK: - Algorithm Information
    
    static let algorithmName = "Linear Search"
    static let shortDescription = "Search elements one by one"
    static let detailedDescription = "Linear search is the simplest searching algorithm that sequentially checks each element in the list until a match is found or the whole list has been searched."
    static let timeComplexity = "O(n)"
    static let spaceComplexity = "O(1)"
    
    static let keyPoints = [
        "Checks each element sequentially",
        "Works on sorted and unsorted data",
        "Simple to implement",
        "Best for small datasets"
    ]
    
    static let useCases = [
        "Small datasets",
        "Unsorted data",
        "When simplicity is preferred"
    ]
    
    // MARK: - Published Properties
    
    @Published var array: [Int] = [12, 45, 23, 67, 34, 89, 15, 56]
    @Published var searchInput: String = ""
    @Published var currentIndex: Int? = nil
    @Published var foundIndex: Int? = nil
    @Published var searchedIndices: Set<Int> = []
    @Published var statusMessage: String? = nil
    @Published var comparisons: Int = 0
    @Published var elapsedTime: Double = 0.0
    @Published var isSearching: Bool = false
    
    // MARK: - Private Properties
    
    private var timer: Timer?
    private var startTime: Date?
    
    // MARK: - Methods
    
    func startSearch() {
        guard let target = Int(searchInput), !isSearching else { return }
        
        reset()
        isSearching = true
        startTime = Date()
        statusMessage = "Searching for \(target)..."
        
        performLinearSearch(target: target)
    }
    
    private func performLinearSearch(target: Int) {
        var index = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if index < self.array.count {
                self.currentIndex = index
                self.comparisons += 1
                
                if let startTime = self.startTime {
                    self.elapsedTime = Date().timeIntervalSince(startTime)
                }
                
                if self.array[index] == target {
                    // Found the element
                    self.foundIndex = index
                    self.statusMessage = "✅ Found \(target) at index \(index)!"
                    self.finishSearch()
                } else {
                    self.searchedIndices.insert(index)
                    index += 1
                }
            } else {
                // Not found
                self.currentIndex = nil
                self.statusMessage = "❌ \(target) not found in the array"
                self.finishSearch()
            }
        }
    }
    
    private func finishSearch() {
        timer?.invalidate()
        timer = nil
        isSearching = false
        currentIndex = nil
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        currentIndex = nil
        foundIndex = nil
        searchedIndices.removeAll()
        statusMessage = nil
        comparisons = 0
        elapsedTime = 0.0
        isSearching = false
    }
    
    func generateRandomArray() {
        reset()
        array = (0..<8).map { _ in Int.random(in: 10...99) }
    }
    
    deinit {
        timer?.invalidate()
    }
}
