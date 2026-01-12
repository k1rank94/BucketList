//
//  AddGoalView.swift
//  BucketList
//
//  Created by Kiran on 11/07/25.
//

import SwiftUI

struct AddGoalView: View {
    
    @State private var goalTitleString: String = ""
    @State private var descriptionString: String = ""
    @FocusState private var isFocused: Field?
    
    enum Field {
        case title, description
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                details
                Spacer()
                    
            }
            .frame(maxWidth: .infinity)
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
            description
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
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
    
    var description: some View {
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
}

#Preview {
    AddGoalView()
}
