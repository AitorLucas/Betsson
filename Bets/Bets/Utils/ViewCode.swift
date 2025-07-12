//
//  ViewCode.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 11/07/25.
//

import Foundation

protocol ViewCode {
    func configureView()
    func buildHierarchy()
    func setupConstraints()
    func buildAccessibility()
}

extension ViewCode {
    func setupView() {
        configureView()
        buildHierarchy()
        setupConstraints()
        buildAccessibility()
    }

    func buildAccessibility() {
        // Empty
    }
}
