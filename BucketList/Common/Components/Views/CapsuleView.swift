//
//  CapsuleView.swift
//  BucketList
//
//  Created by Kiran on 13/01/26.
//

import SwiftUI

struct CapsuleView: View {
    
    let title: String
    let iconName: String?
    let isSelected: Bool
    let action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .frame(width: 20, height: 20)
                        .clipShape(.circle)
                }
                Text(title)
                    .font(.headline)
                    .fontWeight(.regular)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .foregroundStyle(isSelected ? .white : .black)
            .background(
                isSelected ? .accent : .white
            )
            .clipShape(.capsule)
            .shadow(radius: 1)
            .padding(.all, 2)
        }
        .buttonStyle(.plain)

    }
}

#Preview {
    CapsuleView(title: "Adventure", iconName: Constants.Images.randomImage, isSelected: true, action: nil)
}
