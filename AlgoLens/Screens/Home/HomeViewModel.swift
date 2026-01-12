//
//  HomeViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var searchText: String = ""
    @Published var categories: [AlgorithmCategoryModel] = []
    @Published var areCardsVisible: Bool = false
    
    // MARK: - Computed Properties
    
    var filteredCategories: [AlgorithmCategoryModel] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { category in
                category.title.localizedCaseInsensitiveContains(searchText) ||
                category.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var categoriesCount: Int {
        filteredCategories.count
    }
    
    // MARK: - Animation Properties
    
    let cardAnimationDelay: Double = 0.05
    
    // MARK: - Initialization
    
    init() {
        loadCategories()
    }
    
    // MARK: - Public Methods
    
    func loadCategories() {
        categories = AlgorithmCategoryModel.allCategories
    }
    
    func startAnimations() {
        withAnimation(.easeOut(duration: 0.3)) {
            areCardsVisible = true
        }
    }
    
    func getCardAnimationDelay(for index: Int) -> Double {
        return Double(index) * cardAnimationDelay
    }
    
    func handleCategoryTap(_ category: AlgorithmCategoryModel) {
        // Navigation will be handled by NavigationLink in View
        print("Category tapped: \(category.title)")
    }
}
