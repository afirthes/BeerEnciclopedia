import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String

    let ingredients: Ingredients
    let foodPairing: [String]
}

struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

struct Hop: Codable {
    let name: String
    let amount: BoilVolume
    let add, attribute: String
}

struct Malt: Codable {
    let name: String
    let amount: BoilVolume
}

struct Method: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
}

struct Fermentation: Codable {
    let temp: BoilVolume
}

struct MashTemp: Codable {
    let temp: BoilVolume
    let duration: Int
}

struct BoilVolume: Codable {
    let value: Double
    let unit: String
}
