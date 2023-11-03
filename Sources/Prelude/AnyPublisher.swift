//
//  AnyPublisher.swift
//
//
//  Created by Rubén García on 3/11/23.
//

import Combine
/**
  This function is to guarantee compatibility between old parts of Combine and new parts of AsyncAwait, with it you can convert easily from a async await request to a combine
 
 AnyPublisher.asyncToPublisher {
    return try await fetchDataFromNetwork()
 }
 .sink { _ in
 
 }
 receiveValue: { data in
    print("Data received: \(data)")
 }
 store(in: &cancellables)
 */
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
