//
//  CustomCategoryView.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import SwiftUI

struct CustomCategoryView: View {
    var imageString: String? = Constants.Images.randomImage
    var body: some View {
        Circle()
            .fill(Color.yellow)
            .overlay {
                if let imageString {
                    ImageLoaderView(imageString: imageString)
                    
                }
            }
            .clipped()
    }
}

#Preview {
    CustomCategoryView()
        .frame(width: 100, height: 100)
        .padding()
}
