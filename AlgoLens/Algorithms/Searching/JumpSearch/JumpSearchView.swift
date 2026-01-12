//
//  JumpSearchView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct JumpSearchView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = JumpSearchViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color(red: 0.5, green: 0.9, blue: 0.7),
                    Color(red: 0.3, green: 0.7, blue: 0.5)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Jump Search Visualization")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // Jump Info
                    jumpInfoSection
                    
                    // Array Visualization
                    arrayVisualization
                    
                    // Search Input
                    searchInputSection
                    
                    // Controls
                    controlButtons
                    
                    // Info Section
                    infoSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - View Components
    
    private var jumpInfoSection: some View {
        VStack(spacing: 8) {
            Text("Jump Size: √\(viewModel.array.count) = \(viewModel.jumpSize)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            Text("Jumping \(viewModel.jumpSize) elements at a time")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
    
    private var arrayVisualization: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(viewModel.array.enumerated()), id: \.offset) { index, value in
                    VStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(elementColor(for: index))
                                .frame(width: 60, height: 60)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                            
                            Text("\(value)")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        if index == viewModel.jumpIndex {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 20))
                        } else if index == viewModel.currentIndex {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 20))
                        }
                        
                        Text("\(index)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
        }
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var searchInputSection: some View {
        VStack(spacing: 12) {
            Text("Search in sorted array")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                TextField("Enter number", text: $viewModel.searchInput)
                    .keyboardType(.numberPad)
                    .font(.system(size: 18, weight: .medium))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .frame(width: 150)
                
                Button(action: {
                    viewModel.startSearch()
                }) {
                    Text("Search")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0.3, green: 0.7, blue: 0.5))
                        .frame(width: 100)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
    
    private var controlButtons: some View {
        HStack(spacing: 16) {
            Button(action: {
                viewModel.reset()
            }) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Reset")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            }
            
            Button(action: {
                viewModel.generateRandomArray()
            }) {
                HStack {
                    Image(systemName: "shuffle")
                    Text("Shuffle")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            }
        }
    }
    
    private var infoSection: some View {
        VStack(spacing: 12) {
            if let message = viewModel.statusMessage {
                Text(message)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 20) {
                InfoBadge(
                    label: "Comparisons",
                    value: "\(viewModel.comparisons)",
                    icon: "arrow.left.and.right"
                )
                
                InfoBadge(
                    label: "Jumps",
                    value: "\(viewModel.jumps)",
                    icon: "figure.jumprope"
                )
            }
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
    
    // MARK: - Helper Methods
    
    private func elementColor(for index: Int) -> Color {
        if viewModel.foundIndex == index {
            return .green
        } else if viewModel.jumpIndex == index {
            return Color.yellow.opacity(0.7)
        } else if viewModel.currentIndex == index {
            return Color.orange
        } else if viewModel.searchedIndices.contains(index) {
            return Color.white.opacity(0.3)
        } else {
            return Color.white.opacity(0.2)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        JumpSearchView()
    }
}
