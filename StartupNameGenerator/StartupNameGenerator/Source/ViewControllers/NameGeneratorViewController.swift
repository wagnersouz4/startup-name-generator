//
//  NameGeneratorViewController.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit
import Toaster

class NameGeneratorViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    fileprivate var generator: Generator!
    fileprivate var generatedNames = [StartupName]()

    override func viewDidLoad() {
        setupTableView()
        configureToast()
    }

    private func configureToast() {
        ToastView.appearance().font = TypographyHelper.generateFont(using: .title3, with: .bold)
    }

    private func setupTableView() {
        // Registering nib file
        let favoriableNib = FavoritableTableViewCell.nib
        tableView.register(favoriableNib, forCellReuseIdentifier: FavoritableTableViewCell.identifier)
        tableView.dataSource = self
    }
}

// Mark: @IBActions
extension NameGeneratorViewController {
    @IBAction private func generateNames() {
        if generator == nil {
            generator = Generator()
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error while obtaining the app delegate")
        }

        // Refactor to use NSOrderedSet to improve performance
        for startupName in generator.generateNames(using: textField.text, appDelegate: appDelegate) {
            if !generatedNames.contains(startupName) {
                generatedNames.append(startupName)
            }
        }

        tableView.reloadData()
    }

    @IBAction private func cleanNames() {
        generatedNames = generatedNames.filter { $0.isFavorited == true }
        tableView.reloadData()
    }
}

/// Controlling the FavoritableTableViewCell's button click
extension NameGeneratorViewController: FavoritableTableViewCellButtonDelegate {
    func didPressButton(_ sender: IndexedUIButton) {
        // Only if the name has not been added as favorite

        if !generatedNames[sender.indexPath.row].isFavorited {
            generatedNames[sender.indexPath.row].isFavorited = true
            tableView.reloadRows(at: [sender.indexPath], with: .fade)

            let name = generatedNames[sender.indexPath.row]
            addToFavorites(name)
        }
    }

    private func addToFavorites(_ startupName: StartupName) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error while obtaining the app delegate")
        }

        if StartupName.addAsFavorite(startupName, using: appDelegate) {
            showToast(using: startupName)
        }
    }

    private func showToast(using startupName: StartupName) {
        ToastCenter.default.cancelAll()
        let toast = Toast(text: "\(startupName.description) foi adicionado como favorito.", duration: Delay.short)
        toast.show()
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
        cell.setup(with: name, indexPath: indexPath)

        if cell.buttonDelegate == nil {
            cell.buttonDelegate = self
        }

        return cell
    }
}
