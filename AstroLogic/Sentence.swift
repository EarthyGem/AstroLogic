//
//  primalQuadSentence.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 4/15/23.
//

import Foundation
import UIKit

func generateAstroSentence(strongestPlanet: String,
                           strongestPlanetSign: String,
                           sunSign: String,
                           moonSign: String,
                           risingSign: String, name: String) -> String {
    // Define arrays of arrays for adjectives and archetypes
    let adjectiveArrays: [String: [String]] = ["Aries": ["The Fiery", "The Bold", "The Courageous"],
                                               "Taurus": ["The Sensual", "The Peace Loving", "The Grounded"],
                                               "Gemini": ["The Witty", "The Versatile", "The Curious"],
                                               "Cancer": ["The Caring", "The Nurturing", "The Emotional"],
                                               "Leo": ["The Dramatic", "The Confident", "The Generous"],
                                               "Virgo": ["The Analytical", "The Practical", "The Informative", "Instructive"],
                                               "Libra": ["The Charming", "The Diplomatic", "The Harmonious", "The Sweet"],
                                               "Scorpio": ["The Intense", "The Deep", "The Primal", "The Resourceful"],
                                               "Sagittarius": ["The Adventurous", "The Philosophical", "The Optimistic", "The Sportive"],
                                               "Capricorn": ["The Ambitious", "The Disciplined", "The Responsible", "The Hardwroking", "The Serious", "The Orderly", "The Practical"],
                                               "Aquarius": ["The Eccentric", "The Innovative", "The Independent", "The Futuristic"],
                                               "Pisces": ["The Sensitive", "The Compassionate", "The Visionary", "The Imaginative"]]
    
    let planetArrays: [String: [String]] = [
        "Sun": [ "Charismatic One","Confident One", "Creative", "Creator", "Entertainer", "Force of Nature", "Gifted One", "Ruler"],
        "Moon": ["Nurturer", "Comforter", "Healer", "Supporter",  "Caretaker", "Gardener", "Provider"],
        "Mercury": [ "Thinker","Communicator","Problem Solver","Storyteller","Messenger",
                     "Intellectual","Teacher"],
        "Venus": [ "Romantic", "Artist","Accommodator", "Aesthete", "Harmonizer", "Beautifier",
                  "Best Friend", "Connector", "Lover",
                  "Partner", "Peacemaker" ],
        "Mars": ["Warrior", "Pioneer", "Adventurer", "Competitor", "Builder", "Fighter",  "Protector", "Trailblazer", "Champion", "Leader"],
        "Jupiter": ["Philosopher", "Adventurer", "Optimist", "Benefactor", "Bestower of Blessings", "Believer"],
        "Saturn": ["Disciplinarian", "Elder", "Organizer", "Gatekeeper", "Judge", "Planner", "Organizer", "Provider", "Realist", "Rule Maker", "Taskmaster", "Traditionalist", "Wise One", "Authority"],
        "Uranus": [ "Awakener", "Genius", "Dissenter", "Free Thinker",
                    "Groundbreaker","Rebel", "Innovator", "Iconoclast", "Activist", "Agent of Change", "Futurist",
                    "Disruptor", "Original", "Maverick", "Outsider", "Whistleblower"],
        "Neptune": ["Mystic", "Dreamer", "Visionary", "Artist", "Enchanter", "Idealist",
                                                        "Meditator",
                                                        "Medium",
                                                        "Muse",
                                                        "Poet"],

                                            "Pluto": ["Transformer",
                                                      "Alchemist",
                                                      "Confidante",
                                                      "Deep Thinker",
                                                      "Detective",
                                                      "Excavator",
                                                      "Extremist",

                                                      "Intense One",
                                                      "Occultist",
                                                      "Penetrator",
                                                      "Phoenix",
                                        
                                                      "Revealer"

                                                     ]]
    
    let signArrays: [String: [String]] = ["Aries": ["Energetic", "Confident", "Charismatic"],
                                          "Taurus": ["Reliable", "Practical", "Sensual"],
                                          "Gemini": [ "Commentator",
                                                    
                                                     
                                                  
                                                      "Scribe",
                                                    
                                                      "Teacher",
                                                      "Adaptor",
                                                      "Bookworm",
                                                    
                                                      "Communicator",
                                                      "Curious One",
                                                   
                                                      "Educator",
                                                      "Free Associator",
                                                      "Information Junkie",
                                                      "Intellectual",
                                                      "Interviewer",
                                                      "Jack-of-all-Trades",
                                                      "Journalist",
                                                      "Linguist",
                                                      "Listener",
                                                      "Messenger",
                                                      "Mouthpiece",
                                                      "Observer",
                                                      "Questioner",
                                                      "Raconteur",
                                                      "Storyteller",
                                                      "Student",
                                                      "Thinker",
                                                      "Translator",
                                                      "Trickster",
                                                      "Wordsmith",
                                                      "Writer"],
                                          "Cancer": [
                                                     
                                                      "Caregiver",
                                                      "Comforter",
                                                      "Cook",
                                                     
                                                    
                                                
                                                      "Feeler",
                                                      "Guardian",
                                                      "Healer",
                                                     
                                                      "Homebody",
                                                    
                                                   
                                                      "Nester",
                                                      "Nurse",
                                                      "Nurturer",
                                                      "Parent",
                                                      "Protector",
                                                      "Rememberer",
                                                      "Sensitive One",
                                                      "Sentimental One",
                                                      "Supportive One",
                                                      "Therapist"],
                                          "Leo": ["Aristocrat", "Champ", "Charismatic One", "Class Clown", "Comedian", "Confident One", "Creative", "Creator", "Diva", "Emcee", "Entertainer", "Force of Nature", "Gifted One", "Host", "Lion", "Performer", "Prima Donna", "Rock Star", "Artist", "Boss", "Celebrity", "Golden Child", "Icon", "Influencer", "Leader of the Pack",  "Powerhouse", "Royalty"],
                                          "Virgo": ["Servant", "Work in Progress", "Analyst", "Problem Solver", "Details Person", "Health Nut", "Purist", "Critic", "Practitioner", "Craftsperson", "Technician", "Librarian",  "Trainer", "Apprentice", "Coach", "Devotee", "Disciple", "Engineer", "Fixer", "Master-in-Training", "Mentor", "Perpetual Student", "Programmer",  "Self-Help Junkie"],
                                          "Libra": ["Peacemaker", "Diplomat", "Refiner", "Socialite", "Social Director", "Egalitarian", "Negotiator", "Matchmaker", "Artist", "Ambassador",  "Balancer", "Fashionista", "Connoisseur", "Beautifier", "Artist",  "Connoisseur", "Cosmopolitan", "Cultured One", "Decorator",  "Harmonizer", "Idealist", "Mediator", "Muse", "Philanthropist", "Social Butterfly", "Sophisticate", "Sweetheart", "Sympathizer", "Romanticizer",  "Adorer", "Altruist", "Charitable One", "Cheerleader"],
                                          "Scorpio": ["Alchemist", "Brooder", "Confidante", "Dark One", "Deep Thinker", "Detective", "Excavator", "Extremist", "Goth", "Hospice Worker", "Hypnotist", "Intense One", "Lady of the Underworld", "Lord of the Underworld", "Occultist", "Penetrator", "Phoenix", "Provocateur", "Psychoanalyst", "Reformer", "Regenerist", "Revealer", "Secret-Keeper", "Shaman", "Sorcerer", "Survivor", "Taboo-Breaker", "Transformer", "Truth-Teller", "Undertaker", "Wounded Healer"],
                                          "Sagittarius": ["Traveler", "Philosopher", "Scholar", "Sports Lover", "Risk-Taker", "Anthropologist", "Professional"],
                                          "Capricorn": ["Achiever", "Climber", "Grinder", "Boss", "Chief", "Consigliere", "Control Freak",  "Stoic", "Discipliner", "Elder", "Executive", "Gritty One", "Head of Household", "Hermit", "Judge", "Manager", "Manifester", "Master",  "Old Soul", "Parent", "Planner", "Pragmatist", "Realist", "Responsible One", "Rule-Follower", "Serious One", "Stoic", "Strategist", "Workaholic", "Taskmaster", "Traditionalist", "Gatekeeper",  "Watchdog", "Wise One", "Judge", "Authority"],
                                          "Aquarius": [
                                            "Anarchist",
                                            "Astrologer",
                                          
                                            "Awakener",
                                            "Contrarian",
                                            "Counterculturalist",
                                          
                                            "Dissenter",
                                            "Eccentric",
                                            "Entrepreneur",
                                            "Free Thinker",
                                            "Futurist",
                                            "Genius",
                                            "Groundbreaker",
                                           
                                           
                                            "Iconoclast",
                                            "Individualist",
                                            "Innovator",
                                            "Liberal",
                                            "Liberator",
                                           
                                            "Misfit",
                                            "Networker",
                                            "Nonconformist",
                                            "Outsider",
                                            
                                            "Radical",
                                            "Rebel",
                                            "Renegade",
                                            "Revolutionary",
                                           
                                            "Techie",
                                            "One of a Kind",
                                          
                                            "Agent of Change",
                                            "Disruptor",
                                            "Free Radical",
                                            "Inventor",
                                            "Maverick",
                                            "Outsider",
                                            "Astrologer",
                                            "Rebel with a Cause"
                                          ],
                                          "Pisces": ["Artist", "Bartender", "Chameleon",  "Dreamer", "Empath", "Enchanter", "Escapist",  "Idealist", "Illusionist", "Lover of God", "Magician", "Master Actor", "Meditator", "Medium", "Muse", "Mystic", "Partier", "Poet", "Ponderer", "Priest", "Priestess", "Psychic",   "Shapeshifter", "Socialist", "Spiritualist", "Visionary",  "Yogi", "Beach Bum",  "Intuitive", "Lightworker",  "Spiritual Advisor", "Surrealist", "Transcendentalist", "Utopian", "Visionary Artist"]]



    
    // Randomly select adjectives and archetypes from arrays
    let adjective = adjectiveArrays[strongestPlanetSign]!.randomElement()!
    let planetArchetype = planetArrays[strongestPlanet]!.randomElement()!
    let sunArchetype = signArrays[sunSign]!.randomElement()!
    let moonArchetype = signArrays[moonSign]!.randomElement()!
    let risingArchetype = signArrays[risingSign]!.randomElement()!
    
    // Construct and return sentence
    let sentence = "\(name) is \(adjective) \(planetArchetype), with the Spirit of the \(sunArchetype), and the soul of the \(moonArchetype), who wears the mask of the \(risingArchetype)."
    
    //    print(sentence)
    return sentence
}

// Example usage:

func nodalMadLib() -> String {
    
    
    let madLib = """
"Once upon a time there was a (adjective corresponding to south node sign describing a character corresponding to the planet ruling the south node)  who lived in a (place corresponding to southNode house) in the year (chose a random year between 1800 and 1930).

She/he was (two adjectives corresponding to south node's sign separated by “and”, If there's a conjunction to the south node, repeat this step to tell but use a different adjective to describe her as one of the characters symbolized by the planet or planets conjunct the south node)

She/he needed to learn to be more (two adjectives corresponding to the north node sign)
_, and she/he went about trying to get them in a (two more adjectives corresponding to north node sign) way, in (a place corresponding to the north node's house) . But she didn't know how to go about this very well.
(if a planet conjuncts the north node) She/he had an arch enemy, (a(n) (adjective corresponding to sign placement of the opposing planet  describing a character corresponding to the a negative character of the planet conjunct the north node) _
 ,_who also lived in (a place corresponding to the north node's house)

. This person tried to grind our heroine/hero down. (Repeat this step if there's more than one planet conjunct the north node.)
(if there's a square to the nodes) She/he also had an enemy she/he didn't know much about,
a(n) (an adjectives corresponding to squaring planet's sign describing a negative character corresponding to the squaring planet ) who lived in a
(place corresponding to house of squaring planet) . This person tried to thwart her/him, which may have come as a surprise.

She/he really needed to become or behave more like a(n) (positive adjective of the sign of the north node describing  a positive character corresponding to the planets squaring the south node or conjunct the north node) in order to handle the situation effectively

(if planets are trine or sextile to south node) She/he had an ally, an (adj. corresponding to sign of trining or sextiling planet describing a positive character corresponding to the planet sextile or trine the south node ), who lived in (place corresponding to house of trining or
and wanted to help her/him. But if our heroine/hero wasn't very conscious, this ally may have just helped her/him stay stuck, and be more (2 negative adjectives of the south node sign)

To help her/him acquire (adjectives related to the sign of the north node) and become a (positive character corresponding to the planetary ruler of the north node sign).
, it would be wise for her to develop (two positive adjectives related to the north node sign ruler), and in a(n) (positive adjective corresponding to sign of north node ) (place corresponding to house of ruler of north node)
"""
    
    
    return madLib
}
