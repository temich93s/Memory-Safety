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
