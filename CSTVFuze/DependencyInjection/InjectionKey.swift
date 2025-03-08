//
//  InjectionKey.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 05/03/2025.
//

import Foundation

public protocol InjectionKey {
    associatedtype Value

    static var currentValue: Self.Value { get set }
}

private struct NetworkHandlerKey: InjectionKey {
    static var currentValue: NetworkHandling = NetworkHandler<URLSession>()
}

private struct JSONHandlerKey: InjectionKey {
    static var currentValue: JSONHandling = JSONHandler()
}

private struct MatchListRepositoryKey: InjectionKey {
    static var currentValue: MatchListRepository = PandaScoreMatchListRepository()
}

private struct OpponentsRepositoryKey: InjectionKey {
    static var currentValue: MatchStatsRepository = PandaScoreMatchStatsRepository()
}

extension InjectedValues {
    var networkHandler: NetworkHandling {
        get { Self[NetworkHandlerKey.self] }
        set { Self[NetworkHandlerKey.self] = newValue }
    }

    var jsonHandler: JSONHandling {
        get { Self[JSONHandlerKey.self] }
        set { Self[JSONHandlerKey.self] = newValue }
    }
    
    var matchListRepository: MatchListRepository {
        get { Self[MatchListRepositoryKey.self] }
        set { Self[MatchListRepositoryKey.self] = newValue }
    }
    
    var matchStatsRepository: MatchStatsRepository {
        get { Self[OpponentsRepositoryKey.self] }
        set { Self[OpponentsRepositoryKey.self] = newValue }
    }
}
