//
//  StorybookAppUITests.swift
//  StorybookAppUITests
//
//  Created by Anton Ogarkov on 23.07.2020.
//  Copyright © 2020 SigmaSoftware. All rights reserved.
//

import XCTest
import TestScenarioUtils

class StorybookAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()

        let loginScenario = ActivateScenario(scenario: LoginScenario.self)

        app.textFields["emailFIeld"].tap()

        app.writeOnKeyboard(text: "email")

        app.keys["more"].tap()

        app.keys["@"].tap()

        app.keys["more"].tap()

        app.writeOnKeyboard(text: "mail")

        app.keys["more"].tap()

        app.keys["."].tap()

        app.keys["more"].tap()

        app.writeOnKeyboard(text: "com")

        app.buttons["Next:"].tap()

        ValidateScenarioEventIsFired(eventToValidate: loginScenario.makeProps().didChangeMail("email@mail.com"))

        app.buttons["shift"].tap()

        app.writeOnKeyboard(text: "Password")

        app.keys["more"].tap()

        app.writeOnKeyboard(text: "1234")

        app.buttons["Done"].firstMatch.tap()

        ValidateScenarioEventIsFired(eventToValidate: loginScenario.makeProps().didChangePassword("Password1234"))

        app.buttons["goButton"].tap()

        ValidateScenarioEventIsFired(eventToValidate: loginScenario.makeProps().goButtonTouch())

        DeactivateScenario()

        app.terminate()
    }

    func testAddAddress() {
        let app = XCUIApplication()
        app.launch()

        let addAddressScenario = ActivateScenario(scenario: AddAddressScenario.self)

        app.textFields["address1"].tap()

        app.buttons["shift"].tap()
        app.writeOnKeyboard(text: "Infinite")

        app.keys["space"].tap()

        app.buttons["shift"].tap()
        app.writeOnKeyboard(text: "Loop")

        app.buttons["next"].tap()
        ValidateScenarioEventIsFired(eventToValidate: addAddressScenario.makeProps().didChangeAddressLine1("Infinite Loop"))

        app.keys["more"].tap()
        app.keys["1"].tap()

        app.buttons["next"].tap()
        ValidateScenarioEventIsFired(eventToValidate: addAddressScenario.makeProps().didChangeAddressLine2("1"))

        app.buttons["shift"].tap()
        app.writeOnKeyboard(text: "Cupertino")

        app.buttons["next"].tap()
        ValidateScenarioEventIsFired(eventToValidate: addAddressScenario.makeProps().didChangeCity("Cupertino"))

        app.buttons["shift"].tap()
        app.writeOnKeyboard(text: "C")
        app.buttons["shift"].tap()
        app.writeOnKeyboard(text: "A")

        app.buttons["next"].tap()
        ValidateScenarioEventIsFired(eventToValidate: addAddressScenario.makeProps().didChangeState("CA"))

        app.keys["more"].tap()
        app.writeOnKeyboard(text: "95014")

        app.buttons["done"].firstMatch.tap()
        ValidateScenarioEventIsFired(eventToValidate: addAddressScenario.makeProps().didChangeZip("95014"))

        app.buttons["addAddressButton"].tap()
        ValidateScenarioEventIsFired(eventToValidate: addAddressScenario.makeProps().addAddressButtonTouch())

        DeactivateScenario()

        app.terminate()
    }
}

extension XCUIApplication {
    func writeOnKeyboard(text: String) {
        text.forEach { self.keys[String($0)].tap() }
    }
}
