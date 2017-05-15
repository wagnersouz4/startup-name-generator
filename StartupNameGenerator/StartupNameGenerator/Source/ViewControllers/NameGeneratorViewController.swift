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

    fileprivate var data = [(name: StartupName, highlight: Bool)]()
    fileprivate weak var appDelegate: AppDelegate!

    override func viewDidLoad() {
        setAppDelegate()
        setupTableView()
        loadInitialData()
        configureToast()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }

    private func setAppDelegate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error while obtaining the app delegate")
        }
        self.appDelegate = appDelegate
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

    private func loadInitialData() {
        data = StartupName.loadFavorites(using: appDelegate).map { (name: $0, hightlight: true) }
    }
}

// Mark: @IBActions
extension NameGeneratorViewController {
    @IBAction private func generateNames() {
        // As the generatedNames is a list of tuples (startupName, highlighted), 
        // a map is needed in order to obtain only the startupName
        var previousGeneratedNames = data.map { $0.name }

        // As the favorited names should appear first, they must be removed from the previous generated names
        previousGeneratedNames = previousGeneratedNames.filter { $0.isFavorited == false }

        var newGeneratedNames = NameGenerator.generate(using: textField.text, appDelegate: appDelegate)

        // Removing duplicates
        for i in 0..<newGeneratedNames.count {
            if previousGeneratedNames.contains(newGeneratedNames[i]) {
                newGeneratedNames.remove(at: i)
            }
        }

        // Creating a new list of generated names highlighting only the new and the already favorited ones
        data = newGeneratedNames.map { (name: $0, highlight: true) }
            + previousGeneratedNames.map { (name: $0, highlight: false) }

        tableView.reloadData()
    }

    @IBAction private func cleanNames() {
        data = StartupName.loadFavorites(using: appDelegate).map { (name: $0, highlight: true) }
        tableView.reloadData()
    }
}

/// Controlling the FavoritableTableViewCell's button click
extension NameGeneratorViewController: FavoritableTableViewCellButtonDelegate {
    func didPressButton(_ sender: IndexedUIButton) {
        // Only if the name has not been added as favorite

        if !data[sender.indexPath.row].name.isFavorited {
            data[sender.indexPath.row].name.isFavorited = true
            tableView.reloadRows(at: [sender.indexPath], with: .fade)

            let name = data[sender.indexPath.row].name
            addToFavorites(name)
        }
    }

    private func addToFavorites(_ startupName: StartupName) {
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
        return data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: FavoritableTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: FavoritableTableViewCell.identifier, for: indexPath)

        let cellData = data[indexPath.row]
        cell.setup(with: cellData.name, indexPath: indexPath, highlight: cellData.highlight)

        if cell.buttonDelegate == nil {
            cell.buttonDelegate = self
        }
        return cell
    }
}

// MARK: Keyboard and view management
extension NameGeneratorViewController {
    // Moving the view when the keyboards covers the text field
    func keyboardWillShow(_ notification: Notification) {
        // Only change the view's position in landscape mode
        guard textField.isEditing == true, view.frame.height < view.frame.width else { return }
        if let keyboardHeight = getKeyboardHeight(notification) {
            view.frame.origin.y = 0 - keyboardHeight
        }
    }

    // Restoring the frame y position when the keyboard will hide
    func keyboardWillHide() {
        view.frame.origin.y = 0
    }

    // Using the userInfo notification's property to obtain the keyboard height
    func getKeyboardHeight(_ notification: Notification) -> CGFloat? {
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect else { return nil }
        return keyboardSize.height
    }

    // Subscribing to the keyboard's willShow and willHide notification
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: .UIKeyboardWillHide, object: nil)
    }

    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}
