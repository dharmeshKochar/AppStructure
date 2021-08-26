//
//  SignUpVC.swift
//  AppStructure
//
//  Created by Admin on 23/08/21.
//

import UIKit

class SignUpVC: UIViewController ,UITextFieldDelegate{
    
    //MARK:- Properties
    var viewModel = SignUpVM()
    
    //MARK:- IBOutles
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fbStack: UIStackView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var confirmPasswordTextField: FloatingPlaceholder!
    @IBOutlet weak var passwordTextField: FloatingPlaceholder!
    @IBOutlet weak var emailTextField: FloatingPlaceholder!
    @IBOutlet weak var confirmpasswordSignupGap: NSLayoutConstraint!
    @IBOutlet weak var signupStackGap: NSLayoutConstraint!
    @IBOutlet weak var topTitleGap: NSLayoutConstraint!
    @IBOutlet weak var titleEmailGap: NSLayoutConstraint!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginStackView.isHidden = false
        handleSignUpButtonAnimation()
        handlefbButtonAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.layer.cornerRadius = titleLabel.frame.height / 2
        titleLabel.layer.masksToBounds = true
        emailTextField.setLeftPadding(22)
        passwordTextField.setLeftPadding(22)
        confirmPasswordTextField.setLeftPadding(22)
        loginStackView.layer.cornerRadius = loginStackView.frame.size.height / 2
        loginStackView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
    
    //MARK:- Function
    private func initialSetup(){
        loginStackView.isHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailTextField.setPlacehoder(StringConstant.Email.value)
        passwordTextField.setPlacehoder(StringConstant.Password.value)
        confirmPasswordTextField.setPlacehoder(StringConstant.ConfirmPassword.value)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        emailTextField.addTarget(self, action: #selector(SignUpVC.validEmail), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpVC.validPassword), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(SignUpVC.validConfirmEmail), for: .editingChanged)
    }
    
        private func handleSignUpButtonAnimation() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.loginStackView.transform = CGAffineTransform(translationX: 110, y: 0)
        } completion: { [self] _ in
            handleSignUpButtonAnimation()
        }
    }
    
    private func handlefbButtonAnimation() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.2, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.fbStack.transform = CGAffineTransform(translationX: 116, y: 0)
        } completion: { [self] _ in
            handlefbButtonAnimation()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            textField.resignFirstResponder()
            return true
    }
    
    @objc func validEmail() {
        if viewModel.validateEmail(emailTextField.text!) {
            emailTextField.validationSuccess()
            emailTextField.addErrorLabel(StringConstant.ValidEmail.value)
           } else {
            emailTextField.validationFail()
            emailTextField.addErrorLabel(StringConstant.InvalidEmail.value)
           }
    }
    
    @objc func validPassword() {
        if viewModel.validatePassword(passwordTextField.text!) {
            passwordTextField.validationSuccess()
            passwordTextField.addErrorLabel(StringConstant.ValidPassword.value)
           } else {
            passwordTextField.validationFail()
            passwordTextField.addErrorLabel(StringConstant.InvalidPassword.value)
           }
    }
    
    @objc func validConfirmEmail() {
        if viewModel.validateConfirmPassword(passwordTextField.text!,confirmPasswordTextField.text!) {
            confirmPasswordTextField.validationSuccess()
            confirmPasswordTextField.addErrorLabel(StringConstant.ValidConfirmPassword.value)
        } else {
            confirmPasswordTextField.validationFail()
            confirmPasswordTextField.addErrorLabel(StringConstant.InvalidConfirmPassword.value)
        }
    }
    
    //MARK:- IBAction
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let request = SignUpRequest(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text)
        let validationResult = viewModel.signUpUser(signUpRequest: request)
        if validationResult.result {
            Alert.sendAlert(self, "Details are correct", "Successfully SignedIn")
        } else{
            Alert.sendAlert(self, "", validationResult.error!)
        }
    }
  
}

//MARK:- Extension for Keyboard Notification
extension SignUpVC {
    @objc func keyboardWillShow(notification: Notification) {
        topTitleGap.constant = 4
        titleEmailGap.constant = 6
        confirmpasswordSignupGap.constant = 3
        signupStackGap.constant = 3
    }

    @objc func keyboardWillHide(notification: Notification) {
        topTitleGap.constant = 20
        titleEmailGap.constant = 72
        confirmpasswordSignupGap.constant = 30
        signupStackGap.constant = 52
    }
}