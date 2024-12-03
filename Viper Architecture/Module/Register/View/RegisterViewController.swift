//
//  RegisterViewController.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {

    /// Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    /// Label Title
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    
    /// Text Field
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    /// Other View
    @IBOutlet weak var registerButton: Button!
    @IBOutlet weak var registerTitleLabel: UILabel!
    @IBOutlet weak var registerDescLabel: UILabel!
    @IBOutlet weak var alreadyHaveAccountTextView: UITextView!
    
    let registerSuccess = PublishRelay<Void>()
    let registerFailed = PublishRelay<Void>()
    var presenter: RegisterViewToPresenterProtocol?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        configureKeyboard()
        configureObservable()
        configureRegisterButton()
        configureRegisterDescLabel()
        configureRegisterTitleLabel()
        configureAlreadHasAccountLabel()
        
        configureTitleLabelForTextField(for: nameTitleLabel, text: TextView.name)
        configureTitleLabelForTextField(for: emailTitleLabel, text: TextView.email)
        configureTitleLabelForTextField(for: passwordTitleLabel, text: TextView.password)
        
        configureTextField(for: nameTextField)
        configureTextField(for: emailTextField)
        configureTextField(for: passwordTextField, securityTextEnable: true, clearEnable: false)
    }
    
    /// Configure `Observable`
    private func configureObservable() {
        registerSuccess.subscribe(onNext: { [weak self] in
            let alert = UIAlertController(title: Application.nice, message: LoginString.loginSuccess, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: LoginString.loginTitle, style: UIAlertAction.Style.default, handler: { _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(alert, animated: true, completion: nil)
            self?.registerButton.isLoading = false
        }).disposed(by: disposeBag)
        
        registerFailed.subscribe(onNext: { [weak self] in
            let alert = UIAlertController(title: Application.whoops, message: LoginString.loginFailed, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Application.back, style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
            self?.registerButton.isLoading = false
        }).disposed(by: disposeBag)
    }
    
    /// Configure `Keyboard`
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Configure `Login Title`
    private func configureRegisterTitleLabel() {
        registerTitleLabel.numberOfLines = 2
        registerTitleLabel.textAlignment = .left
        registerTitleLabel.text = Register.registerTitle
        registerTitleLabel.font = FontSans(fontSansType: .medium, fontSize: 25).set()
        registerTitleLabel.accessibilityIdentifier = "registerTitleIdentifier"
    }
    
    /// Configure `Register Title`
    private func configureRegisterDescLabel() {
        registerDescLabel.textAlignment = .left
        registerDescLabel.textColor = .lightGray
        registerDescLabel.text = Register.registerDesc
        registerDescLabel.font = FontSans(fontSansType: .regular, fontSize: 14).set()
    }
    
    /// Configure `Title Label for Text Field`
    private func configureTitleLabelForTextField(for label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .left
        label.font = FontSans(fontSansType: .regular, fontSize: 12).set()
    }
    
    /// Configure `Text Field`
    private func configureTextField(for textfield: UITextField, securityTextEnable: Bool = false, clearEnable: Bool = true) {
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = securityTextEnable
        textfield.font = FontSans(fontSansType: .regular, fontSize: 14).set()
        textfield.clearButtonMode = securityTextEnable ? .never : .whileEditing
        
        switch textfield {
        case nameTextField:
            textfield.accessibilityIdentifier = "nameTextFieldIdentifier"
        case passwordTextField:
            textfield.accessibilityIdentifier = "passwordTextFieldIdentifier"
        case emailTextField:
            textfield.accessibilityIdentifier = "emailTextFieldIdentifier"
        default:
            break
        }
    }
    
    /// Configure `Register Button`
    private func configureRegisterButton() {
        let attr = [NSAttributedString.Key.font: FontSans(fontSansType: .medium, fontSize: 14).set()]
        let attributes = NSAttributedString(string: Register.signup, attributes: attr)
        
        registerButton.tintColor = .white
        registerButton.layer.cornerRadius = 8
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setAttributedTitle(attributes, for: .normal)
        registerButton.accessibilityIdentifier = "registerButtonIdentifier"
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    /// Configure Already have account label view
    private func configureAlreadHasAccountLabel() {
        let text = NSMutableAttributedString(string: Register.alreadyHaveAccount)
        text.addAttribute(
            NSAttributedString.Key.font,
            value: FontSans(fontSansType: .medium, fontSize: 14).set(),
            range: NSMakeRange(0, text.length)
        )
        
        let selectablePart = NSMutableAttributedString(string: LoginString.loginTitle)
        selectablePart.addAttribute(
            NSAttributedString.Key.font,
            value: FontSans(fontSansType: .medium, fontSize: 14).set(),
            range: NSMakeRange(0, selectablePart.length)
        )
        
        /// Add an underline to indicate this portion of text is selectable (optional)
        selectablePart.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: 1,
            range: NSMakeRange(0,selectablePart.length)
        )
        
        selectablePart.addAttribute(
            NSAttributedString.Key.underlineColor,
            value: UIColor.black,
            range: NSMakeRange(0, selectablePart.length)
        )
        
        /// Add an NSLinkAttributeName with a value of an url or anything else
        selectablePart.addAttribute(
            NSAttributedString.Key.link,
            value: "signin",
            range: NSMakeRange(0,selectablePart.length)
        )
        
        /// Combine the non-selectable string with the selectable string
        text.append(selectablePart)
        
        /// Center the text (optional)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        /// To set the link text color (optional)
        alreadyHaveAccountTextView.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]
        
        alreadyHaveAccountTextView.attributedText = text
        alreadyHaveAccountTextView.isEditable = false
        alreadyHaveAccountTextView.isSelectable = true
        alreadyHaveAccountTextView.delegate = self
        
        /// Set accessibilityIdentifier specifically for the link text within UITextView
        if let linkRange = (alreadyHaveAccountTextView.text as NSString?)?.range(of: Register.alreadyHaveAccount) {
            let linkStartPosition = alreadyHaveAccountTextView.position(from: alreadyHaveAccountTextView.beginningOfDocument, offset: linkRange.location)
            let linkEndPosition = alreadyHaveAccountTextView.position(from: linkStartPosition!, offset: linkRange.length)
            
            if let textRange = alreadyHaveAccountTextView.textRange(from: linkStartPosition!, to: linkEndPosition!) {
                let linkRect = alreadyHaveAccountTextView.firstRect(for: textRange)
                let linkAccessibilityElement = alreadyHaveAccountTextView.inputAccessoryView?.hitTest(linkRect.origin, with: nil)
                linkAccessibilityElement?.accessibilityIdentifier = "signinLinkIdentifier"
            }
        }
    }
    
    /// Configure `Detect First Responder`
    private func findFirstResponder(view: UIView) -> UIView? {
        if view.isFirstResponder {
            return view
        }
        
        for subview in view.subviews {
            if let firstResponder = findFirstResponder(view: subview) {
                return firstResponder
            }
        }
        return nil
    }
    
    // MARK: Action
    @objc func registerButtonTapped() {
        registerButton.isLoading = true
        
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter?.registerProcess(name: name, email: email, password: password, avatar: "https://picsum.photos/800")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect = view.frame
        aRect.size.height -= keyboardSize.height
        
        if let activeTextField = findFirstResponder(view: contentView) {
            if !aRect.contains(activeTextField.frame.origin) {
                scrollView.scrollRectToVisible(activeTextField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
}

// MARK: Presenter to View Protocol
extension RegisterViewController: RegisterPresenterToViewProtocol {
}

// MARK: Text View Delegate
extension RegisterViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.navigationController?.popViewController(animated: true)
        return false
    }
}

// MARK: Localize String
extension RegisterViewController {
    struct Application {
        static let nice = localizedString(StructLocalization.Application.nice)
        static let back = localizedString(StructLocalization.Application.back)
        static let okay = localizedString(StructLocalization.Application.back)
        static let whoops = localizedString(StructLocalization.Application.back)
    }
    
    struct LoginString {
        static let loginTitle = localizedString(StructLocalization.Login.loginTitle)
        static let loginSuccess = localizedString(StructLocalization.Login.loginSuccess)
        static let loginFailed = localizedString(StructLocalization.Login.loginFailed)
    }
    
    struct TextView {
        static let name = localizedString(StructLocalization.TextView.name)
        static let email = localizedString(StructLocalization.TextView.email)
        static let userName = localizedString(StructLocalization.TextView.userName)
        static let password = localizedString(StructLocalization.TextView.password)
    }
    
    struct Register {
        static let signup = localizedString(StructLocalization.Register.signUp)
        static let registerTitle = localizedString(StructLocalization.Register.registerTitle)
        static let registerDesc = localizedString(StructLocalization.Register.registerDesc)
        static let alreadyHaveAccount = localizedString(StructLocalization.Register.alreadyHaveAccount)
    }
}
