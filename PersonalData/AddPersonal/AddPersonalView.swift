//
//  AddPersonalView.swift
//  Example
//
//  Created by Denis Dmitriev on 31.10.2023.
//

import UIKit

class AddPersonalView: UIView {
    
    // MARK: - Views
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textFieldStackView,
            UIView(),
            saveButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            Self.createTextFiled(placeholder: "ИМЯ ФАМИЛИЯ", inputType: .fullName),
            Self.createTextFiled(placeholder: "ЭЛЕКТРОННАЯ ПОЧТА", inputType: .email),
            Self.createTextFiled(placeholder: "НОМЕР ТЕЛЕФОНА РФ", inputType: .telephone)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 31
        stackView.distribution = .fill
        return stackView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Design.accentColor
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.titleLabel?.font = Design.fontInter
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var fullName: String? {
        return getText(for: .fullName)
    }
    
    var email: String? {
        return getText(for: .email)
    }
    
    var telephone: String? {
        return getText(for: .telephone)
    }
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubviews()
        setupConstraints()
        addGesture() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(personal: Personal) {
        setText(for: .fullName, text: personal.fullName)
        setText(for: .email, text: personal.email)
        setText(for: .telephone, text: personal.telephone)
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func addGesture() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        addGestureRecognizer(tabGesture)
    }
    
    @objc private func dismissKeyboard(sender: UIGestureRecognizer) {
        endEditing(true)
    }
    
    private func configureSubviews() {
        addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Design.padding28),
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Design.padding28),
            contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Design.padding28),
            contentStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Design.padding28),
            
            saveButton.heightAnchor.constraint(equalToConstant: Design.size52)
        ])
        
        textFieldStackView.subviews.forEach { textFiled in
            NSLayoutConstraint.activate([
                textFiled.heightAnchor.constraint(equalToConstant: Design.size52)
            ])
        }
    }
    
    enum InputType: Int {
        case fullName, email, telephone
    }
    
    private static func createTextFiled(placeholder: String, inputType: InputType) -> UITextField {
        let textFiled = UITextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.font = Design.fontInter
        textFiled.placeholder = placeholder
        textFiled.backgroundColor = Design.accentColor
        textFiled.textColor = .black
        textFiled.leftView = UIView(frame: .init(x: 0, y: 0, width: Design.padding28, height: .zero))
        textFiled.leftViewMode = .always
        textFiled.tag = inputType.rawValue
        return textFiled
    }
    
    private func getText(for input: InputType) -> String? {
        let tag = input.rawValue
        let textField = textFieldStackView.arrangedSubviews.first(where: { $0.tag == tag })
        guard let textField = textField as? UITextField else { return nil }
        
        guard
            let text = textField.text,
            !text.isEmpty
        else { return nil }
        
        return textField.text
    }
    
    private func setText(for input: InputType, text: String) {
        let index = input.rawValue
        guard textFieldStackView.arrangedSubviews.count - 1 >= index else { return }
        if let textField = textFieldStackView.arrangedSubviews[index] as? UITextField {
            textField.text = text
        }
    }
}
