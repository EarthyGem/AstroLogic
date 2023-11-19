//
//  graph info.swift
//  AstroLogic
//
//  Created by Errick Williams on 7/13/23.
//


import Foundation
import SwiftEphemeris


enum Element: String, CaseIterable {
    case inspiration, practicality, intellect, emotion
}

enum Modality: String, CaseIterable {
    case pioneer, perfector, developer
}

enum Emanation: String, CaseIterable {
    case liberty, modification, reserve
}

enum Domain: String, CaseIterable {
    case `personal`, `companionship`, `public`
}

enum Trinity: String, CaseIterable {
    case action, reality, connecting, healing
}



let elementSigns: [Element: [Zodiac]] = [
    .inspiration: [.aries, .leo, .sagittarius],
    .practicality: [.taurus, .virgo, .capricorn],
    .intellect: [.gemini, .libra, .aquarius],
    .emotion: [.cancer, .scorpio, .pisces]
]

let modalitySigns: [Modality: [Zodiac]] = [
    .pioneer: [.aries, .cancer, .libra, .capricorn],
    .perfector: [.taurus, .leo, .scorpio, .aquarius],
    .developer: [.gemini, .virgo, .sagittarius, .pisces]
]

let emanationSigns: [Emanation: [Zodiac]] = [
    .liberty: [.aries, .taurus, .gemini, .cancer],
    .modification: [.leo, .virgo, .libra, .scorpio],
    .reserve: [.sagittarius, .capricorn, .aquarius, .pisces]
]

let domainHouses: [Domain: [Int]] = [
    .personal: [12, 1, 2, 3],
    .companionship: [4, 5, 6, 7],
    .public: [8, 9, 10, 11]
]

let trinityHouses: [Trinity: [Int]] = [
    .action: [1, 5, 9],
    .reality: [2, 6, 10],
    .connecting: [3, 7, 11],
    .healing: [4, 8, 12]
]
