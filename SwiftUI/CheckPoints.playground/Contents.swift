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
