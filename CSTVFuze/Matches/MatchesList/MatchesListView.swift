//
//  MatchesView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

struct MatchesListView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Partidas")
                    .font(size: 32)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack(spacing: 24) {
                    ForEach(viewModel.matches) { match in
                        NavigationLink {
                            MatchStatsView(
                                viewModel: MatchStatsView.ViewModel(
                                    match: match
                                )
                            )
                        } label: {
                            MatchCardView(match: match)
                        }
                    }
                }
                .loadingView(loading: viewModel.loading, hasError: viewModel.hasError)
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray900)
            .onAppear {
                UIRefreshControl.appearance().tintColor = .clear
            }
            .refreshable {
                Task {
                    await viewModel.getMatches()
                }
            }
        }
    }
}

#Preview {
    InjectedValues[\.matchRepository] = MockedRepository()

    return MatchesListView(viewModel: MatchesListView.ViewModel())
}

fileprivate final class MockedRepository: MatchRepository {
    func getMatchesList() async throws -> [Match] {
        return [
            .init(id: 1, name: "Match 1", status: .running, beginAt: "2020-11-12T15:51:24Z"),
            .init(id: 2, name: "Match 2", status: .notStarted, beginAt: "2020-11-14T15:51:24Z")
        ]
    }
}
