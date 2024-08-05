//
//  NetworkMock.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/4/24.
//

import XCTest
import Networking
import Combine
@testable import Akakce_Case_Study

actor NetworkingMock: Networking {
    private let expectedResult: Any?
    private let expectedError: Error?
    private(set) var calledEndpoints: [Routing] = []
    
    init(expectedResult: Any? = nil, expectedError: Error? = nil) {
        self.expectedResult = expectedResult
        self.expectedError = expectedError
    }
    
    nonisolated func run<T>(_ route: any Routing, completion: @escaping @Sendable (Result<T, any Error>) -> Void) where T : Decodable {
        XCTFail("This method should not be used!")
        fatalError()
    }
    
    @available(iOS 13, macOS 10.15, *)
    nonisolated func run<T>(_ route: any Routing) -> AnyPublisher<T, any Error> where T : Decodable {
        XCTFail("This method should not be used!")
        fatalError()
    }
    
    @available(iOS 13, macOS 10.15, *)
    func run<T>(_ route: any Routing) async throws -> T where T : Decodable {
        calledEndpoints.append(route)
        if let error = expectedError {
            throw error
        }
        return expectedResult as! T
    }
}
