import UIKit

class HomeViewController: UIViewController {
    var choices: [String] = []
    private var viewModel = HomeViewModel()
    let screenSize: CGRect = UIScreen.main.bounds

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

    private lazy var pickerTextField: UITextField = {
        let textField = UITextField()
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSubviews()
        setupConstraints()
        getCustomViews()
    }
    
    /// Read json file and create custom view.
    private func getCustomViews() {
        let customViews: [CustomView]? = viewModel.fetchData(filename: "customViewJson")
        guard let customViews = customViews else { return }
        
        for customView in customViews {
            switch customView.customViewType {
            case ViewType.button.rawValue:
                setupButton(buttonText: customView.properties?.text ?? "")
            case ViewType.label.rawValue:
                setupLabel(labelText: customView.properties?.text ?? "")
            case ViewType.textField.rawValue:
                setupTextField(placeholder: customView.properties?.header ?? "")
            case ViewType.picker.rawValue:
                setupPickerView(placeholder: customView.properties?.header ?? "", options: customView.properties?.text ?? "")
            default:
                print("Default")
            }
        }
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
    
    /// Settings of pickerView component.
    /// - Parameters:
    ///     - placeholder: placeholder for text field.
    ///     - options: options of picker view.
    private func setupPickerView(placeholder: String ,options: String) {
        choices = viewModel.refactorJsonString(jsonText: options)
        pickerTextFieldSettings()
        stackView.addArrangedSubview(pickerTextField)
            let pickerView = UIPickerView()
            pickerTextField.inputView = pickerView
            pickerTextField.placeholder = placeholder
            pickerView.backgroundColor = .systemGray3
            pickerView.selectRow(0, inComponent: 0, animated: true)
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Settings of pickerTextField component.
    private func pickerTextFieldSettings() {
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(systemName: "chevron.down")
        imageIcon.tintColor = .systemGray
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "chevron.down")!.size.width, height: UIImage(systemName: "chevron.down")!.size.height)
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "chevron.down")!.size.width, height: UIImage(systemName: "chevron.down")!.size.height)
        pickerTextField.rightView = contentView
        pickerTextField.rightViewMode = .always
        pickerTextField.delegate = self
        pickerTextField.tintColor = .clear
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

// MARK: - HomeViewController Extension
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = choices[row]
        pickerTextField.resignFirstResponder()
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
