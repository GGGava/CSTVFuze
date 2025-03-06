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
            if viewModel.loading {
                ProgressView()
            } else {
                LazyVStack {
                    ForEach(viewModel.matches) { match in
                        VStack {
                            Text("\(match.id)")
                            Text(match.name ?? "")
                            Text(match.status?.rawValue ?? "")
                            Text(match.beginAt ?? "")
                        }
                    }
                }
            }
        }
        .refreshable {
            await viewModel.getMatches()
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
        return [
            .init(id: 1, name: "Match 1", status: .running, beginAt: "01/01/2025")
        ]
    }
}
