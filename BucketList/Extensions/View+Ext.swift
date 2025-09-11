//
//  View+Ext.swift
//  BucketList
//
//  Created by Kiran on 09/07/25.
//

import SwiftUI

extension View {
    func pressDownButtonStyle() -> some View {
        self.buttonStyle(PressDownButtonStyle())
    }
    
    func commonButtonStyle() -> some View {
        self
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
    }
}
