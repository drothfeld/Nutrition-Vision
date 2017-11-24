//
//  DailyNutritionValues.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/21/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

let sodium = NutritionValue(name: "Sodium", units: "(mg)", dailyMax: 2400, source: sourceURL[fda_gov_nutrition])
let cholesterol = NutritionValue(name: "Cholesterol", units: "(mg)", dailyMax: 300, source: sourceURL[fda_gov_nutrition])
let total_carbohydrate = NutritionValue(name: "Total Carbohydrate", units: "(g)", dailyMax: 300, source: sourceURL[fda_gov_nutrition])
let dietary_fiber = NutritionValue(name: "Dietary Fiber", units: "(g)", dailyMax: 25, source: sourceURL[fda_gov_nutrition])
let saturated_fat = NutritionValue(name: "Saturated Fat", units: "(g)", dailyMax: 20, source: sourceURL[fda_gov_nutrition])
let total_fat = NutritionValue(name: "Total Fat", units: "(g)", dailyMax: 65, source: sourceURL[fda_gov_nutrition])
let sugar = NutritionValue(name: "Sugar", units: "(g)", dailyMax: 32, source: sourceURL[aha_dietary_sugar_intake])
let protein = NutritionValue(name: "Protein", units: "(g)", dailyMax: 50, source: sourceURL[fda_gov_nutrition])
