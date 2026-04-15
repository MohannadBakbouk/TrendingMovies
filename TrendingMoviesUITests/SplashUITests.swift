//
//  SplashUITests.swift
//  TrendingMovies
//
//  Created by Mohannad on 13/04/2026.
//


import XCTest

final class SplashUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["-uitesting"]
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }

    func testIsAppNameShown() throws {
        let appName = app.staticTexts[UIIdentifier.Splash.slugLabel]
        XCTAssertTrue(appName.exists, "App title does not exist")
    }
    
    func testIsProgressViewShown() throws {
        let progressView = app.activityIndicators[UIIdentifier.Splash.progressView]
        XCTAssertTrue(progressView.exists, "ProgressView does not exist")
    }
    
    func testIsSplashNavigationWorking() throws {
        let appName = app.staticTexts[UIIdentifier.Splash.slugLabel]
        XCTAssertTrue(appName.exists, "App didnot show splash")
        sleep(2) // Wait for the transition
        XCTAssertFalse(appName.exists, "SplashView did not disappear after 2 seconds")
    }
}
