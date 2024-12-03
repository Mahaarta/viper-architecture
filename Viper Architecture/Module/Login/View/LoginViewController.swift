//
//  LoginViewController.swift
//  Viper Architecture
//
//  Created by Minata on 18/12/2023.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var loginDescLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var dontHaveAccountTextView: UITextView!
    
    var presenter: LoginViewToPresenterProtocol?
    let loginSuccess = PublishRelay<Void>()
    var showError = PublishRelay<Void>()
    let navigateToRegister = PublishRelay<Void>()
    let navigateToDashboard = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservable()
        configureKeyboard()
        configureLoginTitleLabel()
        configureLoginDescLabel()
        configureUsernameLabel()
        configureUsernameTextField()
        configurePasswordLabel()
        configurePasswordTextField()
        configureLoginButton()
        configureAlreadHasAccountLabel()
    }
    
    /// Configure `Observable`
    private func configureObservable() {
        loginSuccess.subscribe(onNext: { [weak self] in
            self?.presenter?.navigateToDashboard()
            self?.loginButton.isLoading = false
        }).disposed(by: disposeBag)
        
        showError.subscribe(onNext: { [weak self] in
            let alert = UIAlertController(title: Application.whoops, message: LoginString.loginFailed, preferredStyle: UIAlertController.Style.alert)
            alert.view.accessibilityIdentifier = "ErrorAlert"
            alert.addAction(UIAlertAction(title: Application.back, style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
            self?.loginButton.isLoading = false
        }).disposed(by: disposeBag)
    }
    
    /// Configure `Keyboard`
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Configure `Login Title`
    private func configureLoginTitleLabel() {
        loginTitleLabel.text = LoginString.loginTitle
        loginTitleLabel.font = FontSans(fontSansType: .medium, fontSize: 25).set()
        loginTitleLabel.textAlignment = .left
    }
    
    /// Configure `Login Title`
    private func configureLoginDescLabel() {
        loginDescLabel.text = LoginString.loginDesc
        loginDescLabel.font = FontSans(fontSansType: .regular, fontSize: 14).set()
        loginDescLabel.textAlignment = .left
        loginDescLabel.textColor = .lightGray
    }
    
    /// Configure `Username textView`
    private func configureUsernameLabel() {
        usernameLabel.text = TextView.userName
        usernameLabel.font = FontSans(fontSansType: .regular, fontSize: 12).set()
        usernameLabel.textAlignment = .left
    }
    
    /// Configure `Username TextView`
    private func configureUsernameTextField() {
        usernameTextField.text = "mor_2314"
        usernameTextField.autocorrectionType = .no
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.accessibilityIdentifier = "usernameTextFieldIdentifier"
        usernameTextField.font = FontSans(fontSansType: .regular, fontSize: 14).set()
    }
    
    /// Configure `Password textView`
    private func configurePasswordLabel() {
        passwordLabel.text = TextView.password
        passwordLabel.font = FontSans(fontSansType: .regular, fontSize: 12).set()
        passwordLabel.textAlignment = .left
    }
    
    /// Configure `password textView`
    private func configurePasswordTextField() {
        passwordTextField.text = "83r5^_"
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.accessibilityIdentifier = "passwordTextFieldIdentifier"
        passwordTextField.font = FontSans(fontSansType: .regular, fontSize: 14).set()
    }
    
    /// Configure `Login Button`
    private func configureLoginButton() {
        let attr = [NSAttributedString.Key.font: FontSans(fontSansType: .medium, fontSize: 16).set()]
        let attributes = NSAttributedString(string: LoginString.loginTitle, attributes: attr)
        
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 8
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setAttributedTitle(attributes, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.accessibilityIdentifier = "loginButtonIdentifier"
    }
    
    /// Configure `Register Label`
    private func configureAlreadHasAccountLabel() {
        let text = NSMutableAttributedString(string: LoginString.dontHaveAccount)
        text.addAttribute(
            NSAttributedString.Key.font,
            value: FontSans(fontSansType: .medium, fontSize: 14).set(),
            range: NSMakeRange(0, text.length)
        )
        
        let selectablePart = NSMutableAttributedString(string: Register.signup)
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
            value: "signup", range: NSMakeRange(0,selectablePart.length)
        )
        
        /// Combine the non-selectable string with the selectable string
        text.append(selectablePart)
        
        /// Center the text (optional)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        /// To set the link text color (optional)
        dontHaveAccountTextView.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]
        
        dontHaveAccountTextView.attributedText = text
        dontHaveAccountTextView.isEditable = false
        dontHaveAccountTextView.isSelectable = true
        dontHaveAccountTextView.delegate = self
        dontHaveAccountTextView.accessibilityIdentifier = "dontHaveAccountTextViewIdentifier"
        
        /// Set accessibilityIdentifier specifically for the link text within UITextView
        if let linkRange = (dontHaveAccountTextView.text as NSString?)?.range(of: Register.signup) {
            let linkStartPosition = dontHaveAccountTextView.position(from: dontHaveAccountTextView.beginningOfDocument, offset: linkRange.location)
            let linkEndPosition = dontHaveAccountTextView.position(from: linkStartPosition!, offset: linkRange.length)
            
            if let textRange = dontHaveAccountTextView.textRange(from: linkStartPosition!, to: linkEndPosition!) {
                let linkRect = dontHaveAccountTextView.firstRect(for: textRange)
                let linkAccessibilityElement = dontHaveAccountTextView.inputAccessoryView?.hitTest(linkRect.origin, with: nil)
                linkAccessibilityElement?.accessibilityIdentifier = "signupLinkIdentifier"
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
    @objc func loginButtonTapped() {
        loginButton.isLoading = true
        presenter?.loginProcess(username: "mor_2314", password: "83r5^_")
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

// MARK: - Presenter to View
extension LoginViewController: LoginPresenterToViewProtocol {
}

// MARK: Delegate - TextView
extension LoginViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        presenter?.navigateToRegister()
        return false
    }
}

// MARK: Localize String
extension LoginViewController {
    struct Application {
        static let nice = localizedString(StructLocalization.Application.nice)
        static let back = localizedString(StructLocalization.Application.back)
        static let okay = localizedString(StructLocalization.Application.back)
        static let whoops = localizedString(StructLocalization.Application.back)
    }
    
    struct LoginString {
        static let loginTitle = localizedString(StructLocalization.Login.loginTitle)
        static let loginDesc = localizedString(StructLocalization.Login.loginDesc)
        static let loginSuccess = localizedString(StructLocalization.Login.loginSuccess)
        static let loginFailed = localizedString(StructLocalization.Login.loginFailed)
        static let dontHaveAccount = localizedString(StructLocalization.Login.dontHaveAccount)
    }
    
    struct TextView {
        static let userName = localizedString(StructLocalization.TextView.userName)
        static let password = localizedString(StructLocalization.TextView.password)
    }
    
    struct Register {
        static let signup = localizedString(StructLocalization.Register.signUp)
    }

}

@available(iOS 17.0, *)
#Preview {
    let loginVC = LoginViewController()
    return loginVC
}
