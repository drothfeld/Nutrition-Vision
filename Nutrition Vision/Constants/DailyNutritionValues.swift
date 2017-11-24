//
//  DailyNutritionValues.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/21/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

let sodium_dv = NutritionValue(name: "Sodium", units: "(mg)", dailyMax: 2400, source: sourceURL[fda_gov_nutrition])
let cholesterol_dv = NutritionValue(name: "Cholesterol", units: "(mg)", dailyMax: 300, source: sourceURL[fda_gov_nutrition])
let total_carbohydrate_dv = NutritionValue(name: "Total Carbohydrate", units: "(g)", dailyMax: 300, source: sourceURL[fda_gov_nutrition])
let dietary_fiber_dv = NutritionValue(name: "Dietary Fiber", units: "(g)", dailyMax: 25, source: sourceURL[fda_gov_nutrition])
let saturated_fat_dv = NutritionValue(name: "Saturated Fat", units: "(g)", dailyMax: 20, source: sourceURL[fda_gov_nutrition])
let total_fat_dv = NutritionValue(name: "Total Fat", units: "(g)", dailyMax: 65, source: sourceURL[fda_gov_nutrition])
let sugar_dv = NutritionValue(name: "Sugar", units: "(g)", dailyMax: 32, source: sourceURL[aha_dietary_sugar_intake])
let protein_dv = NutritionValue(name: "Protein", units: "(g)", dailyMax: 50, source: sourceURL[fda_gov_nutrition])
