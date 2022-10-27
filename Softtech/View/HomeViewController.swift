import UIKit

class HomeViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureSubviews()
        setupConstraints()
    }
    
    // MARK: - Setup functions
    
    /// Settings of button component.
    /// - Parameters:
    ///     - buttonText: title of button.
    private func setupButton(buttonText: String) {
        let customButton: UIButton = {
            let button = UIButton()
            button.setTitle(buttonText, for: .normal)
            button.backgroundColor = .brown
            button.setTitleColor(.white, for: .normal)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 50)
                ])
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        stackView.addArrangedSubview(customButton)
    }

    /// Settings of label component.
    /// - Parameters:
    ///     - labelText: text of label.
    private func setupLabel(labelText: String) {
        let customLabel: UILabel = {
            let label = UILabel()
            label.text = labelText
            label.textColor = .systemBlue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        stackView.addArrangedSubview(customLabel)
    }

    /// Settings of textField component.
    /// - Parameters:
    ///     - placeholder: placeholder for text field.
    private func setupTextField(placeholder: String) {
        let customTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = placeholder
            textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            textField.font = UIFont.systemFont(ofSize: 15)
            textField.borderStyle = UITextField.BorderStyle.roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        stackView.addArrangedSubview(customTextField)
    }
    
    /// Add subviews.
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }

    /// Configure constraints.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
            ])
    }


}
