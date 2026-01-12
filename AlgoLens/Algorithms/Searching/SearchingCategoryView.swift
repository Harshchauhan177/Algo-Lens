//
//  SearchingCategoryView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct SearchingCategoryView: View {
    
    // MARK: - Properties
    
    @State private var selectedAlgorithm: SearchingAlgorithmModel?
    @State private var areCardsVisible = false
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header Section
                    headerSection
                    
                    // Subtitle
                    subtitleSection
                    
                    // Algorithms List
                    algorithmsListSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedAlgorithm) { algorithm in
            SearchingAlgorithmDetailView(algorithm: algorithm)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                areCardsVisible = true
            }
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.4, green: 0.7, blue: 1.0).opacity(0.2),
                                Color(red: 0.3, green: 0.5, blue: 0.9).opacity(0.2)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: 50, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.4, green: 0.7, blue: 1.0),
                                Color(red: 0.3, green: 0.5, blue: 0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .shadow(color: Color(red: 0.3, green: 0.5, blue: 0.9).opacity(0.3), radius: 15, x: 0, y: 8)
            
            // Title
            Text("Searching Algorithms")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
    }
    
    private var subtitleSection: some View {
        Text("Understand how data is searched step by step")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
    }
    
    private var algorithmsListSection: some View {
        VStack(spacing: 16) {
            ForEach(Array(SearchingAlgorithmModel.allSearchingAlgorithms.enumerated()), id: \.element.id) { index, algorithm in
                Button(action: {
                    selectedAlgorithm = algorithm
                }) {
                    SearchingAlgorithmCard(
                        algorithm: algorithm,
                        index: index,
                        isVisible: areCardsVisible
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

// MARK: - Searching Algorithm Card Component

struct SearchingAlgorithmCard: View {
    let algorithm: SearchingAlgorithmModel
    let index: Int
    let isVisible: Bool
    
    @State private var isAnimated = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: algorithm.gradientColors.map { $0.opacity(0.2) },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: algorithm.iconName)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: algorithm.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(algorithm.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(algorithm.description)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                // Complexity Tags
                HStack(spacing: 8) {
                    ComplexityTag(label: "Time: \(algorithm.timeComplexity)", color: .blue)
                    ComplexityTag(label: "Space: \(algorithm.spaceComplexity)", color: .green)
                }
            }
            
            Spacer()
            
            // Arrow
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .offset(y: isAnimated ? 0 : 30)
        .opacity(isAnimated ? 1 : 0)
        .onChange(of: isVisible) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isAnimated = true
                    }
                }
            }
        }
    }
}

// MARK: - Complexity Tag Component

struct ComplexityTag: View {
    let label: String
    let color: Color
    
    var body: some View {
        Text(label)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.1))
            .cornerRadius(6)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SearchingCategoryView()
    }
}
