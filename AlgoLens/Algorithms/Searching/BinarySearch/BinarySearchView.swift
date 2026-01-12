//
//  BinarySearchView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct BinarySearchView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = BinarySearchViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.6, blue: 0.7),
                    Color(red: 0.9, green: 0.4, blue: 0.5)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Title
                Text("Binary Search Visualization")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Array Visualization
                arrayVisualization
                
                // Pointers Display
                pointersDisplay
                
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(pointerBorder(for: index), lineWidth: 3)
                        )
                        
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
    
    private var pointersDisplay: some View {
        HStack(spacing: 20) {
            PointerLabel(
                label: "Left",
                value: viewModel.leftPointer != nil ? "\(viewModel.leftPointer!)" : "-",
                color: .blue
            )
            
            PointerLabel(
                label: "Mid",
                value: viewModel.midPointer != nil ? "\(viewModel.midPointer!)" : "-",
                color: .orange
            )
            
            PointerLabel(
                label: "Right",
                value: viewModel.rightPointer != nil ? "\(viewModel.rightPointer!)" : "-",
                color: .purple
            )
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
    
    private var searchInputSection: some View {
        VStack(spacing: 12) {
            Text("Search for a number (Array is sorted)")
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
                        .foregroundColor(Color(red: 0.9, green: 0.4, blue: 0.5))
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
        } else if viewModel.midPointer == index {
            return Color.orange
        } else if viewModel.searchedIndices.contains(index) {
            return Color.white.opacity(0.3)
        } else {
            return Color.white.opacity(0.2)
        }
    }
    
    private func pointerBorder(for index: Int) -> Color {
        if viewModel.leftPointer == index {
            return .blue
        } else if viewModel.midPointer == index {
            return .orange
        } else if viewModel.rightPointer == index {
            return .purple
        } else {
            return .clear
        }
    }
}

// MARK: - Pointer Label Component

struct PointerLabel: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
            
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.3))
                .cornerRadius(10)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        BinarySearchView()
    }
}
