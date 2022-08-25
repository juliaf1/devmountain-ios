import Foundation

enum Trait {
    case brave, loyal, ambitious, intelligent
}

protocol Gringotes {
    mutating func spendGold(_ amount: Double)
    mutating func storeGold(_ amount: Double)
}

class Wizard: Gringotes {
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
    
    func spendGold(_ amount: Double) {
        vaultGoldVolume -= amount
    }
    
    func storeGold(_ amount: Double) {
        vaultGoldVolume += amount
    }
}

struct DiagonAlley {
    enum HoneydukesPrices {
        static let fizzingWhizzbees: Double = 2
        static let chocolateFrog: Double = 3
        static let pixiePuffs: Double = 3
    }

    static let owls = [["beak": "brown", "feathers": "white"], ["beak": "black", "feathers": "brown"], ["beak": "black", "feathers": "black"], ["beak": "black", "feathers": "white"]]
    
    static let brooms = [["sponsor": "Chudley Cannons"], ["sponsor": "Falmouth Falcons"], ["sponsor": "The Holyhead Harpies"], ["sponsor": "Bigonville Bombers"]]
    
    static let bookPrices = [12, 15, 22, 10, 8, 17]

    static func buyWandAtOllivanders(wizard: Wizard, amount: Double) {
        print("You walk into Ollivanders to buy your first wand. The cost is \(amount) galleons.\n")

        if hasEnoughFunds(wizard: wizard, amount: amount) {
            wizard.spendGold(amount)
            print("Ready to do some magic with this spetacullar wand?\n")
        }
    }
    
    static func buyRobesAtMadamMalkins(wizard: Wizard, amount: Double) {
        print("You walk into Madam Malkin’s Robes for All Occasions. You purchase a set of robes that cost you a flat \(amount) galleons.\n")

        if hasEnoughFunds(wizard: wizard, amount: amount) {
            wizard.spendGold(amount)
            print("Brilliant! That's a fine set of robes you just got!\n")
        }
    }
    
    static func receiveGoldFromLongLostRelative(wizard: Wizard, amount: Double) {
        print("As you walk past Gringotts Wizarding Bank you are stopped by a very excited Goblin who explains that they’ve been waiting for you. A long lost relative left you some gold to be used on your first day. You earned \(amount) galleons.\n")

        wizard.storeGold(amount)
        print("Oh isn't it a pleasent surprise... Enjoy your gold...\n")
    }
    
    static func receiveGoldPlayingWizardDice(wizard: Wizard) {
        print("As you move along Diagon Alley you hear some noise down Knockturn Alley. A group of Slytherins are playing Wizard dice. You play a few rounds and double the gold in your purse.\n")
        
        wizard.storeGold(wizard.vaultGoldVolume)
        print("You are either very lucky or incredibly good at this Wizard Dice. Good luck next time.\n")
    }
    
    static func buySuspiciousArtefactsAtBorginBurkes(wizard: Wizard, deal: Int) {
        print("With your purse bursting at the seams you walk into Borgin and Burkes. You inquire about a pack of bloodstained cards and he says he will give it to you for 1/\(deal) of all the gold in your pocket.\n")
    
        wizard.spendGold(wizard.vaultGoldVolume / Double(deal))
        print("You are lucky you got this rare piece today...\n")
    }
    
    static func hasEnoughFunds(wizard: Wizard, amount: Double) -> Bool {
        if wizard.vaultGoldVolume < amount {
            print("You don't have enough gold to buy this wand...\n")
            return false
        } else {
            return true
        }
    }
    
    static func buyChocolateFrogsAtHoneydukes(wizard: Wizard, units: Int) {
        print("There's no better place than Honeydukes to get your chocolate frogs.\n")
        
        let totalPrice = HoneydukesPrices.chocolateFrog * Double(units)

        if hasEnoughFunds(wizard: wizard, amount: totalPrice) {
            wizard.spendGold(totalPrice)
            print("I bet you got Dumbledore's card!\n")
        }
    }
    
    static func buyfizzingWhizzbeesAtHoneydukes(wizard: Wizard, units: Int) {
        print("The Fizzing Whizzbees at Honeydukes are the best - you can't leave without one of those!\n")
        
        let totalPrice = HoneydukesPrices.fizzingWhizzbees * Double(units)

        if hasEnoughFunds(wizard: wizard, amount: totalPrice) {
            wizard.spendGold(totalPrice)
            print("There you go, have fun with your treat!\n")
        }
    }
    
    static func spendFortuneInPixiePuffs(wizard: Wizard) {
        print("You realize you still have money in your vault, and it doesn’t do you any good there. So you decide to head back to Honeydukes to load up on as many Pixie Puffs as you can get.\n")
        
        let price = HoneydukesPrices.pixiePuffs
        let totalPixiePuffs = floor(wizard.vaultGoldVolume / price)
        
        wizard.spendGold(totalPixiePuffs * price)
        print("You got \(Int(totalPixiePuffs)) Pixie Puffs!\n")
    }
    
    static func chooseOwl(beakColor: String, feathersColor: String) {
        print("I'm looking for an owl with \(beakColor) beak and \(feathersColor) feathers")
        
        for owl in owls {
            if owl["beak"]! == beakColor && owl["feathers"]! == feathersColor {
                print("This one's mine!\n")
            } else {
                print("Pass")
            }
        }
    }
    
    static func chooseBroom(team: String) {
        print("I heard that my favorite Quidditch team, \(team), suggests a certain type of Broom. So, I will only buy a broom if it is sponsored by them!")

        for broom in brooms {
            if broom["sponsor"]! == team {
                print("Brilliant, this broom amazing!\n")
            }
        }
    }
    
    static func browseBooks() {
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

DiagonAlley.buyWandAtOllivanders(wizard: julia, amount: 24.3)

DiagonAlley.buyRobesAtMadamMalkins(wizard: julia, amount: 45)

DiagonAlley.receiveGoldFromLongLostRelative(wizard: julia, amount: 300)

DiagonAlley.receiveGoldPlayingWizardDice(wizard: julia)

DiagonAlley.buySuspiciousArtefactsAtBorginBurkes(wizard: julia, deal: 10)

DiagonAlley.buyfizzingWhizzbeesAtHoneydukes(wizard: julia, units: 3)

DiagonAlley.buyChocolateFrogsAtHoneydukes(wizard: julia, units: 5)

DiagonAlley.chooseOwl(beakColor: "black", feathersColor: "white")

DiagonAlley.chooseBroom(team: "The Holyhead Harpies")

julia.sortingHat()

DiagonAlley.browseBooks()

DiagonAlley.spendFortuneInPixiePuffs(wizard: julia)
