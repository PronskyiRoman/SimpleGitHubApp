//
//  FetchReposivorySerceTests.swift
//  GitHubAppTests
//
//  Created by -_- on 17.01.2023.
//

import XCTest
@testable import GitHubApp

final class FetchReposivorySerceTests: XCTestCase {
    
    private var service: RepositoryService?
    
    override func setUpWithError() throws {
       try super.setUpWithError()
        service = .init()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        service = nil
    }
    
    func testGetRepoDataContainer() async throws {
        guard let service else { return }
        let testQuery = "first"
        do {
            let responce = try await service.getRepoDataContainer(for: testQuery)
            XCTAssertTrue(!responce.items.isEmpty)
        } catch NetworkError.unknown(let errorData) {
            XCTAssertTrue(errorData?.0 == nil)
            XCTAssertTrue(!(errorData?.1.isEmpty ?? false))
            XCTAssertTrue(errorData?.2 == -11)
            XCTFail("Broken data model")
        } catch {
            XCTFail("Some Error happens, \(error.localizedDescription)")
        }
    }
}
