//
//  AnyPublisher.swift
//
//
//  Created by Rubén García on 3/11/23.
//

import Combine

public extension AnyPublisher {
     static func asyncToPublisher<T>(
        _ asyncCall: @escaping @Sendable () async throws -> T
    ) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            Task {
                do {
                    let result = try await asyncCall()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
