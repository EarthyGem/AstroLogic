//
//  graph info.swift
//  AstroLogic
//
//  Created by Errick Williams on 7/13/23.
//


import Foundation
import SwiftEphemeris


enum Element: String, CaseIterable {
    case fire, earth, air, water
}

enum Modality: String, CaseIterable {
    case cardinal, fixed, mutable
}

enum Emanation: String, CaseIterable {
    case first, second, third
}

enum Domain: String, CaseIterable {
    case `personal`, `companionship`, `public`
}

enum Trinity: String, CaseIterable {
    case life, wealth, association, psychism
}



let elementSigns: [Element: [Zodiac]] = [
    .fire: [.aries, .leo, .sagittarius],
    .earth: [.taurus, .virgo, .capricorn],
    .air: [.gemini, .libra, .aquarius],
    .water: [.cancer, .scorpio, .pisces]
]

let modalitySigns: [Modality: [Zodiac]] = [
    .cardinal: [.aries, .cancer, .libra, .capricorn],
    .fixed: [.taurus, .leo, .scorpio, .aquarius],
    .mutable: [.gemini, .virgo, .sagittarius, .pisces]
]

let emanationSigns: [Emanation: [Zodiac]] = [
    .first: [.aries, .taurus, .gemini, .cancer],
    .second: [.leo, .virgo, .libra, .scorpio],
    .third: [.sagittarius, .capricorn, .aquarius, .pisces]
]

let domainHouses: [Domain: [Int]] = [
    .personal: [12, 1, 2, 3],
    .companionship: [4, 5, 6, 7],
    .public: [8, 9, 10, 11]
]

let trinityHouses: [Trinity: [Int]] = [
    .life: [1, 5, 9],
    .wealth: [2, 6, 10],
    .association: [3, 7, 11],
    .psychism: [4, 8, 12]
]
