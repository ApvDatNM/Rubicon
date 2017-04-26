//
//  StorageTests.swift
//  Rubicon
//
//  Created by Kryštof Matěj on 26/04/2017.
//  Copyright © 2017 Kryštof Matěj. All rights reserved.
//

import XCTest

class StorageTests: XCTestCase {

    func test_givenNoToken_whenInit_thenThrowException() {
        testStorageException(with: .noTokens) {
            _ = try Storage(tokens: [])
        }
    }

    func test_givenOneToken_whenInit_thenInit() {
        do {
            _ = try Storage(tokens: [.colon])
        } catch {
            XCTFail()
        }
    }

    func test_whenGetCurrentToken_thenReturnFirst() {
        do {
            let storage = try Storage(tokens: [.colon, .comma])
            XCTAssertEqual(storage.current, .colon)
        } catch {
            XCTFail()
        }
    }

    func test_givenOneToken_whenGetNextToken_thenThrowException() {
        testStorageException(with: .noNextToken) {
            let storage = try Storage(tokens: [.colon])
            _ = try storage.next()
        }
    }

    func test_givenTwoTokens_whenGetNextToken_thenReturnSecondToken() {
        do {
            let storage = try Storage(tokens: [.colon, .comma])
            let token = try storage.next()
            XCTAssertEqual(token, .comma)
        } catch {
            XCTFail()
        }
    }

    func test_whenGetPreviousToken_thenThrowException() {
        testStorageException(with: .noPreviousToken) {
            let storage = try Storage(tokens: [.colon])
            _ = try storage.previous()
        }
    }

    func test_givenTwoTokens_whenGetNextAndPreviousToken_thenReturnFirstToken() {
        do {
            let storage = try Storage(tokens: [.colon, .comma])
            let token = try storage.next()
            XCTAssertEqual(token, .comma)
            let firstToken = try storage.previous()
            XCTAssertEqual(firstToken, .colon)
        } catch {
            XCTFail()
        }
    }

    private func testStorageException(with exception: StorageError, parse: (() throws -> ())) {
        testException(with: exception, parse: parse)
    }

}
