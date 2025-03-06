//
//  MatchesView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

struct MatchesView: View {
    @State var viewModel: MatchesViewModel

    var body: some View {
        ScrollView {
            Text("Partidas")
                .font(size: 32)
                .foregroundStyle(.white)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            VStack(spacing: 24) {
                ForEach(viewModel.matches) {
                    MatchCardView(match: $0)
                }
            }
            .loadingView(loading: viewModel.loading, hasError: viewModel.hasError)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray900)
        .refreshable {
            await viewModel.getMatches()
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .clear
        }
    }
}

#Preview {
    MatchesView(
        viewModel:
            MatchesView.ViewModel(
                repository: MockedRepository()
            )
    )
}

fileprivate final class MockedRepository: MatchRepository {
    func getMatchesList() async throws -> [Match] {
        //try await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
        //throw NSError(domain: "123", code: 1)
        return [
            .init(id: 1, name: "Match 1", status: .running, beginAt: "2020-11-12T15:51:24Z"),
            .init(id: 2, name: "Match 2", status: .notStarted, beginAt: "2020-11-14T15:51:24Z")
        ]
    }
}
