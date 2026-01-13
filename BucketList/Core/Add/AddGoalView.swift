//
//  AddGoalView.swift
//  BucketList
//
//  Created by Kiran on 11/07/25.
//

import SwiftUI

struct AddGoalView: View {
    
    private var categories = Category.mocks
    
    @State private var goalTitleString: String = ""
    @State private var descriptionString: String = ""
    @FocusState private var isFocused: Field?
    @State private var selectedCategory: Category?
    @State private var selectedProgress: Progress = .dreaming
    @State private var targetDate: Date = Date()
    
    enum Field {
        case title, description
    }
    
    enum Progress: String, CaseIterable {
        case dreaming = "Dreaming"
        case planning = "Planning"
        case inProgress = "In Progress"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                details
                categoriesSection
                statusAndTargetDateSection
                Spacer()
                    
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "F4F6FF"))
            .onTapGesture {
                isFocused = nil
            }
            .navigationTitle("Add Goal")
        }
    }
    
    var details: some View {
        VStack(spacing: 8) {
            title
            Rectangle()
                .frame(height: 1.5)
                .foregroundStyle(.secondary.opacity(0.3))
            descriptionSection
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 1)
        )
        .padding(.top, 20)
        .padding([.leading, .trailing], 12)
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("GOAL TITLE")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            ZStack(alignment: .topLeading) {
                if goalTitleString.isEmpty {
                    Text("What do you want to do?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary.opacity(0.5))
                }
                TextField("", text: $goalTitleString)
                    .font(.body)
                    .fontWeight(.medium)
                    .focused($isFocused, equals: .title)
                    .submitLabel(.next)
                    .onSubmit {
                        isFocused = .description
                    }
            }
        }
        .padding(8)
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("DETAILS")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            ZStack(alignment: .topLeading) {
                if descriptionString.isEmpty {
                    Text("Add details about your goal...")
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundStyle(.secondary)
                }
                TextEditor(text: $descriptionString)
                    .scrollContentBackground(descriptionString.isEmpty ? .hidden : .visible)
                    .submitLabel(.done)
                    .font(.body)
                    .fontWeight(.medium)
                    .padding(.top, -8)
                    .frame(minHeight: 80, maxHeight: 150)
                    .focused($isFocused, equals: .description)
                    .onSubmit {
                        isFocused = nil
                    }
            }
        }
        .padding(8)
    }
    
    var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("CATEGORIES")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories) { category in
                        CapsuleView(
                            title: category.name,
                            iconName: category.imageString,
                            isSelected: selectedCategory == category) {
                                selectedCategory = category
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 20)
        .padding([.leading, .trailing], 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    var statusAndTargetDateSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            statusSubSection
            Rectangle()
                .frame(height: 1.5)
                .foregroundStyle(.secondary.opacity(0.3))
            dateSection
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 1)
        )
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
        
    }
    
    var statusSubSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "flag.fill")
                    .foregroundColor(.purple)

                Text("STATUS")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Picker("", selection: $selectedProgress) {
                ForEach(Progress.allCases, id: \.self) {
                    Text($0.rawValue)
                        .font(.body)
                        .fontWeight(.regular)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.all, 8)
    }
    
    var dateSection: some View {
        HStack {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.orange)
                Text("Target Date")
                    .font(.body)
                    .fontWeight(.medium)
            }
            Spacer()
            DatePicker(
                "",
                selection: $targetDate,
                displayedComponents: .date
            )
            .labelsHidden()
            .datePickerStyle(.compact)
            .tint(.gray)
        }
        
        .padding(.all, 8)
    }
}

#Preview {
//    AddGoalView()
}

