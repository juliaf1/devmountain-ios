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
    
    func spendGold(_ amount: Double) {
        vaultGoldVolume -= amount
    }
    
    func storeGold(_ amount: Double) {
        vaultGoldVolume += amount
    }
}

struct DiagonAlley {
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
}

var julia = Wizard(firstName: "Julia", lastName: "Granger", age: 24, birthday: "10/20/1997", preferredWandLength: 12, preferredHouse: "Ravenclaw", trait: .loyal, tiredOfHarryPotterReferences: false, vaultGoldVolume: 150.0)

DiagonAlley.buyWandAtOllivanders(wizard: julia, amount: 24.3)

DiagonAlley.buyRobesAtMadamMalkins(wizard: julia, amount: 45)

DiagonAlley.receiveGoldFromLongLostRelative(wizard: julia, amount: 300)

DiagonAlley.receiveGoldPlayingWizardDice(wizard: julia)

DiagonAlley.buySuspiciousArtefactsAtBorginBurkes(wizard: julia, deal: 10)
