//
//  FirstViewController.swift
//  Example
//
//  Created by Denis Dmitriev on 31.10.2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    enum Kind {
        case new
        case update
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var personalStackView: UIStackView!
    @IBOutlet weak var someView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var addPersonalButton: UIButton!
    
    var personal: Personal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if personal == nil {
            configure(for: .new)
        } else {
            configure(for: .update)
        }
    }
    
    @IBAction func addDataAction(_ sender: UIButton) {
        print(#function)
        let addPersonalViewController = AddPersonalViewController()
        addPersonalViewController.personalDelegate = self
        addPersonalViewController.personal = personal
        navigationController?.pushViewController(addPersonalViewController, animated: true)
    }
    
    private func configure(for kind: Kind) {
        switch kind {
        case .new:
            personalStackView.isHidden = true
            infoLabel.isHidden = false
            someView.isHidden = false
            addPersonalButton.setTitle("Ввести данные", for: .normal)
        case .update:
            personalStackView.isHidden = false
            infoLabel.isHidden = true
            someView.isHidden = true
            addPersonalButton.setTitle("Ввести новые данные", for: .normal)
        }
    }
    
    private func updatePersonal() {
        if let personal {
            fullNameLabel.text = personal.fullName
            emailLabel.text = personal.email
            telephoneLabel.text = personal.telephone
        }
    }
}

extension FirstViewController: PersonalDelegate {
    func updatePersonal(personal: Personal) {
        self.personal = personal
        updatePersonal()
    }
}
