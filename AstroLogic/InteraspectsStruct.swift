//
//  InteraspectsStruct.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/31/23.
//

import Foundation
import SwiftEphemeris


struct InteraspectData {
    let planetKeyPhrases: [String: [String]] = [
        "Sun": ["being assertive", "recognizing the difference between a healthy ego and a too-big one", "being present", "staying true to basic values no matter what", "recognizing the right path"],
        "Moon": ["feeling deeply", "being vulnerable", "asking for what’s truly needed", "relaxing and feeling safe and at home", "trusting the heart"],
        "Rising": ["self-acceptance", "claiming the right path through life", "relaxing in social situations", "understanding how we impact other people", "feeling confident and natural"],
        "Mercury": ["putting complicated things into words", "self-expression", "the benefits of an open mind", "listening well"],
        "Venus": ["tenderness", "expressing love", "trusting someone deeply", "being in a committed relationship", "bonding with someone"],
        "Mars": ["courage", "how to be assertive in the right way", "dealing well with anger", "boldly asking for what’s truly needed"],
        "Jupiter": ["faith", "self-confidence", "seeing the bright side of things", "embracing possibilities"],
        "Saturn": ["self-discipline", "sticking to one’s word", "walking the talk", "keeping promises"],
        "Uranus": ["what to rebel against", "what needs to be doubted and questioned", "who NOT to listen to", "where a little wildness pays big dividends"],
        "Neptune": ["the source of inspiration", "magic and mystery", "how to feed the imagination", "the reality of the human soul"],
        "Pluto": ["complicated, emotionally-charged subjects", "psychological truths, even difficult ones", "emotional honesty", "bringing hidden truths to the surface"]
        // Add any additional planets if required
    ]

    let aspectConditions: [String: String] = [
        "trine/sextile": "This won’t be hard for these two, but becuase of that they may sometimes need a reminder that: a little effort goes a long way!",
        "square/opposition": "This may feel like a struggle sometimes, that just means it requires a little more effort. When things get tough, remeber to keep faith – you can do it!",
        "conjunction": "Making this work well is one of the foundations of your connection to each other. Do it well and it’s a lasting treasure."
    ]

    let templates: [String] = [
        "{User A}’s {planet A} and {User B}’s {planet B} are in {aspect} compound. That means that {User B} has a lot to teach {User A} about {User B’s planet key words}, while {User A} has a lot to teach {User B} about {User A’s planet key words}.\n{aspect condition}",
        "{Aspect} compound links {User A}’s {planet A} to {User B}’s {planet B}. In their soul contract, {User B} has agreed to try to guide {User A} in learning about {User B’s planet key words}. Their relationship benefits when they both accept that! Meanwhile, keeping balance here, {User A} signed up to teach {User B} a lot about {User A’s planet key words}.\n{aspect condition}",
        "As we compare their charts, we see that {User A}’s {planet A} forms {aspect} compound with {User B}’s {planet B}. Even without intending it, {User A}’s simple presence will always be pressing {User B} toward learning about {User A’s planet key words}. At the same time – and again without even thinking about it – {User B} will return the favor by pushing {User A} to reflect on {User B’s planet key words}.\n{aspect condition}"
        // Add any additional templates if required
    ]
}

func getAspectCondition(for kind: Kind) -> String {
    switch kind {
    case .sextile, .trine:
        return "This won’t be hard for these two, but because of that they may sometimes need a reminder that: a little effort goes a long way!"
    case .square, .opposition:
        return "This may feel like a struggle sometimes, that just means it requires a little more effort. When things get tough, remember to keep faith – you can do it!"
    case .conjunction:
        return "Making this work well is one of the foundations of your connection to each other. Do it well and it’s a lasting treasure."
    default:
        return "Unique aspect dynamics are at play here, offering distinct opportunities and challenges."
    }
}


func generateInteraspectInterpretation(userA: String, userB: String, planetA: String, planetB: String, aspect: String, aspectCap: String, kind: Kind) -> String {
    let data = InteraspectData()

    // Select the key phrases
    let phraseA = data.planetKeyPhrases[planetA]?.randomElement() ?? ""
    let phraseB = data.planetKeyPhrases[planetB]?.randomElement() ?? ""

    // Select the condition phrase based on the aspect
    let conditionPhrase = getAspectCondition(for: kind)

    // Select a template
    let template = data.templates.randomElement() ?? ""

    // Replace placeholders in the template
    let interpretation = template
        .replacingOccurrences(of: "{User A}", with: userA)
        .replacingOccurrences(of: "{User B}", with: userB)
        .replacingOccurrences(of: "{planet A}", with: planetA)
        .replacingOccurrences(of: "{planet B}", with: planetB)
        .replacingOccurrences(of: "{aspect}", with: aspect)
        .replacingOccurrences(of: "{Aspect}", with: aspectCap)
        .replacingOccurrences(of: "{User A’s planet key words}", with: phraseA)
        .replacingOccurrences(of: "{User B’s planet key words}", with: phraseB)
        .replacingOccurrences(of: "{aspect condition}", with: conditionPhrase)

    return interpretation
}

public func generateAspectInterpretations(synastryChartCake: SynastryChartCake, by target: Coordinate) -> [String] {
    let chart1 = synastryChartCake.natal.rickysBodies // Replace with the actual property
    let chart2 = synastryChartCake.partner.rickysBodies // Replace with the actual property
    let aspects = synastryChartCake.aspectsFromChart1ToChart2(chart1: chart1, chart2: chart2, by: target)

    var interpretations = [String]()

    for aspect in aspects {
        // Assuming 'aspect' contains information about the two planets involved and the aspect type
        let planetA = aspect.celestialAspect?.body1.body.keyName // Replace with the actual property
        let planetB = aspect.celestialAspect?.body2.body.keyName // Replace with the actual property
        let aspectType = aspect.celestialAspect?.rickysInterAspectKeywords // Replace with the actual property
        let aspectKind = aspect.celestialAspect?.kind

        // Generate interpretation
        let interpretation = generateInteraspectInterpretation(
            userA: synastryChartCake.name1 ?? "User A",
            userB: synastryChartCake.name2 ?? "User B",
            planetA: planetA!,
            planetB: planetB!,
            aspect: aspectType!, aspectCap: aspectType!, kind: aspectKind!
        )
        interpretations.append(interpretation)
    }

    return interpretations
}
