//
//  ExerciciosTesteUITests.swift
//  ExerciciosTesteUITests
//
//  Created by Hariel Giacomuzzi on 2/29/16.
//  Copyright © 2016 Giacomuzzi. All rights reserved.
//

import XCTest

class ExerciciosTesteUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin(){
        
        let app = XCUIApplication()
        let userTextField = app.textFields["User"]
        userTextField.tap()
        userTextField.typeText("ash")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("mistyS2")
        app.buttons["Catch 'Em All"].tap()
        app.tables.staticTexts["Bulbasaur"].tap()
        app.navigationBars["ExerciciosTeste.View"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        
    }
    
}
