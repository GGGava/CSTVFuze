//
//  MatchesView+ViewModel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import SwiftUI

extension MatchesListView {
    final class ViewModel: ObservableObject {
        @Injected(\.matchRepository) var repository: MatchListRepository

        @Published var matches: [Match] = []
        @Published var loading = false
        @Published var hasError = false
        
        var nextPage = 1
        @Published var loadingNextPage = false
        @Published var finishedPages = false
        
        init() {
            Task {
                await getMatches()
            }
        }
        
        @MainActor
        func getMatches() async {
            loading = true
            hasError = false
            do {
                matches = try await repository.getMatchesList(page: 1)
                nextPage = 2
            } catch {
                print("Error while fetching list of matches: \(error)")
                hasError = true
            }
            loading = false
        }
        
        @MainActor
        func loadMore() async {
            guard !finishedPages else {
                return
            }
            loadingNextPage = true
            
            do {
                let nextMatches = try await repository.getMatchesList(page: nextPage)
                
                matches.append(contentsOf: nextMatches)
                if nextMatches.count < 10 {
                    finishedPages = true
                } else {
                    nextPage += 1
                }
                loadingNextPage = false
            } catch {
                print("Error while fetching next page of matches: \(error)")
                loadingNextPage = false
            }
        }
    }
}
