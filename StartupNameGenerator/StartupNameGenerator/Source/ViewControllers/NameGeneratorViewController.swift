//
//  NameGeneratorViewController.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

class NameGeneratorViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    fileprivate var generator: Generator!
    fileprivate var generatedNames: [Name]!

    override func viewDidLoad() {
        setupTableView()
        generateNames()
    }

    private func generateNames() {
        if generator == nil {
            generator = Generator()
        }
        generatedNames = generator.generateNames()
    }

    private func setupTableView() {
        // Registering nib file
        let favoriableNib = FavoritableTableViewCell.nib
        tableView.register(favoriableNib, forCellReuseIdentifier: FavoritableTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension NameGeneratorViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generatedNames.count

    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: FavoritableTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: FavoritableTableViewCell.identifier, for: indexPath)

        let name = generatedNames[indexPath.row]
        cell.setup(with: name)

        return cell
    }
}

extension NameGeneratorViewController: UITableViewDelegate {

}
