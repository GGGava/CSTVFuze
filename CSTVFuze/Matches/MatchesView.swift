//
//  MatchesView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

struct MatchesView: View {
    @State var viewModel = ViewModel(repository: PandaScoreMatchRepository())

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.matches) {
                    Text($0.name)
                }
            }
        }
        .task {
            await viewModel.getMatches()
        }
    }
}
