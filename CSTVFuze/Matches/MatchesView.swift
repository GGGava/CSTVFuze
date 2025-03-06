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
            VStack(alignment: .leading, spacing: 24) {
                Text("Partidas")
                    .font(size: 32)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                
                ForEach(viewModel.matches) {
                    MatchCardView(match: $0)
                }
            }
            .padding(24)
        }
        .background(.gray900)
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
