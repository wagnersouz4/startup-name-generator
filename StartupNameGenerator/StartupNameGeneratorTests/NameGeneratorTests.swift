//
//  NameGeneratorTests.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 15/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import StartupNameGenerator

class NameGeneratorTests: QuickSpec {
    override func spec() {
        it("Generate random startup names") {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return fail()
            }
            let names = NameGenerator.generate(using: "Test", appDelegate: appDelegate)
            expect(names) != []
        }
    }
}
