//
//  MovieDetailUITests.swift
//  TrendingMovies
//
//  Created by Mohannad on 15/04/2026.
//

import XCTest
import MovieDetail

@testable import TrendingMovies

final class MovieDetailUITests: XCTestCase {
    var app: XCUIApplication!
    var baseTimeout: TimeInterval = 5
    var expected: MovieDetail!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["-uitesting"]
        continueAfterFailure = false
        app.launch()
        expected = MovieDetail(id: 1990, title: "Inside out", overview:  "A heartfelt story about a girl named Riley whose emotions work together to guide her through a major life transition, showing the importance of every feeling.", posterUrl: URL(string: "google.com"), homePage:  "www.google.com", status: "Released", revenue:  "120M", runtime: 233, budget: "50K", genres: ["Animation", "Family"], langs: ["English", "Arabic"])
        navigateToDetailScreen()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testBackButtonWorks() throws {
        let backButton = app.buttons[UIIdentifier.MovieDetail.backButton]
        backButton.tap()
        let title = app.staticTexts["Watch New Movies"].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(title)
    }
    
    func testShareButtonIsDisplayed() throws {
        let shareButton = app.buttons[UIIdentifier.MovieDetail.shareButton].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(shareButton)
    }
    
    func testMovieTitleIsDisplayed() throws {
        let movieTitle = app.staticTexts[UIIdentifier.MovieDetail.title]
        assertElementExistsWithValue(movieTitle, expected: expected.title)
    }
    
    func testMovieGenreAreDisplayed() throws {
        let movieGenres = app.staticTexts[UIIdentifier.MovieDetail.genres]
        assertElementExistsWithValue(movieGenres, expected: expected.genres.joined(separator: ", "))
    }
        
    func testMovieOverviewIsDisplayed() throws {
        let movieOverview = app.staticTexts[UIIdentifier.MovieDetail.overview]
        assertElementExistsWithValue(movieOverview, expected: expected.overview)
    }
    
    func testMovieLangsAreDisplayed() throws {
        let movieLangs = app.staticTexts[UIIdentifier.MovieDetail.languages]
        assertElementExistsWithValue(movieLangs, expected: expected.langs.joined(separator: ", "))
    }

    func testMovieStatusIsDisplayed() throws {
        let movieStatus = app.staticTexts[UIIdentifier.MovieDetail.status]
        assertElementExistsWithValue(movieStatus, expected: expected.status)
    }
    
    func testMovieRunTimeIsDisplayed() throws {
        let expectedValue = "\(expected.runtime) min"
        let movieRuntime = app.staticTexts[UIIdentifier.MovieDetail.runtime]
        assertElementExistsWithValue(movieRuntime, expected: expectedValue)
    }
    
    func testMovieRevenueIsDisplayed() throws {
        let movieRevenue = app.staticTexts[UIIdentifier.MovieDetail.revenue]
        scrollDown()
        assertElementExistsWithValue(movieRevenue, expected: expected.revenue)
        XCTAssertTrue(movieRevenue.isHittable)
    }
    
    func testMovieBudgetIsDisplayed() throws {
        let movieBudget = app.staticTexts[UIIdentifier.MovieDetail.budget]
        scrollDown()
        assertElementExistsWithValue(movieBudget, expected: expected.budget)
        XCTAssertTrue(movieBudget.isHittable)
    }
    
    func testMovieScrollWorks() throws {
        let scroll = app.scrollViews[UIIdentifier.MovieDetail.scrollView]
        let movieBudget = app.staticTexts[expected.budget]
        XCTAssertTrue(scroll.waitForExistence(timeout: baseTimeout))
        XCTAssertFalse(movieBudget.isHittable)
        scroll.swipeUp()
        XCTAssertTrue(movieBudget.waitForExistence(timeout: baseTimeout))
        XCTAssertTrue(movieBudget.isHittable)
    }
}

extension MovieDetailUITests{
    func navigateToDetailScreen() {
        let scrollView = app.scrollViews[UIIdentifier.MovieList.moviesScrollView]
        XCTAssertTrue(scrollView.waitForExistence(timeout: baseTimeout))
        let movieItem = app.buttons[UIIdentifier.MovieList.movieCell(2)]
        movieItem.tap()
        let backButton = app.buttons[UIIdentifier.MovieDetail.backButton].waitForExistence(timeout: baseTimeout)
        XCTAssert(backButton)
    }
    
    func scrollDown(){
        let scroll = app.scrollViews[UIIdentifier.MovieDetail.scrollView]
        scroll.swipeUp()
        scroll.swipeUp()
    }
    
    func assertElementExistsWithValue(_ element: XCUIElement, expected: String, timeout: Int = 5) {
        XCTAssertTrue(element.waitForExistence(timeout: baseTimeout))
        XCTAssertEqual(element.label, expected)
    }
}
