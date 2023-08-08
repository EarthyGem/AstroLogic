//
//  35.swift
//  AstroLogic
//
//  Created by Errick Williams on 7/15/23.
//

import Foundation


// A progressed planet carries 0.5 of its birthchart power

// majorProgressedPlanetPower = natalPower * 0.5
// subMajorProgressedPlanetPower = natalMoon * 0.07
// minorProgressedPlanetPower = natalPower * 0.018
// transitPlanetPower = natalMoon * 0.00274


// majorProgressed aspectPower = ((celestialObject1PWR * celestialObject1PWR) / 2) * progressedAspectPercentage
// majorProgressed aspectPowerOfMoon = (((celestialObject1PWR * celestialObject1PWR) / 2) * progressedAspectPercentage) / 7
// minorProgressed aspectPower = (((celestialObject1PWR * celestialObject1PWR) / 2) * progressedAspectPercentage) / 27.3
// minorProgressed aspectPower = (((celestialObject1PWR * celestialObject1PWR) / 2) * progressedAspectPercentage) / 365.25

//Major Progressed Aspects to otherPlanets = 4 terminals
//Major Progressed Aspects to self = 2 terminals
//Minor Progressed Aspects to otherPlanets = 3 terminals
//Transit Progressed Aspects to otherPlanets = 3 terminals

// The 2 planets making the progressed aspect receive the full progressed power, harmony and discord of the progressed aspect
// This same amount of power is also added to the houses and signs where the aspecting planets are located.

// The planets, signs and houses of the other terminals receive half the power from the aspect

// Each sign and house ruled by the two planets involved in the progressed aspect, receives one-half the power and one-half the harmony or discord of the progressed aspect. If the sign is intercepted it receives one-fourth the power and one-fourth the harmony or discord of the progressed aspect.



var angular_lum1 = [0.75]
var angular_lum2 = [0.75]
var angular_lum3 = [0.75]
var angular_lum4 = [0.75]
var angular_lum5 = [0.75]


var succedent_lum1 = [0.75]
var succedent_lum2 = [0.75]
var succedent_lum3 = [0.75]
var succedent_lum4 = [0.75]
var succedent_lum5 = [0.75]

var cadent_lum1 = [0.75]
var cadent_lum2 = [0.75]
var cadent_lum3 = [0.75]
var cadent_lum4 = [0.75]
var cadent_lum5 = [0.75]

var angular_reg1 = [0.75]
var angular_reg2 = [0.75]
var angular_reg3 = [0.75]
var angular_reg4 = [0.75]
var angular_reg5 = [0.75]

var succedent_reg1 = [0.75]
var succedent_reg2 = [0.75]
var succedent_reg3 = [0.75]
var succedent_reg4 = [0.75]
var succedent_reg5 = [0.75]

var cadent_reg1 = [0.75]
var cadent_reg2 = [0.75]
var cadent_reg3 = [0.75]
var cadent_reg4 = [0.75]
var cadent_reg5 = [0.75]


