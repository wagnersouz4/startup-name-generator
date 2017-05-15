//
//  NameGenerator.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 14/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import Foundation

struct NameGenerator {
    static func generate(using words: String?, appDelegate: AppDelegate) -> [StartupName] {
        let favorites = StartupName.loadFavorites(using: appDelegate)
        return favorites + generateRandom(words)
    }

    /// Using a free resource contaning portuguese words.
    /// See more details at: https://www.ime.usp.br/~ueda/br.ispell/
    private static func loadPortugueseWords() -> [String] {
        if let url = Bundle.main.url(forResource: "E", withExtension: "ispell") {

            do {
                let data = try Data(contentsOf: url)
                if let words = String(bytes: data, encoding: .isoLatin1)?.components(separatedBy: "\n") {
                    return words
                }
            } catch let error as NSError {
                print("Error while opening E.ispell file: \(error.description)")
            }
        }
        return []
    }

    private static func generateRandom(_ seed: String?) -> [StartupName] {
        var randomNames = [StartupName]()
        let words = NameGenerator.loadPortugueseWords()
        let wordsCount = words.count

        var seedWords = [String]()
        var seedWordsCount = 0
        if let seed = seed {
            seedWords = seed.components(separatedBy: " ")
            seedWordsCount = seedWords.count
        }

        // Generating random names using the seeds if available
        for _ in 0...9 {
            let prefixIndex = Int(arc4random_uniform(UInt32(wordsCount)))
            let suffixIndex = Int(arc4random_uniform(UInt32(wordsCount)))

            var root = ""

            if !seedWords.isEmpty {
                let index = Int(arc4random_uniform(UInt32(seedWordsCount)))
                root = seedWords[index]
            }

            randomNames.append(StartupName(
                description: "\(words[prefixIndex].capitalized) \(root.capitalized) \(words[suffixIndex].capitalized)"))
        }

        return randomNames
    }
}
