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

private struct MatchRepositoryKey: InjectionKey {
    static var currentValue: MatchRepository = PandaScoreMatchRepository()
}

private struct TeamsRepositoryKey: InjectionKey {
    static var currentValue: TeamsRepository = PandaScoreTeamsRepository()
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
    
    var matchRepository: MatchRepository {
        get { Self[MatchRepositoryKey.self] }
        set { Self[MatchRepositoryKey.self] = newValue }
    }
    
    var teamsRepository: TeamsRepository {
        get { Self[TeamsRepositoryKey.self] }
        set { Self[TeamsRepositoryKey.self] = newValue }
    }
}
