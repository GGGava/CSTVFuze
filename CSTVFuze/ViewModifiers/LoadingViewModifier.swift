//
//  LoadingViewModifier.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    var loading: Bool
    var hasError: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if loading {
                ProgressView()
                    .controlSize(.large)
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .containerRelativeFrame([.vertical])
            } else if hasError {
                Text("Something went wrong.")
                    .foregroundColor(.white)
                    .font(size: 12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                content
            }
        }
    }
}

extension View {
    func loadingView(loading: Bool, hasError: Bool = false) -> some View {
        modifier(LoadingViewModifier(loading: loading, hasError: hasError))
    }
}
