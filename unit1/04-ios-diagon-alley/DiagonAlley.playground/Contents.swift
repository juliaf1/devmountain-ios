import Foundation

enum Trait {
    case brave, loyal, ambitious, intelligent
}

class Wizard {
    let firstName: String
    let lastName: String
    var age: Int
    let birthday: String
    var preferredWandLength: Double
    var preferredHouse: String
    var trait: Trait
    var tiredOfHarryPotterReferences: Bool
    
    var vaultGoldVolume: Double {
        didSet {
            print("Now you have \(vaultGoldVolume) galleons.\n")
        }
    }
    
    var name: String {
        "\(firstName) \(lastName)"
    }
    
    init(firstName: String, lastName: String, age: Int, birthday: String, preferredWandLength: Double, preferredHouse: String, trait: Trait, tiredOfHarryPotterReferences: Bool, vaultGoldVolume: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.birthday = birthday
        self.preferredWandLength = preferredWandLength
        self.preferredHouse = preferredHouse
        self.trait = trait
        self.tiredOfHarryPotterReferences = tiredOfHarryPotterReferences
        self.vaultGoldVolume = vaultGoldVolume
    }
    
    func sortingHat() {
        print("You begin to daydream about the four houses of Hogwarts. Slytherin for the cunning and ambitious, Gryffindor for the brave, Hufflepuff for the Loyal, and Ravenclaw for those with great wit. What could be the specific thought process and logic which the sorting hat employs in order to appropriately place students?")
        
        var chosenHouse: String {
            switch self.trait {
                case .loyal: return "Hufflepuff"
                case .intelligent: return "Ravenclaw"
                case .ambitious: return "Slytherin"
                case .brave: return "Gryffindor"
            }
        }

        print("\(name), you are a very \(trait) wizard. You belong in \(chosenHouse)!\n")
    }
}

protocol Gringotes {
    var vaultGoldVolume: Double { get set }
    
    mutating func spendGold(_ amount: Double)
    mutating func storeGold(_ amount: Double)
    func hasEnoughFundsFor(_ amount: Double) -> Bool
}

protocol DiagonAlley: Gringotes {
    var honeydukesPrices: [String: Double] { get }
    var brooms: [[String: String]] { get }
    var owls: [[String: String]] { get }
    var bookPrices: [Int] { get }
    
    mutating func buyWandAtOllivanders(amount: Double)
    mutating func buyRobesAtMadamMalkins(amount: Double)
    mutating func receiveGoldFromLongLostRelative(amount: Double)
    mutating func doubleFortunePlayingWizardDice()
    mutating func buySuspiciousArtefactsAtBorginBurkes(deal: Int)
    mutating func buyChocolateFrogsAtHoneydukes(units: Int)
    mutating func buyFizzingWhizzbeesAtHoneydukes(units: Int)
    mutating func spendFortuneInPixiePuffs()

    func chooseOwl(beakColor: String, feathersColor: String)
    func chooseBroom(team: String)
    func browseBooks()
}

extension Wizard: Gringotes {
    func spendGold(_ amount: Double) {
        vaultGoldVolume -= amount
    }
    
    func storeGold(_ amount: Double) {
        vaultGoldVolume += amount
    }
    
    func hasEnoughFundsFor(_ amount: Double) -> Bool {
        if vaultGoldVolume < amount {
            print("You don't have enough gold to buy this wand...\n")
            return false
        } else {
            return true
        }
    }
}

extension Wizard: DiagonAlley {
    var honeydukesPrices: [String : Double] {
        ["fizzingWhizzbees": 2, "chocolateFrog": 3, "pixiePuffs": 3]
    }
    
    var brooms: [[String : String]] {
        [
            ["sponsor": "Chudley Cannons"],
            ["sponsor": "Falmouth Falcons"],
            ["sponsor": "The Holyhead Harpies"],
            ["sponsor": "Bigonville Bombers"]
        ]
    }
    
    var owls: [[String : String]] {
        [
            ["beak": "brown", "feathers": "white"],
            ["beak": "black", "feathers": "brown"],
            ["beak": "black", "feathers": "black"],
            ["beak": "black", "feathers": "white"]
        ]
    }
    
    var bookPrices: [Int] {
        [12, 15, 22, 10, 8, 17]
    }
    
    func buyWandAtOllivanders(amount: Double) {
        print("You walk into Ollivanders to buy your first wand. The cost is \(amount) galleons.\n")

        if hasEnoughFundsFor(amount) {
            spendGold(amount)
            print("Ready to do some magic with this spetacullar wand?\n")
        }
    }
    
    func buyRobesAtMadamMalkins(amount: Double) {
        print("You walk into Madam Malkin’s Robes for All Occasions. You purchase a set of robes that cost you a flat \(amount) galleons.\n")

        if hasEnoughFundsFor(amount) {
            spendGold(amount)
            print("Brilliant! That's a fine set of robes you just got!\n")
        }
    }
    
    func receiveGoldFromLongLostRelative(amount: Double) {
        print("As you walk past Gringotts Wizarding Bank you are stopped by a very excited Goblin who explains that they’ve been waiting for you. A long lost relative left you some gold to be used on your first day. You earned \(amount) galleons.\n")

        storeGold(amount)
        print("Oh isn't it a pleasent surprise... Enjoy your gold...\n")
    }
    
    func doubleFortunePlayingWizardDice() {
        print("As you move along Diagon Alley you hear some noise down Knockturn Alley. A group of Slytherins are playing Wizard dice. You play a few rounds and double the gold in your purse.\n")

        storeGold(vaultGoldVolume)
        print("You are either very lucky or incredibly good at this Wizard Dice. Good luck next time.\n")
    }
    
    func buySuspiciousArtefactsAtBorginBurkes(deal: Int) {
        print("With your purse bursting at the seams you walk into Borgin and Burkes. You inquire about a pack of bloodstained cards and he says he will give it to you for 1/\(deal) of all the gold in your pocket.\n")

        spendGold(vaultGoldVolume / Double(deal))
        print("You are lucky you got this rare piece today...\n")
    }
    
    func buyChocolateFrogsAtHoneydukes(units: Int) {
        print("There's no better place than Honeydukes to get your chocolate frogs.\n")

        let totalPrice = honeydukesPrices["chocolateFrog"]! * Double(units)

        if hasEnoughFundsFor(totalPrice) {
            spendGold(totalPrice)
            print("I bet you got Dumbledore's card!\n")
        }
    }
    
    func buyFizzingWhizzbeesAtHoneydukes(units: Int) {
        print("The Fizzing Whizzbees at Honeydukes are the best - you can't leave without one of those!\n")
        let totalPrice = honeydukesPrices["fizzingWhizzbees"]! * Double(units)

        if hasEnoughFundsFor(totalPrice) {
            spendGold(totalPrice)
            print("There you go, have fun with your treat!\n")
        }
    }
    
    func spendFortuneInPixiePuffs() {
        print("You realize you still have money in your vault, and it doesn’t do you any good there. So you decide to head back to Honeydukes to load up on as many Pixie Puffs as you can get.\n")

        let price = honeydukesPrices["pixiePuffs"]!
        let totalPixiePuffs = floor(vaultGoldVolume / price)

        spendGold(totalPixiePuffs * price)
        print("You got \(Int(totalPixiePuffs)) Pixie Puffs!\n")
    }
    
    func chooseOwl(beakColor: String, feathersColor: String) {
        print("I'm looking for an owl with \(beakColor) beak and \(feathersColor) feathers")

        for owl in owls {
            if owl["beak"]! == beakColor && owl["feathers"]! == feathersColor {
                print("This one's mine!\n")
            } else {
                print("Pass")
            }
        }
    }
    
    func chooseBroom(team: String) {
        print("I heard that my favorite Quidditch team, \(team), suggests a certain type of Broom. So, I will only buy a broom if it is sponsored by them!")

        for broom in brooms {
            if broom["sponsor"]! == team {
                print("Brilliant, this broom amazing!\n")
            }
        }
    }
    
    func browseBooks() {
        for (index, price) in bookPrices.enumerated() {
            if price < 15 {
                print("This book isn’t too bad.\(index == bookPrices.count - 1 ? "\n" : "")")
            } else {
                print("This book is expensive!\(index == bookPrices.count - 1 ? "\n" : "")")
            }
        }
    }
}

var julia = Wizard(firstName: "Julia", lastName: "Granger", age: 24, birthday: "10/20/1997", preferredWandLength: 12, preferredHouse: "Ravenclaw", trait: .loyal, tiredOfHarryPotterReferences: false, vaultGoldVolume: 150.0)

julia.buyWandAtOllivanders(amount: 24.3)
julia.buyRobesAtMadamMalkins(amount: 45)
julia.receiveGoldFromLongLostRelative(amount: 300)
julia.doubleFortunePlayingWizardDice()
julia.buySuspiciousArtefactsAtBorginBurkes(deal: 10)
julia.buyFizzingWhizzbeesAtHoneydukes(units: 3)
julia.buyChocolateFrogsAtHoneydukes(units: 5)
julia.chooseOwl(beakColor: "black", feathersColor: "white")
julia.chooseBroom(team: "The Holyhead Harpies")
julia.sortingHat()
julia.browseBooks()
julia.spendFortuneInPixiePuffs()
