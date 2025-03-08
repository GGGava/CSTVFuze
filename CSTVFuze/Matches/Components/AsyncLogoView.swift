//
//  LogoView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//  Adapted from https://medium.com/@jakir/enable-image-cache-in-asyncimage-swiftui-db4b9c34603f
//  Native AsyncImage has no cache support. Currently this component is used in a LazyVStack, so every time
//  the image is rendered the AsyncImage would need to request the image again. Added this component to improve
//  the user experience when scrolling.
//

import SwiftUI

struct CachedAsyncLogoView: View {
    private let url: URL?
    @State private var image: Image? = nil
    @State private var isLoading = false

    public init(imageUrl: String?) {
        self.url = thumbUrl(from: imageUrl ?? "")
    }

    public var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
        } else {
            Circle()
                .foregroundStyle(.gray300)
                .onAppear {
                    Task {
                        await loadImage()
                    }
                }
        }
    }

    private func loadImage() async {
        guard let url = url, !isLoading else { return }

        isLoading = true

        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            await MainActor.run {
                self.image = Image(uiImage: cachedImage)
                self.isLoading = false
            }
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: request)

            if let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.image = Image(uiImage: uiImage)
                    self.isLoading = false
                }
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
