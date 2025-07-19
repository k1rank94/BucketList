//
//  ImageLoaderView.swift
//  BucketList
//
//  Created by Kiran on 10/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var imageString: String = Constants.Images.randomImage
    var body: some View {
        Rectangle()
            .overlay {
                WebImage(url: URL(string: imageString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false)
            }
            .clipped()
        
    }
}

#Preview {
    ImageLoaderView()
        .frame(width: 100, height: 200)
}
