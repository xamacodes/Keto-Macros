//By Sena A using data from Food Data Central
/*
 
 
 
 
 
 
 */

import Foundation

struct FoodDataCentral: Decodable {
    let foodSearchCriteria: FoodInfo
    let totalHits: Int
    let currentPage: Int
    let totalPages: Int
    let foods: [Food]
}

struct FoodInfo: Decodable {
    let query: String
    let generalSearchInput: String
    let pageNumber: Int
    let requireAllWords: Bool
}

struct Food: Decodable {
    let fdcId: Int
    let description: String
    let dataType: String
    let gtinUpc: String?
    let publishedDate: String
    let brandOwner: String?
    let ingredients: String?
    let foodNutrients: [FoodNutrients]
    
    enum CodingKeys: String, CodingKey {
        case fdcId = "fdcId"
        case description = "description"
        case dataType, gtinUpc, publishedDate, brandOwner, ingredients, foodNutrients
    }
}

struct FoodNutrients: Decodable {
    let nutrientId: Int
    let nutrientName: String
    let nutrientNumber: String
    let unitName: String
    let derivationCode: String?
    let derivationDescription: String?
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case nutrientId = "nutrientId"
        case nutrientName = "nutrientName"
        case nutrientNumber, unitName, derivationCode, derivationDescription, value
    }
}

enum NutrientNames: String, Decodable {
    case calciumCA = "Calcium, Ca"
    case carbohydrateByDifference = "Carbohydrate, by difference"
    case cholesterol = "Cholesterol"
    case energy = "Energy"
    case fattyAcidsTotalMonounsaturated = "Fatty acids, total monounsaturated"
    case fattyAcidsTotalPolyunsaturated = "Fatty acids, total polyunsaturated"
    case fattyAcidsTotalSaturated = "Fatty acids, total saturated"
    case fattyAcidsTotalTrans = "Fatty acids, total trans"
    case fiberTotalDietary = "Fiber, total dietary"
    case ironFe = "Iron, Fe"
    case niacin = "Niacin"
    case potassiumK = "Potassium, K"
    case protein = "Protein"
    case riboflavin = "Riboflavin"
    case sodiumNa = "Sodium, Na"
    case sugarsTotalIncludingNLEA = "Sugars, total including NLEA"
    case thiamin = "Thiamin"
    case totalLipidFat = "Total lipid (fat)"
    case vitaminAIU = "Vitamin A, IU"
    case vitaminCTotalAscorbicAcid = "Vitamin C, total ascorbic acid"
    case vitaminDD2D3InternationalUnits = "Vitamin D (D2 + D3), International Units"
}
