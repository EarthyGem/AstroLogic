//
//  primalQuadSentence.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 4/15/23.
//

import Foundation
import UIKit

func generateAstroSentence(strongestPlanet: String, strongestPlanetSign: String, sunSign: String, moonSign: String, risingSign: String) -> String {
    // Define arrays of arrays for adjectives and archetypes
    let adjectiveArrays: [String: [String]] = ["Aries": ["The Fiery", "The Bold", "The Courageous"],
                                                "Taurus": ["The Sensual", "The Loyal", "The Grounded"],
                                                "Gemini": ["The Witty", "The Versatile", "The Curious"],
                                                "Cancer": ["The Intuitive", "The Nurturing", "The Emotional"],
                                                "Leo": ["The Dramatic", "The Confident", "The Generous"],
                                                "Virgo": ["The Analytical", "The Practical", "The Perfectionist"],
                                                "Libra": ["The Charming", "The Diplomatic", "The Harmonious"],
                                                "Scorpio": ["The Intense", "The Mysterious", "The Powerful"],
                                                "Sagittarius": ["The Adventurous", "The Philosophical", "The Optimistic"],
                                                "Capricorn": ["The Ambitious", "The Disciplined", "The Responsible"],
                                                "Aquarius": ["The Eccentric", "The Humanitarian", "The Independent"],
                                                "Pisces": ["The Dreamy", "The Compassionate", "The Creative"]]
    
    let planetArrays: [String: [String]] = ["Sun": ["Charismatic One","Confident One", "Creative", "Creator", "Entertainer", "Force of Nature", "Gifted One", "Ruler"]
,
                                            
"Moon": ["Nurturer", "Comforter", "Healer", "Supporter",  "Caretaker", "Gardener", "Empath"]
,
"Mercury": ["Thinker","Intelligent )ne","Communicator","Problem Solver","Adaptable One","Journalist","Messenger",
"Intellectual","Teacher"],
                                            
"Venus": ["Sensualist", "Romantic", "Artist","Accommodator", "Aesthete", "Ambassador", "Balancer", "Beautifier", "Best Friend", "Charmer", "Connector", "Counselor", "Curator", "Lover", "Matchmaker", "Negotiator", "Partner", "Peacemaker"
],
                                            
"Mars": ["Warrior", "Pioneer", "Adventurer", "Challenger", "Competitor", "Conqueror", "Courageous One", "Crusader", "Dynamic Force", "Builder", "Fighter", "Pioneer", "Protector", "Trailblazer", "Champion", "Leader"]
,
                                           
"Jupiter": ["Philosopher", "Adventurer", "Optimist", "Promoter", "Bebefactor", "Bestower of Blessings", "True Believer"],
                                            
"Saturn": ["Expert", "Disciplinarian", "Elder", "Organizer", "Gatekeeper", "Judge", "Planner", "Organizer", "Provider", "Realist", "Rule Maker", "Taskmaster", "Traditionalist", "Wise One", "Authority", "Worker"]
,
                                            
"Uranus": ["Awakener", "Genius", "Counterculturalist", "Dissenter", "Eccentric", "Entrepreneur", "Free Thinker",   "Groundbreaker", "Heretic","Rebel", "Innovator", "Iconoclast",   "Activist",
           "Agent of Change",
                          "Futurist",
           "Disruptor",
    "Orginal",
           "Maverick",
           "Outsider",
           "Whistleblower"],
                                         
"Neptune": ["Mystic", "Dreamer", "Visionary", "Artist",
            "Empath",
            "Enchanter",
                     "Idealist",
            "Lover of God",
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
    "Provocateur",
    "Psychoanalyst",
    "Reformer",
    "Regenerist",
    "Revealer"

]]
    
    let signArrays: [String: [String]] = ["Aries": ["Energetic", "Confident", "Charismatic"],
                                          "Taurus": ["Reliable", "Practical", "Sensual"],
                                          "Gemini": [ "Commentator",
                                                      "Connector",
                                                      "Critic",
                                                      "Debunker",
                                                      "Detective",
                                                      "Fact-Checker",
                                                      "Linguaphile",
                                                      "Logician",
                                                      "Problem-Solver",
                                                      "Researcher",
                                                      "Scholar",
                                                      "Scribe",
                                                      "Synthesizer",
                                                      "Teacher",
                                                      "Adaptor",
                                                      "Bookworm",
                                                      "Butterfly",
                                                      "Communicator",
                                                      "Curious One",
                                                      "Debater",
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
                                          "Cancer": [ "Archeologist",
                                                      "Babysitter",
                                                      "Caregiver",
                                                      "Comforter",
                                                      "Cook",
                                                      "Doctor",
                                                      "Domestic Goddess",
                                                      "Doula",
                                                      "Family Guy",
                                                      "Father",
                                                      "Feeler",
                                                      "Guardian",
                                                      "Healer",
                                                      "Historian",
                                                      "Homebody",
                                                      "Imaginer",
                                                      "Kind One",
                                                      "Midwife",
                                                      "Mother",
                                                      "Nanny",
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
                                          "Leo": ["Aristocrat", "Champ", "Charismatic One", "Class Clown", "Comedian", "Confident One", "Creative", "Creator", "Diva", "Emcee", "Entertainer", "Force of Nature", "Gifted One", "Host", "Knight in Shining Armor", "Lion", "Performer", "Prima Donna", "Reluctant Leader", "Rock Star", "Artist", "Boss", "Celebrity", "Golden Child", "Icon", "Influencer", "Leader of the Pack",  "Powerhouse", "Royalty"],
                                          "Virgo": ["Servant", "Perfectionist", "Analyst", "Problem Solver", "Details Person", "Health Nut", "Purist", "Organizer", "Critic", "Practitioner", "Craftsperson", "Technician", "Librarian", "Volunteer", "Trainer", "Adept One", "Artisan", "Assistant", "Coach", "Devotee", "Disciple", "Engineer", "Fixer", "Master-in-Training", "Mentor", "Perpetual Student", "Programmer", "Researcher", "Scribe", "Self-Help Junkie"],
                                          "Libra": ["Peacemaker", "Diplomat", "Refiner", "Socialite", "Social Director", "Egalitarian", "Negotiator", "Matchmaker", "Artist", "Ambassador", "Counselor", "Balancer", "Fashionista", "Connoisseur", "Beautifier", "Artist", "Bon Vivant", "Collector", "Connoisseur", "Cosmopolitan", "Cultured One", "Decorator", "Empath", "Enchantress", "Gentle Spirit", "Glamourous One", "Harmonizer", "Idealist", "Mediator", "Muse", "Philanthropist", "Social Butterfly", "Sophisticate", "Sweetheart", "Sympathizer", "Romanticizer", "Hedonist", "Adorer", "Altruist", "Charitable One", "Cheerleader"],
                                          "Scorpio": ["Alchemist", "Brooder", "Confidante", "Dark One", "Deep Thinker", "Detective", "Excavator", "Extremist", "Goth", "Hospice Worker", "Hypnotist", "Intense One", "Lady of the Underworld", "Lord of the Underworld", "Occultist", "Penetrator", "Phoenix", "Provocateur", "Psychoanalyst", "Reformer", "Regenerist", "Revealer", "Secret-Keeper", "Shaman", "Sorcerer", "Survivor", "Taboo-Breaker", "Transformer", "Truth-Teller", "Undertaker", "Vamp", "Wounded Healer"],
                                          "Sagittarius": ["Adventurous", "Philosophical", "Optimistic"], "Capricorn": ["Achiever", "Ambitious One", "Architect", "Authority Figure", "Boss", "Chief", "Consigliere", "Control Freak", "Conventional One", "Disciplined One", "Discipliner", "Elder", "Executive", "Gritty One", "Head of Household", "Hermit", "Judge", "Manager", "Manifester", "Master", "Matriarch", "Old Soul", "Parent", "Planner", "Patriarch", "Pragmatist", "Proprietor", "Realist", "Responsible One", "Rock", "Rule-Follower", "Serious One", "Social Climber", "Spartan", "Stoic", "Strategist", "Workaholic", "Taskmaster", "Traditionalist", "Gatekeeper", "Perfectionist", "Professional", "Self-Made Man/Woman", "Survivor", "Wise Teacher", "Timekeeper", "Watchdog", "Wise One", "Builder", "Scientist", "Engineer", "Fixer", "Accountant", "Economist", "Lawyer", "Judge", "Authority"],
                                          "Aquarius": [
                                            "Anarchist",
                                            "Astrologer",
                                            "Atheist",
                                            "Awakener",
                                            "Contrarian",
                                            "Counterculturalist",
                                            "Criminal",
                                            "Dissenter",
                                            "Eccentric",
                                            "Entrepreneur",
                                            "Free Thinker",
                                            "Futurist",
                                            "Genius",
                                            "Groundbreaker",
                                            "Heretic",
                                            "Humanitarian",
                                            "Iconoclast",
                                            "Individualist",
                                            "Innovator",
                                            "Liberal",
                                            "Liberator",
                                            "Loner",
                                            "Misfit",
                                            "Networker",
                                            "Nonconformist",
                                            "Outsider",
                                            "Protester",
                                            "Radical",
                                            "Rebel",
                                            "Renegade",
                                            "Revolutionary",
                                            "Scientist",
                                            "Techie",
                                            "Unique One",
                                            "Whistleblower",
                                            "Activist",
                                            "Agent of Change",
                                            "Disruptor",
                                            "Free Radical",
                                            "Inventor",
                                            "Maverick",
                                            "Outsider",
                                            "Pioneer",
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
    let sentence = "You are \(adjective) \(planetArchetype), with the Spirit of the \(sunArchetype), and the soul of the \(moonArchetype), who wears the mask of the \(risingArchetype)."
    
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
