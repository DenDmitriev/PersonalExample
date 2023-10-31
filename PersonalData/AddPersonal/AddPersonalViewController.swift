//
//  AddPersonalViewController.swift
//  Example
//
//  Created by Denis Dmitriev on 31.10.2023.
//

import UIKit

class AddPersonalViewController: UIViewController {
    
    var personal: Personal?
    weak var personalDelegate: PersonalDelegate?
    
    var addPersonalView: AddPersonalView {
        return view as? AddPersonalView ?? AddPersonalView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddPersonalView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addActions()
    }
    
    private func addActions() {
        addPersonalView.saveButton.addTarget(self, action: #selector(saveDidTaped(sender:)), for: .touchUpInside)
    }
    
    private func configure() {
        if let personal {
            addPersonalView.configure(personal: personal)
        }
    }
    
    @objc func saveDidTaped(sender: UIButton) {
        print(#function)
        do {
            try fetchPersonalData()
            if let personal {
                personalDelegate?.updatePersonal(personal: personal)
                navigationController?.popViewController(animated: true)
            }
        } catch let error {
            if let error = error as? LocalizedError {
                showAlert(error: error)
            } else {
                showAlert(error: PersonalError.unknown)
            }
        }
    }
    
    private func showAlert(error: LocalizedError) {
        let alert = UIAlertController(title: error.errorDescription, message: error.recoverySuggestion, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    private func fetchPersonalData() throws {
        guard
            let fullName = addPersonalView.fullName,
            let email = addPersonalView.email,
            let telephone = addPersonalView.telephone
        else { throw PersonalError.empty }
        guard email.isEmail else { throw PersonalError.email }
        guard telephone.isTelephoneNumber else { throw PersonalError.telephone }
        
        personal = Personal(fullName: fullName, email: email, telephone: telephone)
    }
}
