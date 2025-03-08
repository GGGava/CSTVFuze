//
//  LogoView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

struct AsyncLogoView: View {
    var imageUrl: String?
    
    var body: some View {
        // TODO: Improve performance of async image: Add "thumbnail_" to url and possibly cache the result
        AsyncImage(url: thumbUrl(from: imageUrl ?? "")) { result in
            if let image = result.image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Circle()
                    .foregroundStyle(.gray300)
            }
        }
    }
}
