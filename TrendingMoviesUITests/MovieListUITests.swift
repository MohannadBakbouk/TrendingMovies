//
//  MovieListUITests.swift
//  TrendingMoviesUITests
//
//  Created by Mohannad on 13/04/2026.
//

import XCTest

final class MovieListUITests: XCTestCase {
    var app: XCUIApplication!
    var baseTimeout: TimeInterval = 5
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["-uitesting"]
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testMovieListTitleIsDisplayed() throws {
        let title = app.staticTexts["Watch New Movies"].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(title)
    }
    
    func testMovieListSearchbarIsDisplayed() throws {
        let field = app.textFields[UIIdentifier.MovieList.searchField].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(field)
    }
    
    func testMovieListSearchbarShowsPlaceholder() throws{
        let expected = "Search TMDB"
        let searchBar = app.textFields[UIIdentifier.MovieList.searchField]
        _ = searchBar.waitForExistence(timeout: baseTimeout)
        let actual = searchBar.placeholderValue
        XCTAssert(actual == expected)
    }
    
    func testMovieListSearchbarSearchButtonHideKeyboard() throws {
        let searchBar = app.textFields[UIIdentifier.MovieList.searchField]
        _ = searchBar.waitForExistence(timeout: baseTimeout)
        searchBar.tap()
        XCTAssertTrue(app.keyboards.element.waitForExistence(timeout: baseTimeout)) // Verify keyboard is shown
        searchBar.typeText("15")
        app.keyboards.buttons["Search"].tap()
        XCTAssertFalse(app.keyboards.element.exists)  // Verify keyboard is hidden
    }
    
    func testMovieListSearchbarIsWorking() throws{
        let searchBar = app.textFields[UIIdentifier.MovieList.searchField]
        _ = searchBar.waitForExistence(timeout: baseTimeout)
        searchBar.tap()
        searchBar.typeText("15")
        app.keyboards.buttons["Search"].tap()
        let searchedItem = app.staticTexts["Movie 15"].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(searchedItem)
    }
    
    func testMovieListGenreViewDisplaysItems() throws {
        let genre = app.buttons[UIIdentifier.MovieList.genre(16)].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(genre)
    }
    
    func testMovieListGenreViewScrollWorks() throws {
        let scroll = app.scrollViews[UIIdentifier.MovieList.genreScrollView]
        XCTAssertTrue(scroll.waitForExistence(timeout: baseTimeout))
        scroll.swipeLeft()
        let adventureGenre = scroll.buttons["Adventure"].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(adventureGenre)
    }
    
    func testMovieListDisplaysMoviesItems() {
        let scrollView = app.scrollViews[UIIdentifier.MovieList.moviesScrollView]
        XCTAssertTrue(scrollView.waitForExistence(timeout: baseTimeout))
        let movieItem1 = app.buttons[UIIdentifier.MovieList.movieCell(1)]
        let movieItem2 = app.buttons[UIIdentifier.MovieList.movieCell(2)]
        XCTAssertTrue(movieItem1.waitForExistence(timeout: baseTimeout))
        XCTAssertTrue(movieItem2.waitForExistence(timeout: baseTimeout))
    }
    
    func testMovieListSelectItemOpenDetailScreen() {
        let scrollView = app.scrollViews[UIIdentifier.MovieList.moviesScrollView]
        XCTAssertTrue(scrollView.waitForExistence(timeout: baseTimeout))
        let movieItem = app.buttons[UIIdentifier.MovieList.movieCell(2)]
        movieItem.tap()
        let backButton = app.buttons[UIIdentifier.MovieDetail.backButton].waitForExistence(timeout: baseTimeout)
        XCTAssertTrue(backButton)
    }
    
    func testMoviesPaginationLoadsNextPage() {
        let scrollView = app.scrollViews[UIIdentifier.MovieList.moviesScrollView]
        XCTAssertTrue(scrollView.waitForExistence(timeout: baseTimeout))
        let page2Cell = app.buttons[UIIdentifier.MovieList.movieCell(21)]

        for _ in 0..<10 {
            if page2Cell.exists {break}
            scrollView.swipeUp()
        }
        XCTAssertTrue(page2Cell.waitForExistence(timeout: baseTimeout))
    }
}
