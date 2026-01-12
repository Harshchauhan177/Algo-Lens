//
//  HomeView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

// MARK: - Home View

struct HomeView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedCategory: AlgorithmCategoryModel?
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                backgroundColor
                
                // Main Content
                ScrollView {
                    VStack(spacing: 30) {
                        // Header Section
                        headerSection
                        
                        // Search Bar
                        searchBar
                        
                        // Categories Section
                        categoriesSection
                        
                        // Grid of Cards
                        categoriesGrid
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                }
            }
            .navigationDestination(item: $selectedCategory) { category in
                if category.categoryType == .searching {
                    SearchingCategoryView()
                } else {
                    CategoryDetailView(category: category)
                }
            }
            .onAppear {
                viewModel.startAnimations()
            }
        }
    }
    
    // MARK: - View Components
    
    private var backgroundColor: some View {
        Color(UIColor.systemGroupedBackground)
            .ignoresSafeArea()
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            // Circular Icon
            Image(systemName: "brain.head.profile")
                .font(.system(size: 60, weight: .semibold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.3, green: 0.5, blue: 0.9),
                            Color(red: 0.5, green: 0.3, blue: 0.8)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 100, height: 100)
                .background(
                    Circle()
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.97))
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            // Title
            Text("Algorithms Explorer")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            // Subtitle
            Text("Master algorithms through interactive visualizations")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
            
            TextField("Search algorithms...", text: $viewModel.searchText)
                .font(.system(size: 16))
                .textFieldStyle(.plain)
            
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    withAnimation {
                        viewModel.searchText = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private var categoriesSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Categories")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("\(viewModel.categoriesCount) available")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
    
    private var categoriesGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ],
            spacing: 16
        ) {
            ForEach(Array(viewModel.filteredCategories.enumerated()), id: \.element.id) { index, category in
                Button(action: {
                    selectedCategory = category
                    viewModel.handleCategoryTap(category)
                }) {
                    CategoryCardView(
                        category: category,
                        index: index,
                        isVisible: viewModel.areCardsVisible
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.filteredCategories.count)
    }
}

// MARK: - Category Detail View (Placeholder)

struct CategoryDetailView: View {
    let category: AlgorithmCategoryModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: category.gradientColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: category.iconName)
                    .font(.system(size: 80, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(category.title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(category.description)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Text("Coming Soon")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
