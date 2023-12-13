////
////  pp.swift
////  AstroLogic
////
////  Created by Errick Williams on 11/12/23.
////
//
//import Foundation
//
//
//// Dictionary to store aspect interpretations
//let aspectInterpretations: [String: String] = [
//    "Sun/Moon": "Interpretation for Sun/Moon aspect...",
//    "jupiter/sun": "Interpretation for Sun/Mercury aspect...",
//    // ... other interpretations
//]
//
//let sunMoonAspect2 = "Sun/Moon...Vitality, authority, and relations with the male sex influence, and are influenced by, the mental attitude, everyday affairs, and the female sex and common people. A harmonious aspect shows a stable mind, vigorous health, and favors from superiors and the common people. A discordant aspect shows a vigorous but dissatisfied mind, impaired health and difficulties from superiors and the common people. Pleasant thoughts of significance need to be cultivated in association with thoughts of domestic life and everyday affairs."
//
//let sunMercuryAspect2 = "As Mercury is never over 28 degrees from the Sun, the only aspects possible are conjunction, parallel and semisextile. Vitality, relation to authority, and relations with the male sex influence, and are influenced by, mental interests, facility and accuracy of expression, and cerebral activity. Pleasant thoughts of significance need to be cultivated in association with thoughts of intellectual expression."
//
//            let sunVenusAspect2 = "As Venus is never over 48 degrees from the Sun, the only aspects possible are conjunction, parallel, semisextile and semisquare. Vitality, authority and relations with the male sex influence, and are influenced by, the emotions, social relations and artistic appreciation. A harmonious aspect shows favors from superiors, good vitality, favors from the male sex, and success in affectional and social matters. A discordant aspect shows difficulties through these things. Pleasant thoughts of affection should be cultivated in association with thoughts of significance."
//
//            let sunMarsAspect2 = "Vitality, authority and the relations with the male sex influence, and are influenced by, strife, haste and undue expenditure of energy. Good vitality, strife with or over authority, and a tendency to rashness and accident are shown. A harmonious aspect shows success through strife. A discordant aspect shows loss through the strife, and greater tendency to accident or a surgical operation. Pleasant thoughts of domestic life and assisting the helpless should be substituted for thoughts of strife."
//
//            let sunJupiterAspect2 = "Vitality, authority and relations with the male sex influence, and are influenced by, abundance, optimism and joviality. A harmonious aspect shows good vitality and favors from people of power. A discordant aspect shows a tendency to egotism and extravagance. Pleasant thoughts relating to careful reasoning need to be associated with thoughts of good will and optimism."
//
//            let sunSaturnAspect2 = "Vitality, authority and relations with the male sex influence, and are influenced by, work, responsibility and economy or loss. A harmonious aspect shows gain through work, shouldering responsibility, and from elderly people. A discordant aspect shows loss and delays, and difficulty in work and through elderly people. Pleasant thoughts of significance, and pleasant thoughts of affection and social life need to be substituted for worry and anxiety."
//
//            let sunUranusAspect2 = "Vitality, authority and relations with the male sex influence, and are influenced by, sudden events, new acquaintances, and radical changes. A harmonious aspect shows unexpected advancement and gain through the sudden interests of others, and through unexpected events. A discordant aspect shows that new people entering the life influence it to disadvantage, and that sudden and unexpected events disrupt the plans. Pleasant thoughts of good will and optimism need to be associated with thoughts of things new and unusual."
//
//            let sunNeptuneAspect2 = "Vitality, authority and relations with the male sex influence, and are influenced by, the imagination, sensitivity and schemes. A harmonious aspect shows benefit through schemes and ideals. A discordant aspect shows vitality depleted through over sensitivity, and difficulties arising from believing in the schemes of others. Pleasant and positive thoughts of significance, and pleasant thoughts of labor and the realities of life, need to be associated with thoughts of the ideal."
//
//let sunPlutoAspect2 = "Vitality, authority and relations with the opposite sex influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows benefit and authority through group activity. A discordant aspect shows that groups or those in authority will endeavor to use coercion and underhanded methods to gain advantage over the individual. Pleasant and positive thoughts of courage in protecting the weak and helpless need to be associated with thoughts of groups and cooperation."
//
//
//
//
////        print("Sun \(sunMoonAspect!.symbol) Moon")
////        print("Moon \(moonSunAspect!.remainder) Sun")
//
//
//
//let moonMercuryAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, mental interests, facility or accuracy of expression and cerebral activity. A harmonious aspect gives a good brain and ability to express thoughts readily. A discordant aspect gives as ready expression, may even give brilliancy, but the brain is less stable and less able to withstand strain. Pleasant thoughts of good will and optimism need to be associated with thoughts of intellectual expression."
//
//let moonVenusAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, the emotions, social relations and artistic appreciation. A harmonious aspect favors these matters. A discordant aspect brings difficulties through them. In a female chart it shows difficulty with the monthly cycles. Pleasant thoughts of affection need to be associated with all thoughts of domestic life."
//
//let moonMarsAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, strife, haste and undue expenditure of energy. A harmonious aspect gives courage and ability to gain through strife. A discordant aspect shows difficulty through strife, strife in the domestic life, trouble through women, and a predisposition to eye trouble. Pleasant thoughts of protecting the helpless need to be associated with thoughts of domestic life."
//
//        let moonJupiterAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, abundance, optimism and joviality. A harmonious aspect shows favors from women and the common people. A discordant aspect shows unfounded optimism that leads into ventures that are unsound. Pleasant thoughts of careful reasoning need to be associated with thoughts of optimism and abundance."
//
//        let moonSaturnAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, work, responsibility, and economy or loss. A harmonious aspect shows system, order, and ability to carry responsibility. A discordant aspect shows loss through women and through the mental attitude of fear and anxiety, and a predisposition to ear trouble. Pleasant thoughts of significance and pleasant thoughts of affection and social life need to be substituted for worry and anxiety."
//
//        let moonUranusAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, sudden events, new acquaintances and radical changes. A harmonious aspect brings unexpected advancement through these things. A discordant aspect shows that new people, sudden events, women, and radical changes disrupt the domestic life. Pleasant thoughts of good will and optimism need to be associated with thoughts of the domestic life. "
//        let moonNeptuneAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, the imagination, sensitivity and schemes. A harmonious aspect shows benefit from schemes and women. A discordant aspect shows difficulties from over sensitivity, from women, in the domestic life, and through believing the schemes of others. Pleasant and positive thoughts of significance, and pleasant thoughts of labor and the realities of life need to be associated with thoughts of domestic life and the ideal."
//
//        let moonPlutoAspect2 = "Mental attitude, domestic life and everyday affairs influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows benefit through groups and cooperation. A discordant aspect shows that groups try to coerce and use underhanded methods to gain an advantage over the individual. Pleasant and positive thoughts of courage in protecting the weak and helpless need to be associated with thoughts of groups and cooperation. "
//
//        let mercuryVenusAspect2 = "Mental interests, facility or accuracy of expression and cerebral activity influence, and are influenced by, the emotions, social relations and artistic appreciation. A harmonious aspect shows benefit through intellectual activity and social relations, and some artistic talent. A discordant aspect shows equal artistic ability, but difficulties arising from the emotions and social relations. Pleasant thoughts of trusting in a higher power need to be associated with thoughts of intellectual expression."
//
//        let mercuryMarsAspect2 = "Mental interests, facility or accuracy of expression and cerebral activity influence, and are influenced by, strife, haste and undue expenditure of energy. A harmonious aspect shows mathematical ability and mental keenness. A discordant aspect shows as much mathematical ability and keenness, but a tendency toward hasty speech and quarrels. Pleasant thoughts of protecting the weak and helpless should be substituted for thoughts of antagonism."
//
//        let mercuryJupiterAspect2 = "Mental interests, facility or accuracy of expression and cerebral activity influence, and are influenced by, abundance, optimism and joviality. A harmonious aspect shows benefits from intellectual interests and philosophy. A discordant aspect shows impulsive conclusions resulting in difficulty. Pleasant thoughts of careful reasoning need to be associated with thoughts of philosophy and good will."
//
//        let mercurySaturnAspect2 = "Mental interests, facility or accuracy of expression and cerebral activity influence, and are influenced by, work, responsibility, and economy or loss. A harmonious aspect shows sound judgment, shrewdness, system and order. A discordant aspect shows loss through the mental attitude of anxiety and worry. Pleasant thoughts of significance and social life need to be substituted for worry and anxiety."
//
//        let mercuryUranusAspect2 = "Mental interests, facility or accuracy of expression and cerebral activity influence, and are influenced by, things very old or things very new, sudden events, radical changes, and new acquaintances. A harmonious aspect shows talent for research work, astrology and occultism, and ability to influence others. A discordant aspect shows the same ability and talent, but a tendency to be influenced detrimentally by others, and by abrupt action, radical ideas and an unstable nervous system. Pleasant thoughts of divine protection and care need to be associated with thoughts of new and original ideas."
//
//        let mercuryNeptuneAspect2 = "Mental interests, facility or accuracy of expression and cerebral activity influence, and are influenced by, the imagination, sensitivity, and schemes. A harmonious aspect shows benefit through dramatic talent, ideals, psychic impressions and through promotion enterprises. A discordant aspect gives equal dramatic talent, but shows difficulties arising from psychic impressions, over sensitivity, wishful thinking, and the schemes of others. Pleasant and positive thoughts of significance, and pleasant thoughts of labor and the realities of life need to be associated with thoughts of the visionary and ideal."
//
//        let mercuryPlutoAspect2 = "Mental interests, facility or accuracy of expression and cerebral activity influence, and are influenced by, groups, subtle force, and cooperation or coercion. A harmonious aspect shows ability to cooperate with others, to work with groups, and to tune in on inner-plane information and forces to advantage. A discordant aspect shows that groups will tend to coerce and to take undue advantage of the individual, and that even unseen forces may endeavor to control him. Pleasant and positive thoughts of courage in protecting the weak and helpless need to be associated with thoughts of groups and cooperation."
//
//
//        let venusMarsAspect2 = "Emotions, social relations and artistic appreciation influence, and are influenced by, strife, haste and undue expenditure of energy. Such an aspect shows creative ability and strong sexual proclivities. A harmonious aspect indicates pleasant and satisfactory conjugal expression, and attraction toward the opposite sex. A discordant aspect indicates difficulties arising from the conjugal relations, a predisposition toward diseases arising from sex or affecting the sexual organs, and violent emotions. Pleasant thoughts of helping the weak, helpless and unfortunate need to be substituted for thoughts of sex, strife and passion."
//
//        let venusJupiterAspect2 = "Emotions, social relations and artistic appreciation influence, and are influenced by, abundance, optimism and joviality. A harmonious aspect shows great benefit from social life and religion, through the favors of others, and in financial matters. A discordant aspect shows a predisposition to over indulgence and the squandering of money on pleasures. A tendency toward sensualism and living too much in the emotions is indicated. Pleasure should be cultivated in resisting the appetites and the impulses, and in using discrimination in all things. These thoughts should be associated with the effort to gain higher appreciation of art and beauty."
//
//        let venusSaturnAspect2 = "Emotions, social relations and artistic appreciation influence, and are influenced by, work, responsibility, and economy or loss. A harmonious aspect tends toward faithfulness; but also cools the passions, and may thus lessen pleasure in the conjugal relations. A discordant aspect shows loss and grief where the affections are concerned, and lack of pleasure in the conjugal relations. Pleasant thoughts of things beautiful, and of affectional expression, should be substituted for reticence, unresponsiveness and dissatisfaction."
//
//        let venusUranusAspect2 = "Emotions, social relations and artistic appreciation influence, and are influenced by, sudden events, new acquaintances, and abrupt changes. A harmonious aspect shows sudden attachments, affectional overtures by unusual individuals, and that the individual powerfully attracts others in a sexual way. A discordant aspect shows sudden attachments that are soon broken, a tendency toward unconventional conduct where the affections are involved, and abrupt breaking of affectional ties. Pleasant thoughts of trust and faith in a higher power need to be associated with thoughts of the affections."
//
//        let venusNeptuneAspect2 = "Emotions, social relations and artistic appreciation influence, and are influenced by, the imagination, sensitivity, and schemes. A harmonious aspect shows that there will be hope of finding the ideal mate, and of realizing ideal love relations. It indicates ability to dramatize in some form of art. A discordant aspect shows as much dramatic ability, but a tendency to be victimized through the affections, and of involvement through the affections. Thoughts of system, caution and practical foresight need to be associated with all thoughts of affection."
//
//        let venusPlutoAspect2 = "Emotions, social relations and artistic appreciation influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows possibility of attaining the highest form of union with the true mate, and of cooperating with groups in artistic endeavors or for benefiting society. A discordant aspect shows possibility of being exploited through the affections, and of being coerced by those who desire, for their own selfish purposes, to dominate the affections. Pleasant and positive thoughts of protecting the weak and helpless need to be associated with thoughts of the affections."
//
//
//        let marsJupiterAspect2 = "Strife, haste and undue expenditure of energy influence, and are influenced by, abundance, optimism and joviality. A harmonious aspect shows conviviality, but even so a tendency to spend too much time and energy on a good time. A discordant aspect shows a predisposition to squander both substance and energy, especially on sports and in showing others a good time. Excess in indulgence is indicated. Pleasant thoughts of intellectually appraising events, and of discrimination, should be substituted for thoughts of conviviality and sensual pleasures."
//
//        let marsSaturnAspect2 = "Strife, haste and undue expenditure of energy influence, and are influenced by, work, responsibility, and economy or loss. A harmonious aspect shows work and responsibility, with ability to do a tremendous amount of labor, and commensurate benefit from it and from carrying responsibility. A discordant aspect shows a tendency to rush enthusiastically into work, but quickly to crack under the strain. Also a predisposition to accidents or surgical operation. Pleasant thoughts of significance and of affectional matters need to be associated with thoughts of work and responsibility."
//
//        let marsUranusAspect2 = "Strife, haste, and undue expenditure of energy influence, and are influenced by, sudden events, people, and abrupt changes. A harmonious aspect shows inventiveness and mechanical ability. A discordant aspect shows equal inventiveness and mechanical ability, but also a tendency toward injury through accident. Such injuries occur through unusual circumstances that are difficult to foresee, and are due to the carelessness or the acts of other people. Pleasant thoughts of faith and trust in a higher power need to be associated with thoughts of originality and relating to mechanical work."
//
//        let marsNeptuneAspect2 = "Strife, haste, and undue expenditure of energy influence, and are influenced by, the imagination, sensitivity and schemes. A harmonious aspect shows a romantic nature and ability to promote whatever enterprise the individual is interested in. A discordant aspect shows a tendency to dissipation, to become involved through schemes, and an exaggerated opinion of what can be done. The health may suffer through drugs or poisons or psychic influences. Pleasant thoughts of assisting the weak and helpless, and pleasant thoughts of giving close attention to the practical problems of life should be substituted for schemes and wishful thinking."
//
//        let marsPlutoAspect2 = "Strife, haste, and undue expenditure of energy influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows ability to use extra-physical power, and to get groups to work for a common cause. A discordant aspect shows a tendency to be antagonized by groups, to be dominated by invisible influences, and to be coerced by groups for their own selfish advantage. Pleasant thoughts of initiative, courage and even combat to defend the rights of people should be substituted for thoughts of invisible forces and underhanded methods."
//
//
//        let jupiterSaturnAspect2 = "Abundance, optimism and joviality influence, and are influenced by, work, responsibility, and economy or loss. A harmonious aspect shows business ability of a high order, and power to attract money and worldly success. A discordant aspect shows that impulse impairs business ability, and that there will be periods of financial loss. Pleasant thoughts of discrimination and of appraising all situations from the facts at hand should be substituted for thoughts of careless optimism, and for worry, fear and anxiety."
//
//        let jupiterUranusAspect2 = "Abundance, optimism and joviality influence, and are influenced by, sudden events, new acquaintances and radical changes. A harmonious aspect shows money and exceptional good fortune through contacts with people, unexpected events and new methods. A discordant aspect shows financial difficulty and misfortune through being unduly influenced by people, and through unexpected events and original ideas. Pleasant thoughts of discrimination and intellectual appraisal need to be associated with thoughts of finances and optimism."
//
//        let jupiterNeptuneAspect2 = "Abundance, optimism and joviality influence, and are influenced by, the imagination, sensitivity and schemes. A harmonious aspect shows ability to handle financial promotions, and to make money through colonization schemes, stock selling, and the dramatization of financial possibilities. A discordant aspect shows ability to interest others in such ventures, but also difficulties arising from them. Pleasant thoughts of caution and the hard realities of each situation need to be substituted for wishful thinking and idealism."
//
//        let jupiterPlutoAspect2 = "Abundance, optimism and joviality influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows ability to gain financially and otherwise through cooperating with others and working with groups. A discordant aspect shows that financial and other difficulties will arise through the influence of groups, and in cooperative endeavors. Pleasant thoughts of discrimination and appraising all situations from the facts at hand should be associated with thoughts of groups and cooperation."
//
//
//
//        let saturnUranusAspect2 = "Work, responsibility, and economy or loss influence, and are influenced by, sudden events, new acquaintances, and radical changes. A harmonious aspect shows that new acquaintances, unexpected events, radical changes and original ideas favor the work, bring gains in responsibility, and contribute to economy. A discordant aspect shows that new acquaintances, unexpected events, and radical ideas hamper the work, make carrying responsibility difficult, and bring loss. Pleasant thoughts of affection and joy in art and social events need to be substituted for fear, worry and anxiety."
//
//        let saturnNeptuneAspect2 = "Work, responsibility, and economy or loss influence, and are influenced by, the imagination, sensitivity and schemes. A harmonious aspect shows that the schemes and ideals can be made practical, and that they bring gains in responsibility. A discordant aspect shows that the schemes and ideals hamper the practical progress of the work, make carrying responsibility difficult, and bring loss. Pleasant thoughts of significance, and pleasant thoughts of affection and joy in art and social events need to be substituted for fear, worry and anxiety."
//
//        let saturnPlutoAspect2 = "Work, responsibility, and economy or loss influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows that groups and cooperation or mass production can be made to aid the work and acquire important responsibility. A discordant aspect shows that groups, coercion and subtle force hamper the work, and make carrying responsibility difficult. Pleasant thoughts of aggressively assisting the weak and helpless need to be substituted for fear, worry and anxiety."
//
//        let uranusNeptuneAspect2 = "Sudden events, new acquaintances and radical changes influence, and are influenced by, the imagination, sensitivity and schemes. A harmonious aspect shows that the ideals and schemes are added to success through new acquaintances, sudden events and original ideas. A discordant aspect shows that the ideals and schemes are thwarted and disrupted by new acquaintances, sudden developments, and unexpected events. Pleasant thoughts of faith and trust in a higher power need to be associated with the ideals and schemes."
//
//        let uranusPlutoAspect2 = "Sudden events, new acquaintances and radical changes influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows that new acquaintances, sudden events and original ideas make it possible to gain through groups and cooperation. A discordant aspect shows that new acquaintances, sudden events and original ideas bring difficulty from groups, and coercion. Pleasant thoughts of faith and trust in a higher power need to be associated with thoughts of group activity and cooperation."
//
//        let neptunePlutoAspect2 = "The imagination, sensitivity and schemes influence, and are influenced by, groups, subtle force, and coercion or cooperation. A harmonious aspect shows that groups and cooperation assist in forwarding schemes and in realizing the ideals. A discordant aspect shows that the schemes and ideals will be thwarted by groups and will attract coercion. Pleasant thoughts of aggressively assisting the weak and helpless, and pleasant thoughts of power and significance, need to be associated with thoughts of the ideals. "
//
//let aspects2 = [sunMoonAspect2, sunMercuryAspect2, sunVenusAspect2, sunMarsAspect2,sunJupiterAspect2,sunSaturnAspect2,sunUranusAspect2,sunNeptuneAspect2,sunPlutoAspect2,moonMercuryAspect2,moonVenusAspect2,moonMarsAspect2,moonJupiterAspect2,moonSaturnAspect2,moonUranusAspect2,moonNeptuneAspect2,moonPlutoAspect2,mercuryVenusAspect2,mercuryMarsAspect2,mercuryJupiterAspect2,mercurySaturnAspect2,mercuryUranusAspect2,mercuryNeptuneAspect2,mercuryPlutoAspect2,venusMarsAspect2,venusJupiterAspect2,venusSaturnAspect2,venusUranusAspect2,venusNeptuneAspect2,venusPlutoAspect2,marsJupiterAspect2,marsSaturnAspect2,marsUranusAspect2,marsNeptuneAspect2,marsPlutoAspect2,jupiterSaturnAspect2,jupiterUranusAspect2,jupiterNeptuneAspect2,jupiterPlutoAspect2,saturnUranusAspect2,saturnNeptuneAspect2,saturnPlutoAspect2,uranusNeptuneAspect2,uranusNeptuneAspect2,uranusPlutoAspect2,neptunePlutoAspect2]
//
////            print(aspects2)
//
////        if sunHouse == 1 {
////            print("Sun in First House—With the Power thought cells expressing through the personality, vitality and ability to exercise authority are shown. In the constant struggle for significance the development and exercise of ability should be substituted for show and bragging.")
////        }
////            if moonHouse == 1 {
////                print("Moon in First House—With the Domestic thought cells expressing through the personality, fluctuation in health and personal affairs is shown. Domestic interests should be substituted for gossip.")
////            }
////            if mercuryHouse == 1 {
////                    print("Mercury in First House—With the Intellectual thought cells expressing through the personality, there is ability for speech, writing and study. A calling should be followed that requires brains.")
////
////            }
////            if venusHouse == 1 {
////                        print("Venus in First House—With the Social thought cells expressing through the personality, there is desire to please, and companionship is essential. Firmness should be cultivated; for it will please others.")
////            }
////            if marsHouse == 1 {
////                            print("Mars in First House—With the Aggressive thought cells expressing through the personality, mechanical ability and willingness to face danger are shown. Constructive activities should be substituted for those destructive.")
////            }
////        if jupiterHouse == 1 {
////            print("Jupiter in First House—With the Religious thought cells expressing through the personality, salesmanship and joviality are shown. These should be used to benefit all rather than to indulge self.")
////            }
////        if saturnHouse == 1 {
////            print("Saturn in First House—With the Safety thought cells expressing through the personality, persistence and shrewdness are shown. These used to benefit society will bring more honor and gain to self.")
////            }
////        if uranusHouse == 1 {
////            print("Uranus in First House—With the Individualistic thought cells expressing through the personality, originality is shown. Invention and reforms will give more satisfaction than eccentricity and unconventionality.")
////        }
////        if neptuneHouse == 1 {
////            print("Neptune in First House—With the Utopian thought cells expressing through the personality, idealism and sensitivity are shown. Willingness to work hard and think clearly to realize the ideals should be cultivated.")
////        }
////        if plutoHouse == 1 {
////            print ("Pluto in First House—With the Universal Welfare thought cells expressing through the personality, spiritual possibilities and ability to cooperate are shown. Effort to benefit all, rather than some group, will bring higher satisfaction.")
////        }
////
////
////        if sunHouse == 2 {
////            print("Sun in Second House—With the Power thought cells expressing through possessions, desire to attain significance through money is shown. It should be realized that true significance comes through benefiting society.")
////        }
////            if moonHouse == 2 {
////                print("Moon in Second House—With the Domestic thought cells expressing through possessions, fluctuating finances are shown. Aggressive effort to gain and use money to aid the helpless should be cultivated.")
////            }
////            if mercuryHouse == 2 {
////                    print("Mercury in Second House—With the Intellectual thought cells expressing through possessions, much thought about money is shown. Reliance also on a higher power should be cultivated.")
////
////            }
////            if venusHouse == 2 {
////                        print("Venus in Second House—With the Social thought cells expressing through possessions, money coming through little effort is shown. Friendships and kindness should be cultivated.")
////            }
////            if marsHouse == 2 {
////                            print("Mars in Second House—With the Aggressive thought cells expressing through possessions, strife over money and too free spending are shown. Spending only for that which is constructive and permanent should be cultivated.")
////            }
////            if jupiterHouse == 2 {
////                                print("Jupiter in Second House—With the Religious thought cells expressing through possessions, financial abundance is shown. Using it for philanthropic purposes will bring greatest satisfaction.")
////            }
////                if saturnHouse == 2 {
////                                    print("Saturn in Second House—With the Safety thought cells expressing through possessions, fear of financial want is shown. Careful planning and system should be substituted for worry and anxiety over money.")
////            }
////        if uranusHouse == 2 {
////            print("Uranus in Second House—With the Individualistic thought cells expressing through possessions, sudden gains and sudden losses are shown. Original ideas that will pay financial dividends should be sought.")
////        }
////        if neptuneHouse == 2 {
////            print(" Neptune in Second House—With the Utopian thought cells expressing through possessions, that money comes with little effort or not at all is shown. Practical ideas about finances should be substituted for wishful thinking.")
////        }
////        if plutoHouse == 2 {
////            print (" Pluto in Second House—With the Universal Welfare thought cells expressing through possessions, that money may be gained or lost through groups and cooperation is shown. The effort should be for the whole group to benefit.")
////        }
////
////
////
//////
//////        The thought cells mapped by the third house have been built by experiences relative to travel and relatives that cause them to express through thoughts, behavior and events attracted that influence brethren, private thoughts and studies, neighbors, writing, including correspondence, short journeys and education.
////        if sunHouse == 3 {
////            print("Sun in Third House—With the Power thought cells expressing through education, desire to gain significance through writing or travel is shown. Educational opportunities should be sought.")
////        }
////            if moonHouse == 3 {
////                print("Moon in Third House—With the Domestic thought cells expressing through education, travel and changing opinion are shown. Mental activity should be encouraged to greater thoroughness.")
////                      }
////
////                if mercuryHouse == 3 {
////                    print("Mercury in Third House—With the Intellectual thought cells expressing through education, writing and travel are shown. Ability to express in writing and talking should be cultivated.")
////                }
////        if venusHouse == 3 {
////        print("Venus in Third House—With the Social thought cells expressing through education, benefit from relatives and travel is shown. Companionship of relatives and neighbors should be cultivated.")
////        }
////
////            if marsHouse == 3 {
////        print("Mars in Third House—With the Aggressive thought cells expressing through education, danger in travel and strife with relatives are shown. Thoughts of helping the weak should be substituted for thoughts antagonistic.")
////            }
////        if jupiterHouse == 3 {
////        print("Jupiter in Third House—With the Religious thought cells expressing through education, benefit from travel and relatives is shown. The desire for clear thinking and study should be cultivated.")
////        }
////
////        if saturnHouse == 3 {
////        print("Saturn in Third House—With the Safety thought cells expressing through education, deep thinking and responsibility toward relatives are shown. Pleasure in social activities should be cultivated.")
////        }
////        if uranusHouse == 3 {
////            print("Uranus in Third House—With the Individualistic thought cells expressing through education, original thought, interest in things unusual, and sudden journeys are shown. Research should be cultivated.")
////                  }
////                  if neptuneHouse == 3 {
////            print("Neptune in Third House—With the Utopian thought cells expressing through education, pleasure trips and daydreaming are shown. Ability to appraise concrete realities should be cultivated.")
////                  }
////
////                  if plutoHouse == 3 {
////            print("Pluto in Third House—With the Universal Welfare thought cells expressing through education, cooperation with, or coercion by, relatives is shown. Educational advantages should be sought aggressively.")
////                  }
////
//////
//////        The thought cells mapped by the fourth house have been built by experiences relative to the home that cause them to express through thoughts, behavior and events attracted that influence the home, restaurants, the father, real estate, mining, crops on the ground, and conditions at the end of life.
////
////                  if sunHouse == 4 {
////        print("Sun in Fourth House—With the Power thought cells expressing through the home, desire to gain significance through the home and at the end of life is shown. Comfort for others rather than exercising authority should be sought in the domestic life.")
////                  }
////              if moonHouse == 4 {
////        print("Moon in Fourth House—With the Domestic thought cells expressing through the home, many changes in the home and in place of residence are shown. Aggressive effort to give domestic comfort to the helpless should be cultivated.")
////              }
////              if mercuryHouse == 4 {
////        print("Mercury in Fourth House—With the Intellectual thought cells expressing through the home, study in the home and at the end of life are shown. To make the home a place of comfort also should be cultivated.")
////
////              if venusHouse == 4 {
////        print(" Venus in Fourth House—With the Social thought cells expressing through the home, a pleasant and artistic home is shown. Making the home also useful should be cultivated.")
////        }
////              if marsHouse == 4 {
////        print("Mars in Fourth House—With the Aggressive thought cells expressing through the home, strife and accident in the home are shown. Making it a place of shelter and protection for the weak should be cultivated.")
////              }
////              if jupiterHouse == 4 {
////        print("Jupiter in Fourth House—With the Religious thought cells expressing through the home, abundance in the home is shown. Discrimination should be cultivated relative to home and domestic life.")
////              }
////              if saturnHouse == 4 {
////        print(" Saturn in Fourth House—With the safety thought cells expressing through the home, it will be a place of hard work and possibly of privation. Making it a pleasant place for social matters should be cultivated.")
////              }
////              if uranusHouse == 4 {
////        print("Uranus in Fourth House—With the Individualistic thought cells expressing through the home, many sudden changes in the domestic life are shown. The home should be used for spreading progressive ideas.")
////              }
////              if neptuneHouse == 4 {
////        print("Neptune in Fourth House—With the Utopian thought cells expressing through the home, a tendency to retire from the world is shown. Practical participation in world advancement should be cultivated.")
////              }
////              if plutoHouse == 4 {
////        print("Pluto in Fourth House—With the Universal Welfare thought cells expressing through the home, group activity in the home is shown. The home should be used for cooperative effort to benefit all.")
////              }
//////
//////        FIFTH HOUSE
//////        The thought cells mapped by the fifth house have been built by experiences relative to the offspring and pleasures that cause them to express through thoughts, behavior and events attracted that influence pleasures, love affairs, speculation, stocks and bonds, children and entertainment.
////
////              if sunHouse == 5 {
////        print("Sun in Fifth House—With the Power thought cells expressing through pleasures, desire to gain significance through children or entertainment is shown. Ability to entertain rather than show off should be cultivated.")
////              }
////              if moonHouse == 5 {
////        print("Moon in Fifth House—With the Domestic thought cells expressing through pleasures, changing love interests are shown. Aggressive determination to adapt rather than change the affections should be cultivated.")
////              }
////                  if mercuryHouse == 5 {
////
////        print("Mercury in Fifth House—With the Intellectual thought cells expressing through pleasure, much thought about affectional matters is shown. Joviality should be cultivated as an aid to affectional relations.")
////                  }
////
////              if venusHouse == 5 {
////
////        print("Venus in Fifth House—With the Social thought cells expressing through pleasure, there is strong attraction for the opposite sex. Steadfast loyalty to one should be cultivated.")
////
////              }
////              if marsHouse == 5 {
////
////        print("Mars in Fifth House—With the Aggressive thought cells expressing through pleasure, strife and perhaps danger through sports and love affairs are shown. Protection of the weak and helpless should be cultivated.")
////
////              }
////              if jupiterHouse == 5 {
////
////        print("Jupiter in Fifth House—With the Religious thought cells expressing through pleasure, fortune in speculation and games of chance is shown. Discrimination should be cultivated in reference to all pleasures.")
////              }
////
////              if saturnHouse == 5 {
////
////        print("Saturn in Fifth House—With the Safety thought cells expressing through pleasure, delay and disappointment due to children or the love life are shown. Pleasure in social activities should be cultivated.")
////              }
////              if uranusHouse == 5 {
////        print("Uranus in Fifth House—With the Individualistic thought cells expressing through pleasure, unusual attachments with the opposite sex are shown. Original methods of entertainment should be cultivated.")
////              }
////              if neptuneHouse == 5 {
////        print("Neptune in Fifth House—With the Utopian thought cells expressing through pleasure, unbounded faith in the one loved is shown. Practical experiences of others should be used as a guide in affectional matters.")
////              }
////              if plutoHouse == 5 {
////        print(" Pluto in Fifth House—With the Universal Welfare thought cells expressing through pleasure, finding pleasure with groups is shown. Cooperation in recreation and entertainment should be cultivated.")
////              }
////
//////        SIXTH HOUSE
//////        The thought cells mapped by the sixth house have been built by experiences relative to work and illness that cause them to express through thoughts, behavior and events attracted that influence labor, the condition under which work is done, tenants, foods, small animals, employees and the quality of their services, and illness.
////
////
////              if sunHouse == 6 {
////        print("Sun in Sixth House—With the Power thought cells expressing through work, much concern with health and work is shown. Knowledge of diet and thought to influence vitality and health should be gained and used.")
////              }
////              if moonHouse == 6 {
////        print("Moon in Sixth House—With the Domestic thought cells expressing through work, fluctuating health and many changes in employment are shown. Adaptability to work and working conditions to the end, of attaining stability of employment should be cultivated.")
////              }
////              if mercuryHouse == 6 {
////        print("Mercury in Sixth House—With the Intellectual thought cells expressing through work, thought about work and tendency to nerve disorders are shown. To work without much nervous tension should be cultivated.")
////              }
////              if venusHouse == 6 {
////        print("Venus in Sixth House—With the Social thought cells expressing through work, benefit through employees, especially those of the opposite sex, is shown. The lighter kinds of work should be sought.")
////              }
////              if marsHouse == 6 {
////        print("Mars in Sixth House—With the Aggressive thought cells expressing through work, strife with employees and inflammatory disorders are shown. Thoughts of helping the weak should be substituted for thoughts antagonistic.")
////              }
////              if jupiterHouse == 6 {
////        print("Jupiter in Sixth House—With the Jupiter thought cells expressing through work, excellent service from employees is shown. Taste for a well-balanced diet rather than for rich foods should be cultivated.")
////
////
////
////              }
////              if saturnHouse == 6 {
////        print("Saturn in Sixth House—With the Safety thought cells expressing through work, hard work and deficient diet are shown. Taste for variety in foods and those containing the minerals and vitamins should be cultivated.")
////              }
////              if uranusHouse == 6 {
////        print("Uranus in Sixth House—With the Individualistic thought cells expressing through work, unusual methods in work, and diseases difficult to diagnose are shown. High nervous tension should be avoided.")
////              }
////              if neptuneHouse == 6 {
////        print("Neptune in Sixth House—With the Utopian thought cells expressing through work, impractical employees and disorders due to sensitivity are shown. A feeling of positiveness should be cultivated.")
////              }
////              if plutoHouse == 6 {
////        print("Pluto in Sixth House—With the Universal Welfare thought cells expressing through work, working with groups is shown. Ability to cooperate should be cultivated.")
////              }
//////
//////        SEVENTH HOUSE
//////        The thought cells mapped by the seventh house have been built by experiences relative to union that cause them to express through thoughts, behavior and events attracted that influence marriage, partnership, the attitude of those met in public, open enemies, competitors and law suits.
////
////              if sunHouse == 7 {
////                  print("Sun in Seventh House—With the Power thought cells expressing through partnership, significance through marriage or partnership is shown. Marriage should be for love and harmony rather than for gain of power.")
////                        }
////if moonHouse == 7 {
////                      print("Moon in Seventh House—With the Domestic thought cells expressing through partnership, contacting many people is shown. Ability to serve the public well should be cultivated.")
////                            }
////            if mercuryHouse == 7 {
////                          print("Mercury in Seventh House—With the Mercury thought cells expressing through partnership, marriage to a person of intellectual interests is shown. Ability to speak and write should be cultivated.")
////                                }
////        if venusHouse == 7 {
////            print("Venus in Seventh House—With the Social thought cells expressing through partnership, harmony in marriage is shown. Artistic appreciation should be cultivated for practical ends.")
////                                    }
////        if marsHouse == 7 {
////        print("Mars in Seventh House—With the Aggressive thought cells expressing through partnership, law suits and strife with partners and the public are shown. Constructive efforts should be substituted for enmities.")
////
////                                        }
////            if jupiterHouse == 7 {
////                print("Jupiter in Seventh House—With the Religious thought cells expressing through partnership, wealth or other benefits through marriage is shown. Discrimination in selecting a partner should be cultivated.")
////
////
////                                            }
////                  if saturnHouse == 7 {
////                print("Saturn in Seventh House—With the Safety thought cells expressing through partnership, heavy responsibility or loss through marriage, and trouble with the public are shown. Pleasure in social activities should be cultivated.")
////
////                  }
////if uranusHouse == 7 {
////                      print("Uranus in Seventh House—With the Individualistic thought cells expressing through partnership, an unusual marriage or one ending in separation is shown. Tolerance of the opinions of others should be cultivated.")
////
////}
////if neptuneHouse == 7 {
////                      print("Neptune in Seventh House—With the Utopian thought cells expressing through partnership, an ideal marriage, marriage to one impractical, or involvement through partnership is shown. Ability to appraise others realistically should be cultivated.")
////}
////
////                  if plutoHouse == 7 {
////
////       print("Pluto in Seventh House—With the Universal Welfare thought cells expressing through partnership, association with groups is shown. Ability to cooperate with others for the good of all should be cultivated.")
////
////                  }
//////        EIGHTH HOUSE
//////        The thought cells mapped by the eighth house have been built by experiences relative to death that cause them to express through thoughts, behavior and events attracted that influence gifts and legacies, the public’s money, ability of those owing to pay, death and the influence of those dead.
////
////if sunHouse == 8 {
////
////                      print("Sun in Eighth House—With the Power thought cells expressing through inheritance, significance of inheritance in the life is shown. Dependence on individual effort, rather than on inheritance, should be cultivated.")
////
////}
////if moonHouse == 8 {
////                      print("Moon in Eighth House—With the Domestic thought cells expressing through inheritance, death affecting the life numerous times is shown. Aggressive effort to preserve life and people’s money should be made.")
////}
////if mercuryHouse == 8 {
////
////                      print("Mercury in Eight House—With the Intellectual thought cells expressing through inheritance, much thought about death and other’s money is shown. Faith in a higher power to protect should be cultivated.")
////
////}
////if venusHouse == 8 {
////                      print("Venus in Eighth House—With the Social thought cells expressing through inheritance, benefit through gifts and inheritance is shown. Friendships should be widely cultivated.")
////
////}
////if marsHouse == 8 {
////                      print("Mars in Eighth House—With the Aggressive thought cells expressing through inheritance, danger of violent death, and strife over debts and inheritance are shown. Both borrowing and lending should be discouraged.")
////}
////if jupiterHouse == 8 {
////
////                      print("Jupiter in Eighth House—With the Religious thought cells expressing through inheritance, abundance through gifts and inheritance is shown. Business can safely be run on a credit basis.")
////}
////if saturnHouse == 8 {
////
////                      print("Saturn in Eighth House—With the Safety thought cells expressing through inheritance, loss through death and through inability of others to pay is shown. Financial credit should seldom be extended to others.")
////}
////if uranusHouse == 8 {
////
////                      print("Uranus in Eighth House—With the Individualistic thought cells expressing through inheritance, the sudden death of others will affect the life profoundly. Faith in a higher power to protect should be cultivated.")
////}
////if neptuneHouse == 8 {
////
////                      print("Neptune in Eighth House—With the Utopian thought cells expressing through inheritance, involvement through inheritance or psychic matters is shown. Dependence should not be placed on the money of others.")
////
////}
////if plutoHouse == 8 {
////                      print("Pluto in Eighth House—With the Universal Welfare thought cells expressing through inheritance, group deaths affecting the life are shown. Cooperation in handling the finances of others should be cultivated.")
////}
////
//////        NINTH HOUSE
//////        The thought cells mapped by the ninth house have been built by experiences relative to journeys that cause them to express through thoughts, behavior and events attracted that influence teaching, publishing, advertising, lecturing, long journeys, religion and the court.
////
////
////if sunHouse == 9 {
////                      print("Sun in Ninth House—With the Power thought cells expressing through philosophy, that significance is sought through publicly expressed opinions is shown. Sound opinions should be sought.")
////}
////if moonHouse == 9 {
////
////                      print("Moon in Ninth House—With the Domestic thought cells expressing through philosophy, much travel or expression of ideas is shown. Consistency of ideas expressed publicly should be sought.")
////
////}
////if mercuryHouse == 9 {
////                      print("Mercury in Ninth House—With the Intellectual thought cells expressing through philosophy, ability to get ideas before the public is shown. This ability should be used to get beneficial ideas before the public.")
////
////}
////if venusHouse == 9 {
////                      print(" Venus in Ninth House—With the Social thought cells expressing through philosophy, benefit through publicly expressed ideas or travel is shown. Artistic expression of ideas should be cultivated.")
////
////}
////if marsHouse == 9 {
////
////                      print("Mars in Ninth House—With the Aggressive thought cells expressing through philosophy, strife over religion and opinions is shown. Thoughts presented constructively should be substituted for attacks on the opinions of others.")
////}
////if jupiterHouse == 9 {
////
////                      print("Jupiter in Ninth House—With the Religious thought cells expressing through philosophy, benefit through publishing, religion or travel is shown. Discrimination in religion and expressing opinions should be cultivated.")
////
////}
////if saturnHouse == 9 {
////                      print("Saturn in Ninth House—With the Safety thought cells expressing through philosophy, conservative ideas are shown. Social pleasures should be substituted for opinions based on discipline and fear.")
////}
////if uranusHouse == 9 {
////                      print("Uranus in Ninth House—With the Individualistic thought cells expressing through philosophy, unusual ideas, or unusual methods in expressing ideas, are shown. Originality rather than eccentricity of expression should be cultivated.")
////}
////if neptuneHouse == 9 {
////
////                      print("Neptune in Ninth House—With the Utopian thought cells expressing through philosophy, idealistic opinions are shown. Ability to get the ideals before the public should be cultivated.")
////
////}
////if plutoHouse == 9 {
////                      print("Pluto in Ninth House—With the Universal Welfare thought cells expressing through philosophy, coercion or cooperation because of opinions expressed is shown. Spiritual opinions should be cultivated.")
////
////}
//////        TENTH HOUSE
//////        The thought cells mapped by the tenth house have been built by experiences relative to credit that cause them to express through thoughts, behavior and events attracted that influence honor, business, credit, profession and superiors.
////
////
////if sunHouse == 10 {
////                      print("Sun in Tenth House—With the Power thought cells expressing through honor, significance is sought through business or politics. Ability to exercise authority wisely should be cultivated.")
////}
////if moonHouse == 10 {
////
////                      print("Moon in Tenth House—With the Domestic thought cells expressing through honor, wide publicity for the individual is shown. Aggressive actions for the benefit of the weak and helpless should be cultivated.")
////}
////if mercuryHouse == 10 {
////
////                      print("Mercury in Tenth House—With the Intellectual thought cells expressing through honor, a business requiring brains is shown. Faith also in a higher power to benefit should be cultivated.")
////
////}
////if venusHouse == 10 {
////                      print("Venus in Tenth House—With the Social thought cells expressing through honor, the good opinion of others is shown. Artistic and refined methods in business should be cultivated.")
////}
////if marsHouse == 10 {
////
////                      print("Mars in Tenth House—With the Aggressive thought cells expressing through honor, much criticism of the individual is shown. Protecting the weak and helpless should be cultivated.")
////
////
////}
////if jupiterHouse == 10 {
////                      print("Jupiter in Tenth House—With the Religious thought cells expressing through honor, honors and high credit are shown. Discrimination in all business transactions should be cultivated.")
////}
////if saturnHouse == 10 {
////
////                      print("Saturn in Tenth House—With the Safety thought cells expressing through honor, vast ambition and much responsibility are shown. System and organization that will benefit many, instead of merely self, should be cultivated.")
////}
////if uranusHouse == 10 {
////
////                      print("Uranus in Tenth House—With the Individualistic thought cells expressing through honor, original methods in business and sudden changes in fortune are shown. Unusual methods that are valuable, rather than those that merely are different, should be sought.")
////}
////if neptuneHouse == 10 {
////
////                      print("Neptune in Tenth House—With the Utopian thought cells expressing through honor, ability to promote is shown. Things of true practical value to promote should be sought.")
////}
////if plutoHouse == 10 {
////
////                      print("Pluto in Tenth House—With the Universal Welfare thought cells expressing through honor, credit or discredit through cooperation or coercion is shown. Cooperation for spiritual welfare should be cultivated.")
////
////}
////
////
//////        ELEVENTH HOUSE
//////        The thought cells mapped by the eleventh house have been built by experiences relative to hopes and associates that cause them to express through thoughts, behavior and events attracted that influence friends, hopes and wishes.
////
////
////              if sunHouse == 11 {
////                      print("Sun in Eleventh House—With the Power thought cells expressing through friends, that realizing hopes of significance depends on friends is shown. Friends of power and authority should be cultivated.")
////
////              }
////              if moonHouse == 11 {
////                      print("Moon in Eleventh House—With the Domestic thought cells expressing through friends, friends among the common people are shown. Aggressive effort should be made to realize the hopes, rather than merely dreaming of their realization.")
////              }
////              if mercuryHouse == 11 {
////
////                      print("Mercury in Eleventh House—With the Intellectual thought cells expressing through friends, friends among literary people are shown. Faith in a higher power, as well as intelligence, should be cultivated in the effort to realize the hopes.")
////              }
////              if venusHouse == 11 {
////
////                      print("Venus in Eleventh House—With the Social thought cells expressing through friends, artistic friends and friends who will favor in many ways are shown. A positive attitude, and a study of practical methods, should be used in the effort to realize the hopes.")
////              }
////              if jupiterHouse == 11 {
////
////                      print("Mars in Eleventh House—With the Aggressive thought cells expressing through friends, quarrels with friends, and friends, who become enemies are shown. Constructive thoughts and actions should be substituted for irritation and antagonism in attempting to realize the hopes.")
////
////
////              }
////              if jupiterHouse == 11 {
////                      print("Jupiter in Eleventh House—With the Religious thought cells expressing through friends, friends of wealth, and friends who will go a long way to help, are shown. Discrimination in the selection of friends and associates should be cultivated.")
////              }
////              if saturnHouse == 11 {
////                      print("Saturn in Eleventh House—With the Safety thought cells expressing through friends, elderly friends, serious friends, and possible loss through friends are shown. Too much dependence should not be placed on the unselfish motives of friends.")
////
////              }
////              if uranusHouse == 11 {
////                      print("Uranus in Eleventh House—With the Individualistic thought cells expressing through friends, eccentric, unusual or astrological friends are shown. Faith in a higher power to assist in realizing the hopes should be cultivated.")
////              }
////                  if neptuneHouse == 11 {
////                      print("Neptune in Eleventh House—With the Utopian thought cells expressing through friends, idealistic, impractical or psychic friends are shown. Too much dependence should not be placed upon the soundness of the advice offered by friends.")
////
////              }
////              if plutoHouse == 11 {
////                      print("Pluto in Eleventh House—With the Universal Welfare thought cells expressing through friends, spiritual friends or gangster friends are shown. Spiritual aspirations and groups should be cultivated in the effort to realize the hopes.")
////              }
////
//////        TWELFTH HOUSE
//////        The thought cells mapped by the twelfth house have been built by experiences with hidden enemies and disappointments that cause them to express through thoughts, behavior and events attracted that influence crime, sorrows, disappointments, restrictions, hidden enemies, large animals, unseen forces and astral entities.
////
////
////              if sunHouse == 12 {
////                      print("Sun in Twelfth House—With the Power thought cells expressing through disappointment, powerful secret enemies and heavy disappointments are shown. The use of power and authority, not to gain personal glory and advantage, but to relieve distress is the best avenue to significance.")
////
////              }
////              if moonHouse == 12 {
////                      print("Moon in Twelfth House—With the Domestic thought cells expressing through disappointment, many minor disappointments, and the secret enmity of women are shown. Aggressive measures to remove the restrictions and alleviate the distress of the common people should be cultivated.")
////
////              }
////              if mercuryHouse == 12 {
////                      print("Mercury in Twelfth House—With the Intellectual thought cells expressing through disappointment, much thought about sorrow and hidden enemies is shown. Faith in a higher power to remove restrictions and prevent sorrow should be cultivated.")
////              }
////              if venusHouse == 12 {
////
////                      print("Venus in Twelfth House—With the Social thought cells expressing through disappointment, sorrows through the affections are shown. There should be practical work to assist those in distress and to contribute to the welfare of the needy.")
////
////              }
////              if marsHouse == 12 {
////
////                                                  print("Mars in Twelfth House—With the Aggressive thought cells expressing through disappointment, injury from secret enemies and a tendency toward hospitalization are shown. Aggressive effort to protect the weak and helpless and alleviate their suffering should be cultivated.")
////
////              }
////              if jupiterHouse == 12 {
////                                                  print("Jupiter in Twelfth House—With the Religious thought cells expressing through disappointment, benefit rather than injury from the efforts of secret enemies is shown. Discrimination should be cultivated in the effort to alleviate the distress of others.")
////
////              }
////              if saturnHouse == 12 {
////                                                  print("Saturn in Twelfth House—With the Safety thought cells expressing through disappointment, secret sorrows, heavy restrictions and crafty secret enemies are shown. Pleasure in social activities that tend to benefit those in distress should be cultivated.")
////              }
////              if uranusHouse == 12 {
////
////                                                  print("Uranus in Twelfth House—With the Individualistic thought cells expressing through disappointment, disappointments due to unexpected events or peculiar people are shown. Faith in a higher power to remove restrictions and prevent sorrow should be cultivated.")
////
////              }
////              if neptuneHouse == 12 {
////                                                  print("Neptune in Twelfth House—With the Utopian thought cells expressing through disappointment, peculiar restrictions and injury through psychic forces or psychic people are shown. Practical efforts to relieve the distress of others should be cultivated.")
////              }
////              if plutoHouse == 12 {
////
////                                                  print("Pluto in Twelfth House—With the Universal Welfare thought cells expressing through disappointment, the action of groups and those who endeavor to coerce are shown to bring sorrow. Cooperation with others in the effort to relieve the suffering of those in distress should be cultivated.")
////
//
//
//
//
////                  SUN
////                  The thought cells mapped by the Sun are the seat of the individuality. They have been organized by those experiences in lower life forms that express the Drive for Significance, including tenacity to life. They govern the positive, electric energy of the electromagnetic form. On their degree of activity, and their harmony, depend the ability to withstand illness and to recuperate. Length of life is measured by their power relative to the afflictions shown by groups of thought cells mapped by discordant planets. Any aspect of Mars to the Sun, or a harmonious aspect of Jupiter to the Sun, tends markedly to lengthen the life through increasing their power.
////                  Because their chief expression is toward gaining and maintaining significance, and their activity strongly influences the relation of the individual to those in authority, as well as influencing his authority over others, they are called POWER thought cells. The thought
////
////                  elements of which they are composed are the most deep seated and persistent of all. To the extent these thought cells are active is the life influenced by thoughts of pride, firmness, approbation, conscientiousness or self esteem.
////                  Aspects to the Sun affect the vitality, the relation to authority, and relations with the male sex. Only those with a prominent birth-chart Sun become successful as politicians or successful in personally directing the efforts of others. Discordant aspects to the Sun tend toward difficulties with those in authority, or difficulties arising from attempts to exercise authority.
////
//
////                  When the Sun is prominent in the birth chart the individual seeks to be at the head of something, and seldom works to advantage unless given full charge of his work or department.
////                  When the Sun is prominent and afflicted the individual may think he is entitled to exercise authority for which he is completely unsuited. And to increase his feeling of significance, he may brag and be egotistical. Therefore, as early as possible he should realize that the RULERSHIP which he craves cannot be attained through bragging or DICTATIVENESS. It can only be attained through acquiring and using abilities that command admiration, and gaining the cooperation of others through a sympathetic consideration of their views and problems.
//
//
////    if natal_sunCoordinate.sign.name == "Aries" {
////                  print("The Power thought cells of the individual born in Aries, where the Sun may be found each year from March 21 to April 21, have been associated with, and desire to express through, the I AM attitude. Even as the Ram, which pictures among the constellations the influence of this sign, is combative, uses his head in offensive, and is the leader of his flock, so Aries people require the zest of competition, feel the need for combat, and always strive for personal leadership.   The Sun in Aries marks the birth of spring, and all the world seems new to an Aries individual. He is extremely optimistic, and this often leads him into undertakings that are more than he can manage. One of several things he should avoid is having too many irons in the fire at once. The same inherent enthusiasm easily leads him to rush into controversy before he has thoroughly examined all the evidence. And once he thus espouses a cause he is reluctant to admit himself wrong. Rash in love, bright and lively in conversation, he takes to politics; for in it leadership plays an important part. Whether working constructively or destructively he uses creative power and original thought, employing his brain to gain his ends. In business he is apt to overwork.    When the Sun is afflicted, his desire for LEADERSHIP, which is his own proper field, may cause him to make two mistakes. One, already mentioned, is to diffuse his energies, trying to take in too much territory. The other is to develop OFFICIOUSNESS, and an inclination to interfere unduly in the affairs of others. The sooner he learns that people resent being bossed about and told how to do things they already are doing well, and that example and kindly advice when it is asked gain him the leadership he craves, the more successful will his life become.")
////                  }
////
////                  if natal_sunCoordinate.sign.name == "Taurus" {
////                    print("The Power thought cells of the individual born in Taurus, where the Sun may be found each year from April 21 to May 21, have been associated with, and desire to express through, the I HAVE attitude. Even as the Bull, which pictures among the constellations the influence of this sign, is slow moving, plodding and self reliant, but excessively violent when provoked to anger, so are Taurus people quiet and thoughtful, patiently awaiting for plans to mature. Remarkable for endurance, industry and application, they sometimes become sullen and reserved. Slow to irritation, when once aroused they are furious and violent. They make warm friends and implacable foes.   The Taurus individual thinks largely in terms of money. He is neither more acquisitive nor more liberal than other signs, but he likes to handle money, and to use money for whatever purposes he has in mind. Obedient to his employer, and very persistent in all he undertakes, he does not possess the initiative for new undertakings, nor the courage to take great risks.   When the Sun is afflicted, his desire for STABILITY may cause him to follow a set routine in the performance of his tasks, and very much dislike to change his methods in any way. He is thorough in all he undertakes, and can neither be hurried nor frightened from his deliberate pace. Carried to the extreme this inflexibility may express as OBSTINACY. The earlier in life he forms the habit of being steadfast for truth and justice the more successful will he become; for a recognition of these will permit him to change and to give way when he perceives he is in the wrong.")
////                  }
////
////                  if natal_sunCoordinate.sign.name == "Gemini" {
////            print("The Power thought cells of the individual born in Gemini, where the Sun may be found each year from May 21 to June 22, have been associated with, and desire to express through, the I THINK attitude. Even as the Twins, which picture among the constellations the influence of this sign, are human and dual, so Gemini people like to talk and study and teach, in a manner characteristic of those who have developed both reason and intuition. They are versatile and changeable and able to do more than one thing at a time.   The Gemini individual has a very active brain and is at his best when his intellect has full scope for work. He is restless, and must constantly express himself in some way, and may talk so much about unimportant details that important information is obscured. He has remarkable dexterity, and can do any number of things well.   In his desire for VERSATILITY he may try many occupations, and he can follow so many different ones with little effort that he frequently does not stick to any of them long enough to make a marked success of it. It is unnecessary for him to endure disagreeable things in one occupation, because he can always get a job doing something else.   When the Sun is afflicted, this may lead to CHANGEABLENESS, not merely in reference to jobs, but relative to his point of view, his likes and dislikes, and even may include friendships and domestic partners. For greatest success, therefore, he should early realize that any one task can be made worthy of all his ingenuity and talent, and that instead of changing his occupation, or his domestic partner and friends, he should change his methods, and strive thus for greater and greater perfection.")
////                  }
////
////                  if natal_sunCoordinate.sign.name == "Cancer" {
////            print("The Power thought cells of the individual born in Cancer, where the Sun may be found each year from June 22 to July 23, have been associated with, and desire to express through, the I FEEL attitude. Even as the Crab, which pictures among the constellations the influence of this sign, is influenced by the tides and the moon, and is sensitive to its environment and tenacious of purpose, so Cancer people are powerfully influenced by their environment, are sensitive and mediumistic, are subject to moods, and have tremendous tenacity. And in their approach to their work, while their method gives as good results as any, they are apt to commence in a manner that those of other signs consider oblique, even as the Crab has a side-long gait.   The Cancer individual, while he may love travel, is exceptionally fond of, and attached to, his home and family. He is emotional, and above all else craves sympathy. As he tends to absorb all the conditions he contacts, he should choose his associates and his domestic environment with special care.   When the Sun is afflicted, his fear of ridicule may be so powerful and distressing as to prevent him properly asserting himself, and he may fancy he has been slighted where no offense was meant. He too easily becomes upset at hearing unpleasant news, and exhibits TOUCHINESS. Instead, he should as early as possible absorb the idea that people in general are sympathetic and friendly, and that those who are otherwise are not worth bothering about. When he makes this thought a part of himself he will no longer refuse to accept, when they are presented, the very opportunities which he desires; for when he has an idea, a friend, or a purpose, he holds to it with the utmost TENACITY.")
////                  }
////
////
////                  if natal_sunCoordinate.sign.name == "Leo" {
////                print("The Power thought cells of the individual born in Leo, where the Sun may be found each year from July 23 to August 23, have been associated with, and desire to express through, the I WILL attitude. Even as the Lion, which pictures among the constellations the influence of this sign, is the king of beasts, is noted for its courage, and is especially solicitous of its offspring, so Leo people aspire to rule, are courageous, fond of their children and will defend them regardless of the cost.   The Leo individual tends to be honest, magnanimous, generous to his friends, impulsive, passionate, faithful and ambitious. His ideas usually are on a large scale, and he seldom stoops to pettiness or meanness. He is fond of entertainment and mixing with his friends, and must have affection, admiration and worldly acclaim to be happy. He has faith and trust in other people, and these usually respond to his faith by trying to live up to his expectations. He is good at deputizing work, not demanding of his subordinates that which is impossible.    When the Sun is afflicted, his desire for significance may lead him to overdress, and to become a showoff. He then goes to great pains to have a better car, a finer house, and to entertain more lavishly than others in his social set. It is true that he is better at directing the efforts of others than in taking orders. But also he readily can believe he should have a position of importance far beyond any he is capable of properly filling. His craving for a position of authority and for personal notice may develop into a tendency toward DOMINATION. He should, therefore, as early as possible realize that KINDNESS will advance him toward the glory he craves, even if its exercise calls for the performance of menial tasks, much faster than the arbitrary issuing of orders.")
////                      }
////
////
////                      if natal_sunCoordinate.sign.name == "Virgo" {
////                print("The Power thought cells of the individual born in Virgo, where the Sun may be found each year from August 23 to September 23, have been associated with, and desire to express through, the I ANALYZE attitude. Even as the Virgin—a gleaning maid holding in her hand ears of wheat—which pictures among the constellations the influence of this sign, is modest and industrious in gathering her harvest, so Virgo people are thoughtful, serious, contemplative, modest, industrious, and have the ability to assimilate experience and facts in such a way as to reap a rich harvest of knowledge. Always ready to suggest improvements in existing methods, some of them become veritable encyclopedias of information.   The Virgo individual loves to deal with facts rather than with theories. Statistics appeal to him. He takes orders readily and uses ingenuity and originality in carrying them out. He is clever at accountancy, and makes a good public servant. He is a master of detail, and his ability to think straight may take him into the scientific field, or make him exceptionally valuable to executives who do planning; for he can dissect a proposition of any kind and find its weaknesses and determine how these can be strengthened. He lives so completely in the intellectual realm that often it narrows the range of his emotions.   When the Sun is afflicted, his desire for ANALYSIS may cause him to be unsympathetic, to be overly fastidious, seldom to praise, but often to find fault, with others. The earlier he realizes that it takes just as keen discrimination to find and stress the good points in people and things, and is far more profitable than indulging in CRITICISM, the more benefits he will receive from life.")
////                      }
////
////
////                      if natal_sunCoordinate.sign.name == "Libra" {
////                print("The Power thought cells of the individual born in Libra, where the Sun may be found each year from September 23 to October 23, have been associated with, and desire to express through, the I BALANCE attitude. Even as the Scales, which pictures among the constellations the influence of this sign, are easily tipped either way, but regain equilibrium as soon as the weight is removed, so are Libra people for a moment easily swayed by their emotions, but quickly regain their balance. And even as the Scales are the symbol of justice, so are these people devoted to justice.   The Libra individual is a lover of peace and harmony, is amiable, even tempered, affectionate, sympathetic, and inclined toward marriage. He is fond of art, refined pleasures and amusements, dislikes unclean work intensely, and feels the need of a companion to share his lot in life. He loves perfection, craves understanding, and as a rule should not live an isolated life, but follow his social inclinations. He is polished and gracious, and inclined to make a living through the easier methods than through those more strenuous. Ugliness, strife, discord and coarseness distress him painfully.   When the Sun is afflicted, his desire for APPROBATION may cause him to sanction the questionable conduct of others, and to be led by them into actions which of his own initiative he would never take. Also, instead of specializing in some single direction, and hence gaining high efficiency, his sense of proportion may influence him to dabble in many things. His occupation should be something in which he contacts others personally and can capitalize on AFFABILITY. And the sooner he realizes that people will like him better when they find he has sufficient character to render firm decisions uninfluenced by flattery, the sooner he will gain his desires.")
////                      }
////
////
////                      if natal_sunCoordinate.sign.name == "Scorpio" {
////                print("The Power thought cells of the individual born in Scorpio, where the Sun may be found each year from October 23 to November 22, have been associated with, and desire to express through, the I DESIRE attitude. Even as the Scorpion, which pictures among the constellations the influence of this sign, is intense in its sexual propensities, is secretive in habit, is cruel and subtle, is a fighter, and uses a weapon which is not suspected by its opponent, so are Scorpio people suspicious, shrewd, determined, secretive, energetic and good fighters, at times using indirect, but effective methods in attacking their opponents. In their sexual nature they are intense and given to jealousy.   The Scorpio individual is thoughtful, contemplative, ingenious and scientific. He is strong in his likes and dislikes, and whatever he finds to do he does with his whole might. He possesses a natural healing magnetism, and is never at a loss for plans by which difficulties may be overcome. He can be trusted to grapple with the most difficult and disagreeable tasks. Usually he knows what he wants from life, and works energetically to get it.    When the Sun is afflicted, his strong sense of duty, or his cold, calculating and deceitful cruelty towards those he dislikes, may give rise to TROUBLESOMENESS. The earlier he realizes that his advantage is in concentrating his RESOURCEFULNESS on his own problems and in helping, rather than hindering others, the sooner he will be able to realize his desires. And he should also learn that success at times depends on willingness to take second place, and that asking questions is not a serious acknowledgment of inferiority.")
////                      }
////
////
////                      if natal_sunCoordinate.sign.name == "Sagittarius" {
////
////                      print("The Power thought cells of the individual born in Sagittarius, where the Sun may be found each year from November 22 to December 22, have been associated with, and desire to express through, the I SEE attitude. Even as the Centaur, which pictures among the constellations the influence of this sign, is half animal and half human, is a hunter with the legs of a horse and the head of a man, and is armed with a bow, so Sagittarius people have strong animal tendencies and at the same time are also well supplied with the higher, nobler, more generous impulses. They are migratory, loving to travel, and they are keen on outdoor sports; but at the same time they have a strong leaning toward philosophy and religion. When they speak, what they say goes straight to the mark like an arrow to the bull’s eye.   The Sagittarius individual is free, energetic, ambitious of worldly position, loyal, patriotic and charitable of the shortcomings of others. Prompt and decisive in action, he can command others, and thus makes a good executive. On the other hand, he can also take orders without resentment. Frank and candid in expressing opinions, he is quick to fight for the rights of others. He possesses buoyancy and tremendous enthusiasm.   When the Sun is afflicted, he tends toward SPORTIVENESS. He does need fresh air, exercise and recreation. But he also requires ample mental activity. The earlier he gains the viewpoint that the best game of all is to be found in work which contributes to his own success and to the welfare of society, and that to find and follow this work advantageously requires the acquisition of COMPREHENSION, the more he will gain from life.")
////                }
////
////
////                      if natal_sunCoordinate.sign.name == "Capricorn" {
////                            print("The Power thought cells of the individual born in Capricorn, where the Sun may b found each year from December 22 to January 20, have been associated with, and desire to express through, the I USE attitude. Even as the Goat, which pictures among the constellations the influence of this sign, ascends a mountain by taking advantage of every foothold, so Capricorn people climb to their ambitions by grasping every possible opportunity, great or small, to advance themselves. Suppliantly they bow to the reigning authority, seeking by sundry and devious ways to gain the good will of others, that they may partake in power, much as the goat must bend his knees and devise many a clever method to crop the foliage among the precipitous rocks of his upland pasture.   The Capricorn individual is patient and persistent, and by concentrated effort and skillful maneuvering butts his way through, or climbs his way around, all but insurmountable obstacles. He is highly ambitious, a good manager, methodical and inclined to be conventional. He carries responsibility well, and has a faculty for bringing together dissenting factions, but is too much inclined to carry other people’s troubles.   When the Sun is afflicted, he tends toward DECEITFULNESS. The earlier he realizes that the greatest advantage any person can have is integrity and devotion to the welfare of others, and employs DIPLOMACY, and his faculty for synthesis and economy for the good of society, the greater will be those honors attained which he so ardently craves.")
////
////
////                                  if natal_sunCoordinate.sign.name == "Aquarius" {
////
////                            print("The Power thought cells of the individual born in Aquarius, where the Sun may be found each year from January 20 to February 20, have been associated with, and desire to express through, the I KNOW attitude. Even as the Man, which pictures among the constellations the influence of this sign, measures the energies in the sky with one hand, and with the other pours down upon earth a flood of information, so Aquarius people tend to be interested in astrology and all things new and progressive, have humanitarian instincts, are keen on education, and desire scientific verification of all theories.   The Aquarius individual is inventive, scientific, pleasant, friendly, determined, faithful, sincere, easily influenced by kindness, fond of society and refinement, and a keen student of human nature. He is independent, cares little for precedent and convention, and although he may listen with rapt attention to the ideas of another, he is not apt to be impressed by them. He forms his own opinions. Because he understands human nature so well, he knows just what to say and what to do to produce a given effect upon those with whom he is associated. Greatly interested in politics and religion, he tends to view things, not so much from their benefit to one person or one group, but in reference to their benefit to society as a whole.   When the Sun is afflicted, his desire for ARGUMENTATION often causes him to take the opposite side of a question merely for the sake of the discussion. Because he absorbs knowledge so quickly he becomes impatient of those who are slow to grasp new, and perhaps untried, ideas. He tends to procrastinate, and his enthusiasm for bettering the race is too apt to be expended in verbal discussions which theoretically solve the difficulties of mankind. The earlier he recognizes that wisdom must be accompanied by practical application if it is to accomplish anything worthwhile, and the earlier he acquires the habit of action, in addition to talk, the quicker and more effectively will he be able to contribute to the ALTRUISM which he seeks.")
////                                  }
////
////
////                    if natal_sunCoordinate.sign.name == "Pisces" {
////                    print("The Power thought cells of the individual born in Pisces, where the Sun may be found each year from February 20 to March 21, have been associated with, and desire to express through, the I BELIEVE attitude. Even as the Fishes, which picture among the constellations the influence of this sign, live in water, symbol of the emotions, so are Pisces people unusually sympathetic and powerfully influenced by their affections. These fish are united by the ribbon of love, and Pisces people long for the ideal in marriage, and when this ideal is not realized become restless and discontented. Nor is their idealism confined to domestic life. They also yearn for universal brotherhood and peace on earth good will to men.   The Pisces individual is amiable, kind, neat and particular, yet may be timid and lacking in self-confidence. He is greatly influenced by his environment, is restless, emotional, and capable of high intellectual development. Sensitive and mediumistic, capable of psychic lucidity, romantic and a lover of mystery, he may become too negative and dreamy to realize his ideals. He readily becomes interested in psychic investigation, is profoundly disturbed by injustice, and is deeply religious. Even as there are two fish, the Pisces individual varies more widely from type than those born in any other sign.    When the Sun is afflicted, he is inclined to magnify the importance of actual or threatened adversity, and he easily develops a tendency to start things which he does not finish. Even in his SYMPATHY for others he should early realize he is responsible only in so far as he has ability, and trust Deity with other details. And the sooner he thus banishes WORRY, and learns to finish what he starts, the quicker will he realize the peace and harmony he desires.")
////                }
//
//
//
////                          MOON
////                          Mental processes are of two kinds. In the type ruled by Mercury, cerebral processes resort to careful reasoning, classified observation, and the formulation of words and sentences. And to get ideas across to others such words and sentences are essential.
////                          Yet the mental attitude as a whole, and the mental capacity, are not chiefly due to such cerebral processes. Instead, they arise mostly from the unconscious mind and from the impressions received from environment which have not thus been carefully pigeon holed. The feelings about certain things, the unreasoned mental processes, the hunches, intuitions and capacities for absorbing certain kinds of information which, rather than the expression of opinions thus formed through words and sentences, chiefly constitute the mentality, are expressions of the thought cells mapped by the Moon.
////                          These thought cells which so powerfully influence the mentality have been organized by experiences in lower life forms with family and the rearing of offspring. They govern the negative, low frequency energies of the electromagnetic body. Their degree of activity, and their harmony, are important in determining the strength of the physical constitution and therefore the health. As they are the most receptive of all to impressions from environment, it becomes easier to receive such impressions through the avenues indicated by the sign and aspects of the Moon.
////                          Because their chief expression relates to family life, they are called DOMESTIC thought cells. Aspects to the Moon affect the mental attitude, everyday affairs, and relations with the female sex and the common people. To the extent the thought cells mapped by the Moon are active is the life influenced by thoughts of domestic life, women, the offspring, the weak and helpless, or by music.
////                          When the Moon is prominent in the birth chart, it denotes much curiosity and changing moods, and the individual likes to be before the public or to mix with the masses.
////                          When prominent and afflicted, there is a tendency toward INCONSTANCY. Therefore the individual with such a chart should as early as possible realize that to be favorably known by the public he must not change his mind too often, and must cultivate the power to persist in some one endeavor until he has exceptional ability. The tendency to instability should be channeled into ADAPTABILITY.
//
//
//
//
//
//
//
//
//
////
//                    if natal_moonCoordinate.sign.name == "Aries" {
//                  print("Moon in Aries—With the Domestic thought cells expressing from the I Am attitude, the mind should pioneer and seek constructive leadership rather than too forceful assertion of opinions.")
//                    }
//
//
//                    if natal_moonCoordinate.sign.name == "Taurus" {
//                      print("Moon in Taurus—With the Domestic thought cells expressing from the I Have attitude, the mind should seek spiritual knowledge rather than become absorbed in acquiring material possessions.")
//                  }
//
//
//                    if natal_moonCoordinate.sign.name == "Gemini" {
//                          print("Moon in Gemini—With the Domestic thought cells expressing from the I Think attitude, the mind should seek complete mastery of some one subject rather than a smattering of information about many things.")
//                      }
//
//
//                    if natal_moonCoordinate.sign.name == "Cancer" {
//                    print(" Moon in Cancer—With the Domestic thought cells expressing from the I Feel attitude, the mind should seek to explain its thoughts to others rather than be content with absorbing knowledge.")
//                          }
//
//
//
//
//
//                        if natal_moonCoordinate.sign.name == "Leo" {
//                            print("Moon in Leo—With the Domestic thought cells expressing from the I Will attitude, the mind should seek to gain esteem through kindness rather than through display and domination.")
//                    }
//
//
//
//
//
//                        if natal_moonCoordinate.sign.name == "Virgo" {
//                                print("Moon in Virgo—With the Domestic thought cells expressing from the I Analyze attitude, the mind should seek worthy service rather than acid criticism.")
//                            }
//
//
//                    if natal_moonCoordinate.sign.name == "Libra" {
//                          print("Moon in Libra—With the Domestic thought cells expressing from the I Balance attitude, the mind should seek beauty and artistic creation rather than ease and luxury.")
//                                }
//
//
//
//                    if natal_moonCoordinate.sign.name == "Scorpio" {
//                      print("Moon in Scorpio—With the Domestic thought cells expressing from the I Desire attitude, the mind should seek tasks which are helpful to society rather than the destruction of enemies.")
//                          }
//
//
//
//                    if natal_moonCoordinate.sign.name == "Sagittarius" {
//                      print("Moon in Sagittarius—With the Domestic thought cells expressing from the I See attitude, the mind should seek a sound philosophy rather than too great interest in sports.")
//                      }
//
//                    if natal_moonCoordinate.sign.name == "Capricorn" {
//                  print("Moon in Capricorn—With the Domestic thought cells expressing from the I Use attitude, the mind should seek honors through serving society rather than through attaining self-centered ambitions.")
//              }
//                    if natal_moonCoordinate.sign.name == "Aquarius" {
//                  print("Moon in Aquarius—With the Domestic thought cells expressing from the I Know attitude, the mind should seek practical information rather than be content with untried theories.")
//                        }
//
//                        if natal_moonCoordinate.sign.name == "Pisces" {
//                      print("Moon in Pisces—With the Domestic thought cells expressing from the I Believe attitude, the mind should seek faith that all will be well rather than dissipating its energy in worry.")
//                            }
//
//
//              //  Mercury in the Signs
//
//
//
//
////                          MERCURY
////                          The electrical currents which carry messages over the nerves, and all cerebral processes, including perception and comparison, are ruled by Mercury; and all expression of thought in speech and writing are expressions of the thought cells mapped by Mercury.
////                          86 HOROSCOPE READER
////                          These thought cells which so powerfully influence the intellectual ability, the intellectual interests and the habitual methods of objective thinking, have been organized in lower forms of life through learning to remember and recognize enemies, palatable foods, and suitable localities for shelter. Because their chief expression relates to the intellectual life, they are called INTELLECTUAL thought cells. Aspects to Mercury affect the mental interests, the facility and accuracy of expression, and the type of cerebral activity. To the extent the thought cells mapped by Mercury are active is the life influenced by thoughts about time, written or verbal expression, calculation, travel, the recognition of size, weight, form and color, or the solution of perplexities.
////                          When Mercury is prominent in the birth chart, it denotes one who is mentally active, capable of taking an education, of functioning on the intellectual level, and of learning new tasks readily. He is at his best where he can attain his ends by writing, talking or travel.
////                          When prominent and afflicted, there is a tendency toward RESTLESSNESS. Therefore the individual with such a chart should as early as possible realize that the highest form of EXPRESSION can be attained only through protracted concentration.
////
//
//                            if natal_mercuryCoordinate.sign.name == "Aries" {
//                          print("Mercury in Aries—With the Intellectual thought cells expressing from the I Am attitude, the speech should be interesting and clever rather than impulsive and antagonistic.")
//                      }
//
//
//                            if natal_mercuryCoordinate.sign.name == "Taurus" {
//                              print("Mercury in Taurus—With the Intellectual thought cells expressing from the I Have attitude, the speech should be practical and refined rather than too determined and unyielding.")
//
//                      }
//
//                            if natal_mercuryCoordinate.sign.name == "Gemini" {
//                                  print("Mercury in Gemini—With the Intellectual thought cells expressing from the I Think attitude, the speech should be based on valuable information rather than merely loquacious.")
//
//                              }
//
//
//                            if natal_mercuryCoordinate.sign.name == "Cancer" {
//                            print("Mercury in Cancer—With the intellectual thought cells expressing from the I Feel attitude, the speech should be free and poetic rather than repressed through sensitiveness to the opinions of others.")
//                            }
//
//
//
//
//
//
//                                if natal_mercuryCoordinate.sign.name == "Leo" {
//                                    print("Mercury in Leo—With the Intellectual thought cells expressing from the I Will attitude, the speech should be idealistic and sympathetic rather than dominating.")
//                                          }
//
//
//
//
//
//                                if natal_mercuryCoordinate.sign.name == "Virgo" {
//                                        print("Mercury in Virgo—With the Intellectual thought cells expressing from the I Analyze attitude, the speech should be persuasive and constructive rather than sharp and critical.")
//
//                                    }
//
//                            if natal_mercuryCoordinate.sign.name == "Libra" {
//                                  print("Mercury in Libra—With the Intellectual thought cells expressing from the I Balance attitude, the speech should be just and refined rather than merely agreeing with the views of present company.")
//
//                            }
//
//                            if natal_mercuryCoordinate.sign.name == "Scorpio" {
//                              print("With the intellectual thought cells expressing from the I Desire attitude, the speech should be scientific and helpful rather than caustic and stinging.")
//
//                            }
//
//                            if natal_mercuryCoordinate.sign.name == "Sagittarius" {
//                              print("Mercury in Sagittarius—With the Intellectual thought cells expressing from the I See attitude, the speech should be generous and loyal rather than impulsive and blunt.")
//
//                            }
//                            if natal_mercuryCoordinate.sign.name == "Capricorn" {
//                          print("Mercury in Capricorn—With the Intellectual thought cells expressing from the I Use attitude, the speech should be tactful and diplomatic rather than self seeking and deceitful.")
//                      }
//                            if natal_mercuryCoordinate.sign.name == "Aquarius" {
//                          print("Mercury in Aquarius—With the Intellectual thought cells expressing from the I Know attitude, the speech should be informative and educational rather than argumentative.")
//                                }
//
//                                if natal_mercuryCoordinate.sign.name == "Pisces" {
//                              print("Mercury in Pisces—With the Intellectual thought cells expressing from the I Believe attitude, the speech should be positive and good humored rather than timid or fretful.")
//                                    }
//
//
//
//              //  Venus in the Signs
//
//
//
////                          VENUS
////                          The thyroid secretions and those of the gonads respond to Venus; and mating, companionship, affection and love are expressions of the thought cells mapped by this planet.
////                          These thought cells which so powerfully influence all phases of social activity have been organized in lower forms of life through experiences with companionship and mating. Because their chief expression relates to the social life they are called SOCIAL thought cells. Aspects to Venus affect the emotions, the social relations and the artistic appreciation. To the extent the thought cells mapped by Venus are active is the life influenced by thoughts of affection, friendship, beauty, art, mirth, conjuality, or inhabitiveness.
////                          When Venus is prominent in the birth chart, it denotes one who is fastidious and who loves grace, music and the artistic. Such a person, to be at his best, needs social expression. Companionship is essential. He is unfitted for a life of solitude. Instead of seeking hard and heavy work, he does better where artistic ability or charm of manner is an asset.
////                          When prominent and afflicted, there is a tendency toward PLIANCY. He is entirely too eager to please others and to find the line of least resistance. The earlier he learns that he more often pleases when he asserts strength of character, the more certain he is of finding satisfactory expression for his AFFECTION.
////
////
//                    if natal_venusCoordinate.sign.name == "Aries" {
//                  print("Venus in Aries—With the Social thought cells expressing from the I Am attitude, the affections should be ardent and harmonious rather than exacting and impulsively given.")
//              }
//
//
//                    if natal_venusCoordinate.sign.name == "Taurus" {
//                      print("Venus in Taurus—With the Social thought cells expressing from the I Have attitude, the affections should be sociable and demonstrative rather than too greatly influenced by worldly possessions")
//
//              }
//
//                    if natal_venusCoordinate.sign.name == "Gemini" {
//                          print("Venus in Gemini—With the Social thought cells expressing from the I Think attitude, the affections should lend themselves to intellectual companionship rather than to inconstancy")
//
//                      }
//
//
//                    if natal_venusCoordinate.sign.name == "Cancer" {
//                    print("Venus in Cancer—With the Social thought cells expressing from the I Feel attitude, the affections should seek satisfaction in the domestic life rather than suffer in shrinking timidity.")
//                    }
//
//
//
//
//
//
//                        if natal_venusCoordinate.sign.name == "Leo" {
//                            print("Venus in Leo—With the Social thought cells expressing from the I Will attitude, the affections should seek satisfaction through children and entertainment rather than in dramatization.")
//                                  }
//
//
//
//
//
//                        if natal_venusCoordinate.sign.name == "Virgo" {
//                                print("Venus in Virgo—With the Social thought cells expressing from the I Analyze attitude, the affections should be given spontaneous encouragement rather than hampered too greatly by cold reason.")
//
//                            }
//
//                    if natal_venusCoordinate.sign.name == "Libra" {
//                          print("Venus in Libra—With the Social thought cells expressing from the I Balance attitude, the affections should be given only after careful thought rather than permitted free response to flattery.")
//
//                    }
//
//                    if natal_venusCoordinate.sign.name == "Scorpio" {
//                      print("Venus in Scorpio—With the Social thought cells expressing from the I Desire attitude, the affections should be given a high standard rather than finding satisfaction in dissipation.")
//
//                    }
//
//                    if natal_venusCoordinate.sign.name == "Sagittarius" {
//                      print("Venus in Sagittarius—With the Social thought cells expressing from the I See attitude, the affections should find a worthy subject for their loyalty rather than impulsively center on one less desirable.")
//
//                    }
//                    if natal_venusCoordinate.sign.name == "Capricorn" {
//                  print("Venus in Capricorn—With the Social thought cells expressing from the I Use attitude, the affections should find satisfaction and harmony rather than be too greatly influenced by ambition and position.")
//              }
//                    if natal_venusCoordinate.sign.name == "Aquarius" {
//                  print("Venus in Aquarius—With the Social thought cells expressing from the I Know attitude, the affections should seek satisfaction in domestic life rather than expend themselves entirely on friends.")
//                        }
//
//                        if natal_venusCoordinate.sign.name == "Pisces" {
//                      print("Venus in Pisces—With the Social thought cells expressing from the I Believe attitude, the affections should seek those who can give like deep response rather than expend on those who take but cannot give.")
//                            }
//
//
//
//
//              //  Mars in the Signs
//
////
////                          MARS
////                          The secretions of the adrenal glands and those of the gonads respond to Mars; and construction, destruction, combat and sex are expressions of the thought cells mapped by this planet.
////                          These thought cells which so powerfully influence constructive and destructive activity have been organized in lower forms of life through experiences with fighting, sex and the acquisition of food. Because their chief expression relates to attacking obstacles they are called the AGGRESSIVE thought cells. Aspects to Mars bring strife, haste and increased expenditure of
////                          EACH PLANET IN EACH SIGN 89
////                          energy. To the extent the thought cells mapped by Mars are active is the life influenced by thoughts of construction, destruction, initiative, aggression, combat, sex, eating or drinking.
////                          When Mars is prominent in the birth chart it denotes one who must have an outlet for his abundant energy either in constructive or destructive work. He must have plenty of action.
////                          When prominent and afflicted, there is a tendency toward quarrelsomeness and HARSHNESS. The earlier he realizes that there is more opportunity for his INITIATIVE in fighting disease, ignorance and poverty than in combating any human foe, that undue severity and antagonism hinder constructive endeavors, and that there is greater joy to be found in building up than in tearing down, the more satisfaction he will gain from life.
////
////
//
//              if natal_marsCoordinate.sign.name == "Aries" {
//            print("Mars in Aries—With the Aggressive thought cells expressing from the I Am attitude, initiative should be employed in pioneering and mechanical enterprise rather than in asserting superiority.")
//        }
//
//
//              if natal_marsCoordinate.sign.name == "Taurus" {
//                print("Mars in Taurus—With the Aggressive thought cells expressing from the I Have attitude, initiative should be employed in financial matters rather than in seeking sensual pleasures.")
//
//        }
//
//              if natal_marsCoordinate.sign.name == "Gemini" {
//                    print("Mars in Gemini—With the Aggressive thought cells expressing from the I Think attitude, initiative should be employed in acquiring information rather than in endless talk.")
//
//                }
//
//
//              if natal_marsCoordinate.sign.name == "Cancer" {
//              print("VMars in Cancer—With the Aggressive thought cells expressing from the I Feel attitude, initiative should be employed in constructing a pleasant home rather than in outbursts of temper.")
//              }
//
//
//
//
//
//
//                  if natal_marsCoordinate.sign.name == "Leo" {
//                      print("Mars in Leo—With the Aggressive thought cells expressing from the I Will attitude, initiative should be employed in entertaining rather than in seeking to compel others to obey orders.")
//                            }
//
//
//
//
//
//                  if natal_marsCoordinate.sign.name == "Virgo" {
//                          print("Mars in Virgo—With the Aggressive thought cells expressing from the I Analyze attitude, initiative should be employed in finding better ways of performing work rather than in faultfinding.")
//
//                      }
//
//              if natal_marsCoordinate.sign.name == "Libra" {
//                    print("Mars in Libra—With the Aggressive thought cells expressing from the I Balance attitude, initiative should be employed in making a success of marriage rather than in making a hasty union.")
//
//              }
//
//              if natal_marsCoordinate.sign.name == "Scorpio" {
//                print("Mars in Scorpio—With the Aggressive thought cells expressing from the I Desire attitude, initiative should be employed developing the resourcefulness rather than in self indulgence or revenge.")
//
//              }
//
//              if natal_marsCoordinate.sign.name == "Sagittarius" {
//                print("Mars in Sagittarius—With the Aggressive thought cells expressing from the I See attitude, initiative should be employed acquiring a satisfactory philosophy rather than in questionable sports.")
//
//              }
//              if natal_marsCoordinate.sign.name == "Capricorn" {
//            print("Mars in Capricorn—With the Aggressive thought cells expressing from the I Use attitude, initiative should be employed in seeking honors through benefiting others rather than merely in benefiting self.")
//        }
//              if natal_marsCoordinate.sign.name == "Aquarius" {
//            print("Mars in Aquarius—With the Aggressive thought cells expressing from the I Know attitude initiative should be employed in humanitarian reforms rather than controversies.")
//                  }
//
//                  if natal_marsCoordinate.sign.name == "Pisces" {
//                print("Mars in Pisces—With the Aggressive thought cells expressing from the I Believe attitude, initiative should be employed in positive action rather than merely in wishful thinking.")
//                      }
//
//
//                      //   Jupiter in the Signs
//
//
//
//
////
////                          JUPITER
////                          The arterial blood stream of the body and the financial system of society are expressions of the thought cells ruled by Jupiter.
////                          These thought cells which so powerfully influence good will and abundance have been organized in lower forms of life through experiences with obedience to the ruling authority, such as the parents, and looking to such higher power for guidance, protection and the satisfaction of want. Because their chief expression relates to religious devotion they are called the RELIGIOUS thought cells. Aspects to Jupiter affect through abundance, optimism and joviality. To the extent the thought cells mapped by Jupiter are active is the life influenced by thoughts of benevolence, veneration, hope, devotion, selling, good will or generosity.
////                          When Jupiter is prominent in the birth chart it denotes one who feels menial employment is beneath his dignity. As a consequence he seeks a profession, engages in merchandising, or becomes a salesman. His joviality and ability to gain patronage and favors through the good will he radiates are valuable assets.
////                          When prominent and afflicted, the good opinion he has of himself tends to develop CONCEIT. The earlier he recognizes that Deity has permitted others than himself also to have correct opinions, and that he therefore should be charitable toward those opinions, the sooner he will begin to realize the feeling of BENEVOLENCE which he so strongly craves.
////
//
//              if natal_jupiterCoordinate.sign.name == "Aries" {
//            print("Jupiter in Aries—With the Religious thought cells expressing from the I Am attitude, faith should be broadened to include the opinions and abilities of others as well as one’s own.")
//        }
//
//
//              if natal_jupiterCoordinate.sign.name == "Taurus" {
//                print("Jupiter in Taurus—With the Religious thought cells expressing from the I Have attitude, there should be faith in spiritual things rather than in the power of money to buy.")
//
//        }
//
//              if natal_jupiterCoordinate.sign.name == "Gemini" {
//                    print("Jupiter in Gemini—With the Religious thought cells expressing from the I Think attitude, faith should be cultivated in carefully ascertained facts rather than in voluble statements.")
//
//                }
//
//
//              if natal_jupiterCoordinate.sign.name == "Cancer" {
//              print("Jupiter in Cancer—With the Religious thought cells expressing from the I Feel attitude, faith should be placed in the impressions rather than in the external appearance of things.")
//              }
//
//
//
//
//
//
//                  if natal_jupiterCoordinate.sign.name == "Leo" {
//                      print("Jupiter in Leo—With the Religious thought cells expressing from the I Will attitude, faith should be cultivated in the willingness of others to respond to kindness rather than in the power to dominate.")
//                            }
//
//
//
//
//
//                  if natal_jupiterCoordinate.sign.name == "Virgo" {
//                          print("Jupiter in Virgo—With the Religious thought cells expressing from the I Analyze attitude, faith should be placed in the good qualities of others rather than in the power of their weaknesses to cause difficulty.")
//
//                      }
//
//              if natal_jupiterCoordinate.sign.name == "Libra" {
//                    print("Jupiter in Libra—With the Religious thought cells expressing from the I Balance attitude, faith should be placed in justice and firmness rather than in the plaudits of others.")
//
//              }
//
//              if natal_jupiterCoordinate.sign.name == "Scorpio" {
//                print("Jupiter in Scorpio—With the Religious thought cells expressing from the I Desire attitude, faith should be placed in forthright resourcefulness rather than in hidden action and cunning.")
//
//              }
//
//              if natal_jupiterCoordinate.sign.name == "Sagittarius" {
//                print("Jupiter in Sagittarius—With the Religious thought cells expressing from the I See attitude, faith should be placed in prayer and devotion rather than in impulse and enthusiasm.")
//
//              }
//              if natal_jupiterCoordinate.sign.name == "Capricorn" {
//            print("Jupiter in Capricorn—With the Religious thought cells expressing from the I Use attitude, faith should be cultivated in gaining honors through benefiting society rather than through deceit.")
//        }
//              if natal_jupiterCoordinate.sign.name == "Aquarius" {
//            print("Jupiter in Aquarius—With the Religious thought cells expressing from the I Know attitude, faith should be placed in facts and altruism rather than in theories and argument.")
//                  }
//
//                  if natal_jupiterCoordinate.sign.name == "Pisces" {
//                print("Jupiter in Pisces—With the Religious thought cells expressing from the I Believe attitude, faith should be cultivated that all will work out to advantage rather than that difficulties will prove serious.")
//                      }
//
//
//              //  Saturn in the Signs
//
//
////
////                          SATURN
////                          The bony structure of the body, traits which stabilize the character, and ability to conserve or hoard material possessions, are expressions of the thought cells ruled by Saturn.
////                          These thought cells which so powerfully influence acquisition, fear, persistence and selfishness have been organized in lower forms of life through experiences in seeking security, such as in fleeing from enemies and hoarding food. Because their chief expression relates to obtaining safety, they are called SAFETY thought cells. Aspects to Saturn affect the life through work, responsibility, or economy or loss. To the extent the thought cells mapped by Saturn are active is the life influenced by thoughts of safety, secrecy, acquisitiveness, covetousness, buying, trading, casualty, comparison, worry, fear, greed, selfishness, system, order or persistence.
////                          When Saturn is prominent in the birth chart it denotes one who works hard, is shrewd and can buy to advantage, but in selling does better to employ another. He has a leaning toward
////                          92 HOROSCOPE READER
////                          business, is a lover of efficiency, economy and organization, and has the patience to await for plans to mature.
////                          When prominent and afflicted, he tends to become self centered and unscrupulous in taking advantage of others. The earlier he realizes that SELFISHNESS does not pay, that honesty is the most profitable policy, and devotes his energy to developing SYSTEM to eliminate waste and inefficiency, the quicker will he gain the success he desires.
//
//
//
//              if natal_saturnCoordinate.sign.name == "Aries" {
//            print("Saturn in Aries—With the Safety thought cells expressing from the I Am attitude, security should be sought through caution and circumspection rather than through contention and abrupt action.")
//        }
//
//
//              if natal_saturnCoordinate.sign.name == "Taurus" {
//                print("Saturn in Taurus—With the Safety thought cells expressing from the I Have attitude, security should be sought not in hoarding money but in wisely putting it to active use.")
//
//        }
//
//              if natal_saturnCoordinate.sign.name == "Gemini" {
//                    print("Saturn in Gemini—With the Safety thought cells expressing from the I Think attitude, security should be sought through system and action rather than in words.")
//
//                }
//
//
//              if natal_saturnCoordinate.sign.name == "Cancer" {
//              print("Saturn in Cancer—With the Safety thought cells expressing from the I Feel attitude, security should be sought through intuition rather than through taking the advice of others.")
//              }
//
//
//
//
//
//
//                  if natal_saturnCoordinate.sign.name == "Leo" {
//                      print("Saturn in Leo—With the Safety thought cells expressing from the I Will attitude, security should be sought in healthful recreation rather than in show and display.")
//                            }
//
//
//
//
//
//                  if natal_saturnCoordinate.sign.name == "Virgo" {
//                          print("Saturn in Virgo—With the Safety thought cells expressing from the I Analyze attitude, security should be sought in system and order rather than in frugality and arduous labor.")
//
//                      }
//
//              if natal_saturnCoordinate.sign.name == "Libra" {
//                    print("Saturn in Libra—With the Safety thought cells expressing from the I Balance attitude, security should be sought in calm judgment rather than in the approbation of associates.")
//
//              }
//
//              if natal_saturnCoordinate.sign.name == "Scorpio" {
//                print("Saturn in Scorpio—With the Safety thought cells expressing from the I Desire attitude, security should be sought in careful attention to details rather than in forceful action.")
//
//              }
//
//              if natal_saturnCoordinate.sign.name == "Sagittarius" {
//                print("Saturn in Sagittarius—With the Safety thought cells expressing from the I See attitude, security should be sought in faith and comprehension rather than in impulse and taking hazards.")
//
//              }
//              if natal_saturnCoordinate.sign.name == "Capricorn" {
//            print("With the Safety thought cells expressing from the I Use attitude, security should be sought through serving the public faithfully rather than through actions that are self centered.")
//        }
//              if natal_saturnCoordinate.sign.name == "Aquarius" {
//            print("Jupiter in Aquarius—With the Religious thought cells expressing from the I Know attitude, faith should be placed in facts and altruism rather than in theories and argument.")
//                  }
//
//                  if natal_saturnCoordinate.sign.name == "Pisces" {
//                print("Saturn in Aquarius—With the Safety thought cells expressing from the I Know attitude, security should be sought through humanitarian endeavors rather than through influencing others to their disadvantage.")
//                      }
//
//              // Uranus in the Signs
//
//
//
////
////                          URANUS
////                          The electromagnetic energies generated by the nervous system are expressions of the thought cells ruled by Uranus.
////                          These thought cells which so powerfully influence originality of thought, and the ability to make marked departures from precedence and custom, have been organized in lower forms of life through experiences in departing, under stress of emergency, from food or other habits. Because their chief expression relates to originality, they are called the INDIVIDUALISTIC thought cells. Aspects to Uranus affect the life through sudden events, through the influence of people, and through radical changes. To the extent the thought cells mapped by Uranus are active is the life influenced by thoughts of independence, originality, inventions, the unconventional, methods unusual, or methods quite new.
////                          When Uranus is prominent in the birth chart, it denotes one who is interested in things exceptionally old or exceptionally new. He is apt to be unconventional, is abrupt, and takes extreme views. He has the power to mold the opinions of others through conversation or oratory, and is always enthusiastic about reformation of some kind.
////                          When prominent and afflicted, he tends to go to unreasonable extremes. The earlier he learns that moderate views in most things, and the avoidance of ECCENTRICITY, will enable him to get his ORIGINALITY more readily accepted where essential matters are concerned, the sooner he will be able to bring about the reforms he seeks.
////
//
//              if natal_uranusCoordinate.sign.name == "Aries" {
//            print("Uranus in Aries—With the Individualistic thought cells expressing from the I Am attitude, originality should be sought in political reforms or inventions rather than in dress and personality.")
//        }
//
//
//              if natal_uranusCoordinate.sign.name == "Taurus" {
//                print("Uranus in Taurus—With the Individualistic thought cells expressing from the I Have attitude, originality should be sought in handling money rather than in being obstinate.")
//
//        }
//
//              if natal_uranusCoordinate.sign.name == "Gemini" {
//                    print("Uranus in Gemini—With the Individualistic thought cells expressing from the I Think attitude, originality should be sought in developing sound ideas rather than in manner of writing or speech.")
//
//                }
//
//
//              if natal_uranusCoordinate.sign.name == "Cancer" {
//              print("Uranus in Cancer—With the Individualistic thought cells expressing from the I Feel attitude, originality should be sought in home improvement rather than in erratic emotions.")
//              }
//
//
//
//
//
//
//                  if natal_uranusCoordinate.sign.name == "Leo" {
//                      print("Uranus in Leo—With the Individualistic thought cells expressing from the I Will attitude, originality should be sought in sound political reforms rather than in peculiar pleasures.")
//                            }
//
//
//
//
//
//                  if natal_uranusCoordinate.sign.name == "Virgo" {
//                          print("Uranus in Virgo—With the Individualistic thought cells expressing from the I Analyze attitude, originality should be sought in scientific discovery rather than in fads relating to foods.")
//
//                      }
//
//              if natal_uranusCoordinate.sign.name == "Libra" {
//                    print("Uranus in Libra—With the Individualistic thought cells expressing from the I Balance attitude, originality should be sought in artistic endeavors rather than in unconventional attachments.")
//
//              }
//
//              if natal_uranusCoordinate.sign.name == "Scorpio" {
//                print("Uranus in Scorpio—With the Individualistic thought cells expressing from the I Desire attitude, originality should be sought in electrical or chemical discoveries rather than in unusual dissipation.")
//
//              }
//
//              if natal_uranusCoordinate.sign.name == "Sagittarius" {
//                print("Uranus in Sagittarius—With the Individualistic thought cells expressing from the I See attitude, originality should be sought in finding a satisfactory philosophy rather than in peculiar sports.")
//
//              }
//              if natal_uranusCoordinate.sign.name == "Capricorn" {
//            print("Uranus in Capricorn—With the Individualistic thought cells expressing from the I Use attitude, originality should be sought in giving better service to the public rather than in self seeking ambition.")
//        }
//              if natal_uranusCoordinate.sign.name == "Aquarius" {
//            print("Uranus in Aquarius—With the Individualistic thought cells expressing from the I Know attitude, originality should be sought in humanitarian endeavors rather than in methods of winning arguments.")
//                  }
//
//                  if natal_uranusCoordinate.sign.name == "Pisces" {
//                print("Uranus in Pisces—With the Individualistic thought cells expressing from the I Believe attitude, originality should be sought in alleviating suffering rather than in expressing sorrow.")
//                      }
//
//
//                  // Neptune in the Signs
//
////
////                          NEPTUNE
////                          Feeling extrasensory perception and dramatic talent are expressions of the thought cells ruled by Neptune.
////                          These thought cells which so powerfully influence the visions and the ability to bring through from the astral world consciousness of what is there apprehended have been organized in lower forms of life through experiences in which mental escape has been made from the harsh restraining walls of reality. Because their chief expression relates to images of conditions more perfect they are called UTOPIAN thought cells. Aspects to Neptune affect the life through the imagination, increased sensitiveness, and schemes. To the extent the thought cells mapped by Neptune are active is the life influenced by wishful thinking, fantasy thinking, daydreaming, apprehension, idealistic visions, living in the imagination, or by thoughts of easy wealth or promotion.
////                          When Neptune is prominent in the birth chart, it denotes one who has a lively imagination, and who possesses the power to get others interested in his projects. He is a good promoter and
////                          EACH PLANET IN EACH SIGN 95
////                          has decided dramatic talents, but dislikes both system and discipline, and seeks to avoid hard work.
////                          When prominent and afflicted, he fails to think things through, gives way to VAGUENESS, and instead of critically analyzing his ideas prefers to believe what he wishes to be true. The sooner he learns that the only valuable ideas are those which may be made practical the more fully will he be able to realize the IDEALISM for which he yearns.
//
//
//
//              if natal_neptuneCoordinate.sign.name == "Aries" {
//            print("Neptune in Aries—With the Utopian thought cells expressing from the I Am attitude, idealism should be sought in promoting useful machines or appliances rather than in stressing personal ability.")
//        }
//
//
//              if natal_neptuneCoordinate.sign.name == "Taurus" {
//                print("Neptune in Taurus—With the Utopian thought cells expressing from the I Have attitude, idealism should be sought in securing freedom from want for all rather than in acquiring a vast fortune for self.")
//
//        }
//
//              if natal_neptuneCoordinate.sign.name == "Gemini" {
//                    print("Neptune in Gemini—With the Utopian thought cells expressing from the I Think attitude, idealism should be sought through clearly formulated speech or writing rather than dissipated in unproductive conversation.")
//
//                }
//
//
//              if natal_neptuneCoordinate.sign.name == "Cancer" {
//              print("Neptune in Cancer—With the Utopian thought cells expressing from the I Feel attitude, idealism should be sought through dramatic art or patriotism rather than in wishful thinking.")
//              }
//
//
//
//
//
//
//                  if natal_neptuneCoordinate.sign.name == "Leo" {
//                      print("Neptune in Leo—With the Utopian thought cells expressing from the I Will attitude, idealism should be sought through entertainment and constructive politics rather than in self promoting display.")
//                            }
//
//
//
//
//
//                  if natal_neptuneCoordinate.sign.name == "Virgo" {
//                          print("Neptune in Virgo—With the Utopian thought cells expressing from the I Analyze attitude, idealism should be sought through hygiene and diet rather than through seeking to avoid hard work.")
//
//                      }
//
//              if natal_neptuneCoordinate.sign.name == "Libra" {
//                    print("Neptune in Libra—With the Utopian thought cells expressing from the I Balance attitude, idealism should be sought in music and art rather than in peculiar associations with the opposite sex.")
//
//              }
//
//              if natal_neptuneCoordinate.sign.name == "Scorpio" {
//                print("Neptune in Scorpio—With the Utopian thought cells expressing from the I Desire attitude, idealism should be sought in chemical research and healing rather than in daydreaming or mediumship.")
//
//              }
//
//              if natal_neptuneCoordinate.sign.name == "Sagittarius" {
//                print("With the Utopian thought cells expressing from the I See attitude, idealism should be sought through promoting a religion based on facts rather than in devotion based on blind belief.")
//
//              }
//              if natal_neptuneCoordinate.sign.name == "Capricorn" {
//            print("Neptune in Capricorn—With the Utopian thought cells expressing from the I Use attitude, idealism should be sought through widespread organization rather than through deceptive schemes or promotion.")
//        }
//              if natal_neptuneCoordinate.sign.name == "Aquarius" {
//            print("JNeptune in Aquarius—With the Utopian thought cells expressing from the I Know attitude, idealism should be sought through humanitarian plans rather than through schemes for exploiting the unwary.")
//                  }
//
//                  if natal_neptuneCoordinate.sign.name == "Pisces" {
//                print("Neptune in Pisces—With the Utopian thought cells expressing from the I Believe attitude, idealism should be sought in charitable endeavors rather than in blindly following the advice of invisible intelligences.")
//                      }
//
//
//              //  Pluto in the Signs
//
////                          PLUTO
////                          Inner-plane forces, including on the lower side those most drastic and insidious, and on the upper side the finest and most spiritual of all, are expressions of the thought cells ruled by Pluto.
////                          These thought cells which so powerfully influence spiritual aspirations, or on the other hand influence inversion and awful wickedness, have been organized in lower forms of life through experiences in which there has been division of labor and cooperation for a mutual end. Because their chief expression relates to cooperation for the welfare of the group, and when spiritualized for the benefit of all, they are called the UNIVERSAL WELFARE thought cells. Aspects to Pluto affect the life through groups, through subtle force, or through coercion or cooperation. To the extent the thought cells mapped by Pluto are active is the life influenced by thoughts of groups, statistics, inner-plane conditions, drastic events, the inside of things, gang methods, cooperation, coercion, or universal welfare. When Pluto is prominent in the birth chart it denotes one who, consciously or unconsciously, easily tunes in on the thoughts and energies being broadcast from the inner plane. He is active, energetic and resourceful, and tends to unite with others to accomplish a common purpose.
////                          When prominent and afflicted, he tends to be attracted to groups who use him for their own self-seeking purpose, and who use coercion either to cause him to do as they wish, or to compel others to do their bidding. The earlier he learns to recognize and shun INVERSION and instead to work for UNIVERSAL WELFARE, the more satisfaction he will gain from life.
//
//
//
//              if natal_plutoCoordinate.sign.name == "Aries" {
//            print("Pluto in Aries—With the Universal Welfare thought cells expressing from the I Am attitude, cooperation should be sought in attaining constructive political leadership rather than in bureaucratic exploitation.")
//        }
//
//
//              if natal_plutoCoordinate.sign.name == "Taurus" {
//                print("Pluto in Taurus—With the Universal Welfare thought cells expressing from the I Have attitude, cooperation should be sought in attaining freedom from want for all rather than in monopolizing wealth.")
//
//        }
//
//              if natal_plutoCoordinate.sign.name == "Gemini" {
//                    print("Pluto in Gemini—With the Universal Welfare thought cells expressing from the I Think attitude, cooperation should be sought in properly educating the public rather than in misleading it.")
//
//                }
//
//
//              if natal_plutoCoordinate.sign.name == "Cancer" {
//              print("Pluto in Cancer—With the Universal Welfare thought cells expressing from the I Feel attitude, cooperation should be sought in improving the home life of people rather than in submitting to mediumistic control.")
//              }
//
//
//
//
//
//
//                  if natal_plutoCoordinate.sign.name == "Leo" {
//                      print("Pluto in Leo—With the Universal Welfare thought cells expressing from the I Will attitude, cooperation should be sought in the proper rearing of children rather than in questionable amusements.")
//                            }
//
//
//
//
//
//                  if natal_plutoCoordinate.sign.name == "Virgo" {
//                          print("Pluto in Virgo—With the Universal Welfare thought cells expressing from the I Analyze attitude, cooperation should be sought in benefiting labor rather than in exploiting labor.")
//
//                      }
//
//              if natal_plutoCoordinate.sign.name == "Libra" {
//                    print("Pluto in Libra—With the Universal Welfare thought cells expressing from the I Balance attitude, cooperation should be sought in attaining justice for all rather than defeating the aims of justice.")
//
//              }
//
//              if natal_plutoCoordinate.sign.name == "Scorpio" {
//                print("Pluto in Scorpio—With the Universal Welfare thought cells expressing from the I Desire attitude, cooperation should be sought in scientific research rather than in exploiting those who dissipate.")
//
//              }
//
//              if natal_plutoCoordinate.sign.name == "Sagittarius" {
//                print("Pluto in Sagittarius—With the Universal Welfare thought cells expressing from the I See attitude, cooperation should be sought to further the spread of facts rather than in exploiting the credulous.")
//
//              }
//              if natal_plutoCoordinate.sign.name == "Capricorn" {
//            print("Pluto in Capricorn—With the Universal Welfare thought cells expressing from the I Use attitude, cooperation should be sought in organizations beneficial to the public rather than in those detrimental to it.")
//        }
//              if natal_plutoCoordinate.sign.name == "Aquarius" {
//            print("Pluto in Aquarius—With the Universal Welfare thought cells expressing from the I Know attitude, cooperation should be sought in humanitarian endeavors rather than in taking advantage of human weaknesses.")
//                  }
//
//                  if natal_plutoCoordinate.sign.name == "Pisces" {
//                print("Pluto in Pisces—With the Universal Welfare thought cells expressing from the I Believe attitude, cooperation should be sought in alleviating human suffering rather than in placing people in bondage.")
//                      }
//
//
//  }
//
