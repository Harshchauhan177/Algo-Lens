//
//  LinearSearchView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct LinearSearchView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = LinearSearchViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color(red: 0.4, green: 0.7, blue: 1.0),
                    Color(red: 0.3, green: 0.5, blue: 0.9)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Title
                Text("Linear Search Visualization")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Array Visualization
                arrayVisualization
                
                // Search Input
                searchInputSection
                
                // Controls
                controlButtons
                
                // Info Section
                infoSection
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - View Components
    
    private var arrayVisualization: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(viewModel.array.enumerated()), id: \.offset) { index, value in
                    VStack(spacing: 8) {
                        // Array Element
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(elementColor(for: index))
                                .frame(width: 60, height: 60)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                            
                            Text("\(value)")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        // Index Label
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
            Text("Search for a number")
                .font(.system(size: 16, weight: .semibold))
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
                        .foregroundColor(Color(red: 0.3, green: 0.5, blue: 0.9))
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
                    label: "Time",
                    value: String(format: "%.2fs", viewModel.elapsedTime),
                    icon: "clock.fill"
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
        } else if viewModel.currentIndex == index {
            return Color.orange
        } else if viewModel.searchedIndices.contains(index) {
            return Color.white.opacity(0.3)
        } else {
            return Color.white.opacity(0.2)
        }
    }
}

// MARK: - Info Badge Component

struct InfoBadge: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
            
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
            
            Text(value)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(12)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LinearSearchView()
    }
}
