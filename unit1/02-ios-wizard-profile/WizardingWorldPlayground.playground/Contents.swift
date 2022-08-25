import Foundation

enum Gender {
    case female, male, nonBinary, undefined
}

struct Character {
    let firstName: String
    let lastName: String
    let birthYear: Int
    let nationality: String
    var gender: Gender
    var height: Double
    var weight: Double
    
    let muggleBorn: Bool
    let appearedInMovie: Bool
    let appearedInPrequel: Bool
    let joinedDumbledoreArmy: Bool
    let isDeathEater: Bool
    
    var name: String { "\(firstName) \(lastName)" }
}

struct FavoriteCharacter {
    let character: Character
    var importance: String
    var rating: Int {
        didSet {
            if rating > 10 { rating = 10 }
        }
    }
    var favoriteForReason: String
}

let hermyOwn = Character(firstName: "Hermione", lastName: "Granger", birthYear: 1979, nationality: "British", gender: .female, height: 165, weight: 118, muggleBorn: true, appearedInMovie: true, appearedInPrequel: false, joinedDumbledoreArmy: true, isDeathEater: false)

var myFavoriteCharacter = FavoriteCharacter(character: hermyOwn, importance: "crucial", rating: 10, favoriteForReason: "She's absolutely amazing, fearless, smart, kind and cool")

print(myFavoriteCharacter.character.name)
