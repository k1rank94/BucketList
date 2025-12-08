//
//  SettingsListRow.swift
//  BucketList
//
//  Created by Kiran on 05/12/25.
//

import SwiftUI

struct SettingsListRow: View {
    enum ActionType {
        case primary
        case destructive
        case navigation
        
        var color: Color {
            switch self {
            case .primary, .navigation: return .primary
            case .destructive: return .red
            }
        }
    }
    
    // Changed to Optional String
    let icon: String?
    let title: String
    let actionType: ActionType
    
    // Design Tokens (Constants)
    private let iconSize: CGFloat = 22
    private let iconSpacing: CGFloat = 12
    
    var body: some View {
        HStack(spacing: iconSpacing) {
            // Only render the Image if icon exists
            if let icon = icon {
                Image(systemName: icon)
                    .font(.body)
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(actionType.color)
            }
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(actionType.color)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(Color.gray.opacity(0.6))
        }
        .contentShape(Rectangle())
    }
}
