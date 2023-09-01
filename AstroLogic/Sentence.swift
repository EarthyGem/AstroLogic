//
//  primalQuadSentence.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 4/15/23.
//

import Foundation
import UIKit



var risingSignArray: [String: [String]] = [:]

func generateAstroSentence(strongestPlanet: String,
                           strongestPlanetSign: String,
                           sunSign: String,
                           moonSign: String,
                           risingSign: String, name: String) -> String {
    // Define arrays of arrays for adjectives and archetypes
    let adjectiveArrays: [String: [String]] = ["Aries": ["The Fiery", "The Bold", "The Courageous", "The Pioneering", "The Competitive", "The Passionate", "The Energetic", "The Active", "The Independant", "The Assertive", "The Militant", "The Combative", "The Commanding", "The Pushy", "The Lusty"
                                                        ],
                                               "Taurus": ["The Plodding", "The Peace Loving", "The Grounded", "The Steadfast", "The Dependable", "The Practical", "The Relaible", "The Possesive", "The Patient", "The Industrious", "The Conservative", "The Stubborn", "The Immovable"],
                                                          "Gemini": ["The Witty", "The Versatile", "The Curious", "The Open-Minded", "The Perceptive", "The Chatty", "The Verbose", "The Thinking", "The Nervous", "The Mercurial", "The Changable", "The Intellectual", "The Restless", "Informative", "Multi-tasking", "The Dexterious"],
                                               "Cancer": ["The Caring", "The Nurturing", "The Sensitive", "The Family Oriented", "The Protective", "The Shy", "The Emotional", "The Moody", "The Mediumistic", "The Sympathetic", "The Timid", "The Receptive", "The Adaptable", "The Whimsical", "The Tenacious", "The Impressionistic", "The Domestic", "The Kind", "The Dreamy"
                                                         ],
                                               "Leo": ["The Shining", "The Dignified", "The Warmhearted", "The Candid", "Forceful", "Dominating","The Majestic", "The Strong", "The Impactful", "The Proud", "The Regal", "The Willful", "The Commanding", "The Bossy"],
                                               "Virgo": ["The Analytical", "The Practical", "The Informative", "Instructive", "The Studious", "The Critical", "The Discriminating", "The Bold", "The Knowledgeable","The Scientific", "The Mentally Alert", "The Ingenious", "Bingey"],
                                               "Libra": ["The Pleasing", "The Diplomatic", "The Harmonious", "The Sweet", "The Artistic", "The Peace Loving", "The Harmonizing", "The Appreciative", "The Social", "The Refined", "The Sympathetic", "The Affectionate", "The Polite", "The Courteous"],
                                               "Scorpio": ["The Intense", "The Deep", "The Dark", "The Resourceful", "The Desirious", "The Penetrating", "The Forceful", "The Magnetic", "The Secretive", "The Brooding", "The Determined"],
                                               "Sagittarius": ["The Adventurous", "The Philosophical", "The Optimistic", "The Sportive", "The Opinionated", "The Dogmatic", "The Religious", "The Larger-Than-Life", "The Jovial", "The Fun Loving", "The Enthusiastic", "The Outspoken", "The Generous", "The Patriotic", "The Faithful", "The Loyal"],
                                               "Capricorn": ["The Ambitious", "The Disciplined", "The Responsible", "The Hardworking", "The Serious", "The Orderly", "The Practical", "The Cheap", "The Economical", "The Business-Minded", "The Industrious", "The Cunning", "The Cautious", "The Careful"],
                                               "Aquarius": ["The Eccentric", "The Innovative", "The Power Hunry", "Independent", "The Futuristic", "The Rebelious", "The Freedom Loving", "The Individualistic", "The One-of-a-Kind", "The Friendly", "The Genius", "The Independant", "The Controlling", "The Progresive", "The Argumentative" ],
                                               "Pisces": ["The Sensitive", "The Compassionate", "The Visionary", "The Imaginative", "The Spiritual", "The Other Worldly", "The Dreamy", "The Transcendant", "The Poetic", "The Idealitic", "The Mystical", "The Mediumistic", "The Sympathetic", "The Romantic", "The Worrisome", "The Delusional", "The Confused", ]]
    
    let planetArrays: [String: [String]] = [
        "Sun": [ "Life of The Party", "Creative", "Creator", "Entertainer", "Golden Child", "Winner", "Leader"],
        "Moon": ["Nurturer", "Comforter", "Healer", "Supporter",  "Caretaker", "Gardener", "Homebody", "Homemaker", "Feeler", "Popular"],
        "Mercury": [ "Thinker","Communicator","Problem Solver","Storyteller","Messenger",
                     "Intellectual","Teacher", "Jack-of-all-Trades", "Multi-Tasker"],
        "Venus": [ "Socialite", "Artist","Accommodator", "Aesthete", "Harmonizer", "Beautifier", "Connector", "Lover",
                  "Partner", "Peacemaker" ],
        "Mars": ["Warrior", "Pioneer", "Adventurer", "Competitor", "Builder", "Fighter",  "Protector", "Trailblazer", "Champion", "Leader"],
        "Jupiter": ["Philosopher", "Adventurer", "Optimist", "Benefactor", "Bestower of Blessings", "Believer"],
        "Saturn": ["Disciplinarian", "Elder", "Organizer", "Gatekeeper", "Judge", "Planner", "Organizer", "Provider", "Realist", "Rule Maker", "Taskmaster", "Traditionalist", "Toiler", "Authority"],
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

                                                      "Deep Thinker",
                                                      "Detective",
                                                      "Excavator",
                                                      "Extremist",

                                                      "Intensity Junkie",
                                                      "Occultist",
                                                      "Penetrator",
                                                      "Phoenix",
                                        
                                                      "Revealer"

                                                     ]]
    
    let signArrays: [String: [String]] = ["Aries": ["Warrior", "Fighter", "Pioneer", "Athlete"],
                                          "Taurus": ["Banker", "Collector", "Grounded Person"],
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
                                          "Leo": ["Aristocrat", "Champ", "Class Clown", "Comedian", "Creative", "Creator", "Diva", "Emcee", "Entertainer", "Force of Nature", "Gifted One", "Host", "Lion", "Performer", "Prima Donna", "Rock Star", "Artist", "Boss", "Celebrity", "Golden Child", "Icon", "Influencer", "Leader of the Pack",  "Powerhouse", "Royalty"],
                                          "Virgo": ["Servant", "Work in Progress", "Analyst", "Problem Solver", "Details Person", "Health Nut", "Purist", "Critic", "Practitioner", "Craftsperson", "Technician", "Librarian",  "Trainer", "Apprentice", "Coach", "Devotee", "Disciple", "Engineer", "Fixer", "Master-in-Training", "Mentor", "Perpetual Student", "Programmer",  "Self-Help Junkie"],
                                          "Libra": ["Peacemaker", "Diplomat", "Refiner", "Socialite", "Social Director", "Egalitarian", "Negotiator", "Matchmaker", "Artist", "Ambassador",  "Balancer", "Fashionista", "Connoisseur", "Beautifier", "Artist",  "Connoisseur", "Cosmopolitan", "Cultured One", "Decorator",  "Harmonizer", "Idealist", "Mediator", "Muse", "Social Butterfly", "Sophisticate", "Sweetheart", "Sympathizer", "Romanticizer",  "Adorer"],
                                          "Scorpio": ["Alchemist", "Brooder", "Confidante", "Dark One", "Deep Thinker", "Detective", "Excavator", "Extremist", "Goth", "Hospice Worker", "Hypnotist", "Intense One", "Lady of the Underworld", "Lord of the Underworld", "Occultist", "Penetrator", "Phoenix", "Provocateur", "Psychoanalyst", "Reformer", "Regenerist", "Revealer", "Secret-Keeper", "Shaman", "Sorcerer", "Survivor", "Taboo-Breaker", "Transformer", "Truth-Teller", "Undertaker", "Wounded Healer"],
                                          "Sagittarius": ["Traveler", "Philosopher", "Scholar", "Opinion Giver", "Risk-Taker", "Professional", "Seer", "Preacher", "Believer"],
                                          "Capricorn": ["Achiever", "Climber", "Grinder", "Boss", "Chief", "Consigliere", "Control Freak",  "Stoic", "Discipliner", "Executive", "Organizer", "Manifester", "Master",  "Old Soul", "Parent", "Planner", "Pragmatist", "Realist", "Rule-Follower", "Stoic", "Strategist", "Workaholic", "Taskmaster", "Traditionalist",  "Judge", "Authority"],
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
                                          "Pisces": ["Artist", "Bartender", "Chameleon",  "Dreamer", "Empath", "Enchanter", "Escapist",  "Idealist", "Magician", "Master Actor", "Meditator", "Medium", "Muse", "Mystic", "Partier", "Poet", "Ponderer", "Priest", "Priestess", "Psychic",   "Shapeshifter", "Spiritualist", "Visionary",  "Yogi", "Beach Bum",  "Intuitive", "Lightworker",  "Surrealist", "Transcendentalist", "Utopian", "Visionary Artist"]]
    let risingSignArrays: [String: [String]] = signArrays.mapValues { attributes in
        attributes.map { attribute in
            if let firstChar = attribute.first, "aeiouAEIOU".contains(firstChar) {
                return "an \(attribute.capitalizingFirstLetter())"
            } else {
                return "a \(attribute.capitalizingFirstLetter())"
            }
        }
    }

    print(risingSignArrays)


    
    // Randomly select adjectives and archetypes from arrays
    let adjective = adjectiveArrays[strongestPlanetSign]!.randomElement()!
    let planetArchetype = planetArrays[strongestPlanet]!.randomElement()!
    let sunArchetype = signArrays[sunSign]!.randomElement()!
    let moonArchetype = signArrays[moonSign]!.randomElement()!
    let risingArchetype = risingSignArrays[risingSign]!.randomElement()!
    
    // Construct and return sentence
    let sentence = "\(name) is \(adjective) \(planetArchetype), with the Spirit of the \(sunArchetype), and the soul of the \(moonArchetype), who acts like \(risingArchetype)."
    
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
