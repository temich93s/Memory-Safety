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
