//
//  JumpSearchViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

class JumpSearchViewModel: ObservableObject {
    
    // MARK: - Algorithm Information
    
    static let algorithmName = "Jump Search"
    static let shortDescription = "Jump ahead by fixed steps"
    static let detailedDescription = "Jump search works on sorted arrays by jumping ahead by fixed steps and then performing linear search backwards when the target is found to be between two jump points."
    static let timeComplexity = "O(√n)"
    static let spaceComplexity = "O(1)"
    
    static let keyPoints = [
        "Jumps by √n steps",
        "Better than linear search",
        "Worse than binary search",
        "Good for bounded searches"
    ]
    
    static let useCases = [
        "Systems where jumping back is costly",
        "When binary search overhead is too much",
        "Sequential access memory"
    ]
    
    // MARK: - Published Properties
    
    @Published var array: [Int] = [10, 20, 30, 40, 50, 60, 70, 80, 90]
    @Published var searchInput: String = ""
    @Published var jumpIndex: Int? = nil
    @Published var currentIndex: Int? = nil
    @Published var foundIndex: Int? = nil
    @Published var searchedIndices: Set<Int> = []
    @Published var statusMessage: String? = nil
    @Published var comparisons: Int = 0
    @Published var jumps: Int = 0
    @Published var isSearching: Bool = false
    
    var jumpSize: Int {
        Int(sqrt(Double(array.count)))
    }
    
    // MARK: - Private Properties
    
    private var timer: Timer?
    private var searchSteps: [(isJump: Bool, index: Int, found: Bool)] = []
    private var currentStep: Int = 0
    
    // MARK: - Methods
    
    func startSearch() {
        guard let target = Int(searchInput), !isSearching else { return }
        
        reset()
        isSearching = true
        statusMessage = "Searching for \(target)..."
        
        calculateSearchSteps(target: target)
        animateSearch()
    }
    
    private func calculateSearchSteps(target: Int) {
        searchSteps.removeAll()
        let step = jumpSize
        var prev = 0
        var curr = 0
        
        // Jump phase
        while curr < array.count && array[curr] < target {
            searchSteps.append((isJump: true, index: curr, found: false))
            prev = curr
            curr = min(curr + step, array.count - 1)
        }
        
        // Linear search phase
        for i in prev..<min(curr + 1, array.count) {
            let found = array[i] == target
            searchSteps.append((isJump: false, index: i, found: found))
            if found { break }
        }
    }
    
    private func animateSearch() {
        currentStep = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.currentStep < self.searchSteps.count {
                let step = self.searchSteps[self.currentStep]
                
                if step.isJump {
                    self.jumpIndex = step.index
                    self.jumps += 1
                } else {
                    self.currentIndex = step.index
                    self.jumpIndex = nil
                }
                
                self.comparisons += 1
                self.searchedIndices.insert(step.index)
                
                if step.found {
                    self.foundIndex = step.index
                    if let target = Int(self.searchInput) {
                        self.statusMessage = "✅ Found \(target) at index \(step.index)!"
                    }
                    self.finishSearch()
                } else {
                    self.currentStep += 1
                }
            } else {
                if let target = Int(self.searchInput) {
                    self.statusMessage = "❌ \(target) not found"
                }
                self.finishSearch()
            }
        }
    }
    
    private func finishSearch() {
        timer?.invalidate()
        timer = nil
        isSearching = false
        jumpIndex = nil
        currentIndex = nil
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        jumpIndex = nil
        currentIndex = nil
        foundIndex = nil
        searchedIndices.removeAll()
        statusMessage = nil
        comparisons = 0
        jumps = 0
        isSearching = false
        searchSteps.removeAll()
        currentStep = 0
    }
    
    func generateRandomArray() {
        reset()
        array = (0..<9).map { _ in Int.random(in: 10...99) }.sorted()
    }
    
    deinit {
        timer?.invalidate()
    }
}
