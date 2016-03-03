//
//  ConnectionManagerTest.swift
//  ExerciciosTeste
//
//  Created by Hariel Giacomuzzi on 3/1/16.
//  Copyright © 2016 Giacomuzzi. All rights reserved.
//

import XCTest
@testable import ExerciciosTeste

class ConnectionManagerTest: XCTestCase {

    
    //MARK: Variables
    var ConManager  = ConnectionManager()
    
    //MARK: Tests
    func testLoginTrue(){
        let expectation = expectationWithDescription("Login")
        ConManager.login("ash", Password: "mistyS2", Completion: {response in
            XCTAssertTrue(response)
            expectation.fulfill()
        })
        waitForExpectationsWithTimeout(5.0, handler:nil)
    }

    
    func testLoginFalse(){
        let expectation = expectationWithDescription("Login")
        ConManager.login("ash", Password: "1234", Completion: {response in
            XCTAssertFalse(response)
            expectation.fulfill()
        })
        waitForExpectationsWithTimeout(5.0, handler:nil)
    }
    
    func testGetPokeData(){
        let expectation = expectationWithDescription("Login")
        ConnectionManager.Connection.getPokemonData({result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        })
        waitForExpectationsWithTimeout(5.0, handler:nil)
    }
    
    func testGetUserImage(){
        let expectation = expectationWithDescription("Login")
        ConnectionManager.Connection.getUserImage({result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        })
        waitForExpectationsWithTimeout(5.0, handler:nil)
    }
    
    //MARK: Unused
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


}
