import UIKit

let celsius: Double = 3.12

let fahrenheit: Double = celsius * 9 / 5 + 32

// print("\(celsius) C° = \(fahrenheit)F°")

let arrayOfStrings = ["Bonjour", "Bonjour", "Hello", "Hola"]
// print("Number of items: \(arrayOfStrings.count)")
// print("Number of unique items: \(Set(arrayOfStrings).count)")

for i in 1...100 {
    let isMultipleOf3 = i.isMultiple(of: 3)
    let isMultipleOf5 = i.isMultiple(of: 5)
    if isMultipleOf3 && isMultipleOf5 {
        print("FizzBuzz")
    } else if isMultipleOf5 {
        print("Buzz")
    } else if isMultipleOf3 {
        print("Fizz")
    } else {
        print(i)
    }
}

enum SquareRootError: Error {
    case outOfBounds, noRoot
}

func findSquareRoot(of number: Int) throws -> Int {
    guard number >= 1 && number <= 10000 else {
        throw SquareRootError.outOfBounds
    }
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
    throw SquareRootError.noRoot
}

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let luckyArray = luckyNumbers.filter { !$0.isMultiple(of: 2)}.sorted().map {
    "\($0) is a lucky number"
}

for elt in luckyArray {
    print(elt)
}

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear: Int = 1
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func incrementGear() {
        currentGear += 1
        if currentGear > 10 {
            currentGear = 10
        }
    }
    
    mutating func decrementGear() {
        currentGear -= 1
        if currentGear < 1 {
            currentGear = 1
        }
    }
}

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }
    
    func speak() {
        print("Whaouf")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Corgi Whaouf")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Poodle Waouf")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("Miaou")
    }
}

class Persian: Cat {
    override func speak() {
        print("Persian Miaou")
    }
}

class Lion: Cat {
    override func speak() {
        print("Lion miaou")
    }
}

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var estateAgent: String { get }
    
    func summary()
}

extension Building {
    func summary() {
        print("\(rooms) rooms at the cost of $\(cost), please contact \(estateAgent)")
    }
}

struct House: Building {
    var rooms: Int
    
    var cost: Int
    
    var estateAgent: String
    
    func summary() {
        print("House with \(rooms) rooms at the cost of $\(cost), please contact \(estateAgent)")
    }
}

struct Office: Building {
    var rooms: Int
    
    var cost: Int
    
    var estateAgent: String
    
    func summary() {
        print("Office with \(rooms) rooms at the cost of $\(cost), please contact \(estateAgent)")
    }
}

func randomArray(array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}
