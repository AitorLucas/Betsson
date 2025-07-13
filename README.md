[![iOS starter workflow](https://github.com/AitorLucas/Betsson/actions/workflows/ios.yml/badge.svg)](https://github.com/AitorLucas/Betsson/actions/workflows/ios.yml)

# Betsson - iOS Technical Assignment

This project is a refactored version of a legacy odds-tracking app for sporting events, developed as part of the iOS Developer process at Betsson Group.

## Overview

The app fetches betting odds and updates the UI accordingly. Bets have dynamic odds and sell-in times, and different bet types require different rule logic.

## Task Progress

### Refactor BetsRepository class, such that adding support for new bet types and their calculations is as easy as possible
- [x] Simplified current calculation
- [x] Created Rule system per Bet type
- [x] Added default StandardRule

### Add unit tests for BetsRepository
- [x] Mocked remote service
- [x] Created tests for each rule
- [x] Verified repository logic
- [x] Covered edge cases

### Refactor the Bets target using the MVVM architecture.
- [x] Organized Project and cleanup
- [x] Introduced ViewCode pattern
- [x] Assigned ViewController using code
- [x] Removed Storyboards
- [x] Separated responsibilities across View/ViewModel/Controller
- [x] Created ViewModels for list and cell
- [x] Replaced singleton service with injected dependency

### Extras
- [x] Swiftlint
- [x] Refresh button in navigation
- [x] Loading animation with transitions
- [x] Icon and selection support in cells
- [x] Error message for failed loads
- [x] Labels for Quality and Sell-In

## Author

Aitor Eler Lucas


