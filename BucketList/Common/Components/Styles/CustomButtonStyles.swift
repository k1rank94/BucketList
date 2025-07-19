//
//  CustomButtonStyles.swift
//  BucketList
//
//  Created by Kiran on 09/07/25.
//

import SwiftUI

struct PressDownButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}
