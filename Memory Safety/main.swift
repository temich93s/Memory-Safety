//
//  main.swift
//  Memory Safety
//
//  Created by 2lup on 14.10.2021.
//

import Foundation

print("Hello, World!")


//MARK: Что такое конфликт доступа к памяти
print("\n//Что такое конфликт доступа к памяти")

// Доступ к памяти с правами записи, где хранится данная переменная
var one = 1

// Доступ к памяти с правами чтения, где хранится данная переменная
print("We're number \(one)!")


//MARK: Конфликт доступа к сквозным параметрам
print("\n//Конфликт доступа к сквозным параметрам")

var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

//increment(&stepSize)
// Error: conflicting accesses to stepSize

// Создадим явную копию
var copyOfStepSize = stepSize
increment(&copyOfStepSize)
 
// Обновим оригинал
stepSize = copyOfStepSize
print(stepSize)
// stepSize равен 2

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
print(playerOneScore, playerTwoScore)
//balance(&playerOneScore, &playerOneScore)
// Ошибка: Conflicting accesses to playerOneScore


//MARK: Конфликт доступа к self в методах
print("\n//Конфликт доступа к self в методах")

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}
 
var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK
print(oscar.health, maria.health)

//oscar.shareHealth(with: &oscar)
// Ошибка: conflicting accesses to oscar


//MARK: Конфликт доступа к свойствам
print("\n//Конфликт доступа к свойствам")

var playerInformation = (health: 10, energy: 20)
//balance(&playerInformation.health, &playerInformation.energy)
// Ошибка: conflicting access to properties of playerInformation

var holly = Player(name: "Holly", health: 10, energy: 10)
//balance(&holly.health, &holly.energy)  // Ошибка

func someFunction() {
    var oscar = Player(name: "Oscar", health: 12, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
    print(oscar.health, oscar.energy)
}
someFunction()
