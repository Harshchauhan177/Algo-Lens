//
//  SearchingAlgorithmDetailView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct SearchingAlgorithmDetailView: View {
    
    // MARK: - Properties
    
    let algorithm: SearchingAlgorithmModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: AlgorithmTab = .explanation
    @State private var isContentVisible = false
    @State private var navigateToVisualization = false
    
    enum AlgorithmTab: String, CaseIterable {
        case explanation = "Explanation"
        case pseudocode = "Pseudocode"
        case example = "Example"
        case howItWorks = "How"
        
        var icon: String {
            switch self {
            case .explanation: return "list.bullet.rectangle"
            case .pseudocode: return "chevron.left.forwardslash.chevron.right"
            case .example: return "lightbulb"
            case .howItWorks: return "play.circle"
            }
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with gradient
                headerSection
                
                // Tab Bar
                tabBar
                
                // Content
                ScrollView {
                    VStack(spacing: 20) {
                        switch selectedTab {
                        case .explanation:
                            explanationContent
                        case .pseudocode:
                            pseudocodeContent
                        case .example:
                            exampleContent
                        case .howItWorks:
                            howItWorksContent
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                }
                
                // Bottom Action Buttons
                bottomButtons
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(algorithm.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
            }
        }
        .navigationDestination(isPresented: $navigateToVisualization) {
            visualizationView
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                isContentVisible = true
            }
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: algorithm.gradientColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 12) {
                Text(algorithm.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(algorithm.description)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 20)
        }
    }
    
    private var tabBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(AlgorithmTab.allCases, id: \.self) { tab in
                    TabButton(
                        title: tab.rawValue,
                        icon: tab.icon,
                        isSelected: selectedTab == tab
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color(UIColor.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Tab Contents
    
    private var explanationContent: some View {
        VStack(spacing: 24) {
            // What is it
            InfoSection(
                title: "What is it?",
                icon: "info.circle.fill",
                iconColor: .blue
            ) {
                Text(algorithm.detailedDescription)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.primary)
                    .lineSpacing(6)
            }
            
            // Time & Space Complexity
            InfoSection(
                title: "Time & Space Complexity",
                icon: "gauge.medium.badge.plus",
                iconColor: .purple
            ) {
                VStack(spacing: 16) {
                    ComplexityRow(
                        label: "Time Complexity",
                        value: algorithm.timeComplexity,
                        description: getTimeComplexityDescription(),
                        color: .blue
                    )
                    
                    Divider()
                    
                    ComplexityRow(
                        label: "Space Complexity",
                        value: algorithm.spaceComplexity,
                        description: "Uses fixed amount of memory",
                        color: .purple
                    )
                }
            }
            
            // When to use
            InfoSection(
                title: "When to use",
                icon: "checkmark.circle.fill",
                iconColor: .green
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(algorithm.useCases, id: \.self) { useCase in
                        HStack(alignment: .top, spacing: 12) {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                                .padding(.top, 6)
                            
                            Text(useCase)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
    }
    
    private var pseudocodeContent: some View {
        VStack(spacing: 24) {
            // Code Implementation
            InfoSection(
                title: "Code Implementation",
                icon: "chevron.left.forwardslash.chevron.right",
                iconColor: .purple
            ) {
                VStack(alignment: .leading, spacing: 16) {
                    // Language tabs (simplified)
                    HStack(spacing: 12) {
                        LanguageTab(name: "Pseudocode", isSelected: true)
                        LanguageTab(name: "C", isSelected: false)
                        LanguageTab(name: "C++", isSelected: false)
                        LanguageTab(name: "Java", isSelected: false)
                        Spacer()
                    }
                    
                    // Code Block
                    CodeBlockView(code: getPseudocode())
                }
            }
            
            // Implementation Guide
            InfoSection(
                title: "Implementation Guide",
                icon: "doc.text.fill",
                iconColor: .blue
            ) {
                Text("This implementation demonstrates the core logic of the algorithm. You can adapt it to your specific use case and language.")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
        }
    }
    
    private var exampleContent: some View {
        VStack(spacing: 24) {
            // Sample Input
            InfoSection(
                title: "Sample Input",
                icon: "arrow.down.circle.fill",
                iconColor: .blue
            ) {
                VStack(spacing: 16) {
                    // Array visualization
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Array")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(getExampleArray(), id: \.self) { value in
                                    Text("\(value)")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.primary)
                                        .frame(width: 50, height: 50)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                        }
                        
                        // Show indices
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(0..<getExampleArray().count, id: \.self) { index in
                                    Text("[\(index)]")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.secondary)
                                        .frame(width: 50)
                                }
                            }
                        }
                    }
                    
                    // Target value
                    HStack {
                        Image(systemName: "target")
                            .font(.system(size: 20))
                            .foregroundColor(.purple)
                        
                        Text("Target Value")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(getExampleTarget())")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.purple)
                    }
                    .padding()
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            
            // Process visualization hint
            HStack(spacing: 12) {
                Image(systemName: "arrow.down")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                Text("PROCESS")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            // Expected Output
            InfoSection(
                title: "Expected Output",
                icon: "checkmark.circle.fill",
                iconColor: .green
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Index:")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(getExampleOutput())")
                            .font(.system(size: 24, weight: .bold, design: .monospaced))
                            .foregroundColor(.green)
                    }
                    
                    Text(getExampleExplanation())
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
            }
        }
    }
    
    private var howItWorksContent: some View {
        VStack(spacing: 24) {
            // Step-by-step process
            InfoSection(
                title: "Step-by-Step Process",
                icon: "list.number",
                iconColor: .orange
            ) {
                VStack(spacing: 16) {
                    ForEach(Array(getSteps().enumerated()), id: \.offset) { index, step in
                        StepRow(
                            stepNumber: index + 1,
                            title: step.title,
                            description: step.description,
                            icon: step.icon,
                            color: step.color
                        )
                    }
                }
            }
            
            // Key Points
            InfoSection(
                title: "Key Points",
                icon: "key.fill",
                iconColor: .blue
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(algorithm.keyPoints, id: \.self) { point in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            
                            Text(point)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
    }
    
    private var bottomButtons: some View {
        HStack(spacing: 12) {
            Button(action: {
                navigateToVisualization = true
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 20))
                    Text("Visualize")
                        .font(.system(size: 17, weight: .bold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: algorithm.gradientColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(14)
            }
            
            Button(action: {
                // Quiz action
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 20))
                    Text("Quiz")
                        .font(.system(size: 17, weight: .bold))
                }
                .foregroundColor(algorithm.gradientColors[0])
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(14)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(UIColor.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -5)
    }
    
    @ViewBuilder
    private var visualizationView: some View {
        switch algorithm.algorithmType {
        case .linear:
            LinearSearchView()
        case .binary:
            BinarySearchView()
        case .jump:
            JumpSearchView()
        case .interpolation:
            InterpolationSearchView()
        case .exponential:
            ExponentialSearchView()
        case .fibonacci:
            FibonacciSearchView()
        }
    }
    
    // MARK: - Helper Methods
    
    private func getTimeComplexityDescription() -> String {
        switch algorithm.algorithmType {
        case .linear:
            return "Linear - time grows with array size"
        case .binary:
            return "Logarithmic - very efficient for large datasets"
        case .jump:
            return "Square root - better than linear"
        case .interpolation:
            return "Log-log - best for uniform distributions"
        case .exponential:
            return "Logarithmic - efficient for unbounded arrays"
        case .fibonacci:
            return "Logarithmic - similar to binary search"
        }
    }
    
    private func getPseudocode() -> String {
        switch algorithm.algorithmType {
        case .linear:
            return """
function linearSearch(array, target)
    for i = 0 to length(array) - 1:
        if array[i] == target:
            return i
    return -1 (not found)
"""
        case .binary:
            return """
function binarySearch(array, target)
    left = 0
    right = length(array) - 1
    
    while left <= right:
        mid = left + (right - left) / 2
        
        if array[mid] == target:
            return mid
        else if array[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1 (not found)
"""
        case .jump:
            return """
function jumpSearch(array, target)
    n = length(array)
    step = sqrt(n)
    prev = 0
    
    while array[min(step, n) - 1] < target:
        prev = step
        step += sqrt(n)
        if prev >= n:
            return -1
    
    for i = prev to min(step, n):
        if array[i] == target:
            return i
    
    return -1 (not found)
"""
        case .interpolation:
            return """
function interpolationSearch(array, target)
    low = 0
    high = length(array) - 1
    
    while low <= high and target >= array[low] and target <= array[high]:
        pos = low + ((target - array[low]) * (high - low)) / (array[high] - array[low])
        
        if array[pos] == target:
            return pos
        else if array[pos] < target:
            low = pos + 1
        else:
            high = pos - 1
    
    return -1 (not found)
"""
        case .exponential:
            return """
function exponentialSearch(array, target)
    if array[0] == target:
        return 0
    
    i = 1
    while i < length(array) and array[i] <= target:
        i = i * 2
    
    return binarySearch(array, i/2, min(i, length(array)), target)
"""
        case .fibonacci:
            return """
function fibonacciSearch(array, target)
    n = length(array)
    fib2 = 0
    fib1 = 1
    fib = fib2 + fib1
    
    while fib < n:
        fib2 = fib1
        fib1 = fib
        fib = fib2 + fib1
    
    offset = -1
    while fib > 1:
        i = min(offset + fib2, n - 1)
        
        if array[i] < target:
            fib = fib1
            fib1 = fib2
            fib2 = fib - fib1
            offset = i
        else if array[i] > target:
            fib = fib2
            fib1 = fib1 - fib2
            fib2 = fib - fib1
        else:
            return i
    
    if fib1 and array[offset + 1] == target:
        return offset + 1
    
    return -1 (not found)
"""
        }
    }
    
    private func getExampleArray() -> [Int] {
        switch algorithm.algorithmType {
        case .linear:
            return [4, 7, 1, 9, 3]
        case .binary, .jump, .interpolation, .exponential, .fibonacci:
            return [1, 3, 5, 7, 9, 11, 13, 15]
        }
    }
    
    private func getExampleTarget() -> Int {
        switch algorithm.algorithmType {
        case .linear:
            return 9
        case .binary, .jump, .interpolation, .exponential, .fibonacci:
            return 7
        }
    }
    
    private func getExampleOutput() -> Int {
        switch algorithm.algorithmType {
        case .linear:
            return 3
        case .binary, .jump, .interpolation, .exponential, .fibonacci:
            return 3
        }
    }
    
    private func getExampleExplanation() -> String {
        switch algorithm.algorithmType {
        case .linear:
            return "The target value 9 was found at index 3 after checking 4 elements sequentially."
        case .binary:
            return "The target value 7 was found at index 3 by dividing the search space in half each time."
        case .jump:
            return "The target value 7 was found at index 3 by jumping √n steps and then performing linear search."
        case .interpolation:
            return "The target value 7 was found at index 3 by estimating position based on value distribution."
        case .exponential:
            return "The target value 7 was found at index 3 by expanding range exponentially then binary searching."
        case .fibonacci:
            return "The target value 7 was found at index 3 using Fibonacci numbers for division points."
        }
    }
    
    private func getSteps() -> [(title: String, description: String, icon: String, color: Color)] {
        switch algorithm.algorithmType {
        case .linear:
            return [
                ("Initialize", "Start at index 0 (first element)", "play.circle.fill", .green),
                ("Compare", "Compare current element with target value", "questionmark.circle.fill", .purple),
                ("Match Found", "If match found, return the current index", "checkmark.circle.fill", .orange),
                ("Move Next", "If not match, move to next element (i++)", "arrow.right.circle.fill", .blue),
                ("Repeat", "Continue until target found or array ends", "arrow.triangle.2.circlepath.circle.fill", .blue)
            ]
        case .binary:
            return [
                ("Initialize", "Set left = 0, right = array length - 1", "play.circle.fill", .green),
                ("Find Middle", "Calculate mid = (left + right) / 2", "divide.circle.fill", .purple),
                ("Compare", "Compare array[mid] with target", "questionmark.circle.fill", .orange),
                ("Adjust Range", "If target > mid, search right half; else search left half", "arrow.left.arrow.right.circle.fill", .blue),
                ("Repeat", "Continue until target found or left > right", "arrow.triangle.2.circlepath.circle.fill", .blue)
            ]
        case .jump:
            return [
                ("Initialize", "Calculate jump size = √n", "play.circle.fill", .green),
                ("Jump Forward", "Jump ahead by jump size", "arrow.up.right.circle.fill", .purple),
                ("Check Range", "If element > target, stop jumping", "checkmark.circle.fill", .orange),
                ("Linear Search", "Perform linear search in the block", "arrow.right.circle.fill", .blue),
                ("Return Result", "Return index if found, else -1", "flag.circle.fill", .blue)
            ]
        case .interpolation:
            return [
                ("Initialize", "Set low = 0, high = n - 1", "play.circle.fill", .green),
                ("Estimate Position", "Calculate position using interpolation formula", "function", .purple),
                ("Compare", "Compare array[pos] with target", "questionmark.circle.fill", .orange),
                ("Adjust Range", "Move low or high based on comparison", "arrow.left.arrow.right.circle.fill", .blue),
                ("Repeat", "Continue until found or range exhausted", "arrow.triangle.2.circlepath.circle.fill", .blue)
            ]
        case .exponential:
            return [
                ("Check First", "If first element matches, return 0", "play.circle.fill", .green),
                ("Expand Range", "Double the index (1, 2, 4, 8, ...)", "arrow.up.forward.circle.fill", .purple),
                ("Find Range", "Stop when element >= target", "checkmark.circle.fill", .orange),
                ("Binary Search", "Apply binary search in found range", "arrow.left.arrow.right.circle.fill", .blue),
                ("Return Result", "Return index from binary search", "flag.circle.fill", .blue)
            ]
        case .fibonacci:
            return [
                ("Initialize", "Generate Fibonacci numbers up to n", "play.circle.fill", .green),
                ("Divide Array", "Use Fibonacci numbers as division points", "function", .purple),
                ("Compare", "Compare element at Fibonacci position", "questionmark.circle.fill", .orange),
                ("Narrow Range", "Adjust Fibonacci numbers based on comparison", "arrow.left.arrow.right.circle.fill", .blue),
                ("Repeat", "Continue until found or range empty", "arrow.triangle.2.circlepath.circle.fill", .blue)
            ]
        }
    }
}

// MARK: - Supporting Components

struct TabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundColor(isSelected ? .white : .secondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                isSelected ? 
                    AnyView(LinearGradient(
                        colors: [Color.blue, Color.purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )) :
                    AnyView(Color(UIColor.secondarySystemGroupedBackground))
            )
            .cornerRadius(10)
        }
    }
}

struct InfoSection<Content: View>: View {
    let title: String
    let icon: String
    let iconColor: Color
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(iconColor)
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
            }
            
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
}

struct ComplexityRow: View {
    let label: String
    let value: String
    let description: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(value)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(color)
            }
            
            Text(description)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.secondary)
        }
    }
}

struct CodeBlockView: View {
    let code: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Circle().fill(.red).frame(width: 12, height: 12)
                Circle().fill(.yellow).frame(width: 12, height: 12)
                Circle().fill(.green).frame(width: 12, height: 12)
                
                Spacer()
                
                Text("Pseudocode")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button(action: {
                    UIPasteboard.general.string = code
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "doc.on.doc")
                        Text("Copy")
                    }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(UIColor.tertiarySystemGroupedBackground))
            
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundColor(.primary)
                    .padding(16)
            }
            .background(Color(UIColor.systemBackground))
        }
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(UIColor.separator), lineWidth: 1)
        )
    }
}

struct LanguageTab: View {
    let name: String
    let isSelected: Bool
    
    var body: some View {
        Text(name)
            .font(.system(size: 14, weight: isSelected ? .bold : .medium))
            .foregroundColor(isSelected ? .purple : .secondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.purple.opacity(0.1) : Color.clear)
            .cornerRadius(6)
    }
}

struct StepRow: View {
    let stepNumber: Int
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(title)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text("\(stepNumber)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                        .background(color)
                        .clipShape(Circle())
                }
                
                Text(description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SearchingAlgorithmDetailView(
            algorithm: SearchingAlgorithmModel.allSearchingAlgorithms[0]
        )
    }
}
