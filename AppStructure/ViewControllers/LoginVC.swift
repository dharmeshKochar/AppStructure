//
//  LoginVC.swift
//  AppStructure
//
//  Created by Admin on 23/08/21.
//

import UIKit
import FBSDKLoginKit
import Swifter

class LoginVC: UIViewController, UITextFieldDelegate {
    
    //MARK:- Properties
    let transition = CircularTransition()
    let viewModel = LoginVM()
    var swifter: Swifter!
    var accToken: Credential.OAuthAccessToken?
    
    //MARK:- IBOutlets
    @IBOutlet weak var fbStack: UIStackView!
    @IBOutlet weak var passwordTextField: FloatingPlaceholder!
    @IBOutlet weak var emailTextField: FloatingPlaceholder!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signUpButtonStack: UIStackView!
    @IBOutlet weak var toptitleGap: NSLayoutConstraint!
    @IBOutlet weak var loginStackGap: NSLayoutConstraint!
    @IBOutlet weak var passwordforgetGap: NSLayoutConstraint!
    @IBOutlet weak var titleEmailGap: NSLayoutConstraint!
    @IBOutlet weak var loginForgotGap: NSLayoutConstraint!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleSignUpButtonAnimation()
        handlefbButtonAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.layer.cornerRadius = titleLabel.frame.height / 2
        titleLabel.layer.masksToBounds = true
        emailTextField.setLeftPadding(22)
        passwordTextField.setLeftPadding(22)
        signUpButtonStack.layer.cornerRadius = signUpButtonStack.frame.size.height / 2
        signUpButtonStack.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
    }

    //MARK:- Function
    private func initialSetup() {
        emailTextField.setPlacehoder(StringConstant.Email.value)
        passwordTextField.setPlacehoder(StringConstant.Password.value)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        emailTextField.addTarget(self, action: #selector(SignUpVC.validEmail), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpVC.validPassword), for: .editingChanged)
        
    }
    
    private func handleSignUpButtonAnimation(){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.signUpButtonStack.transform = CGAffineTransform(translationX: -110, y: 0)
        } completion: { [self] _ in
            handleSignUpButtonAnimation()
        }
    }
    
    private func handlefbButtonAnimation(){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.2, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.fbStack.transform = CGAffineTransform(translationX: -116, y: 0)
        } completion: { [self] _ in
            handlefbButtonAnimation()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    
    //MARK:- IBAction
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
      //  AppRouter.gotoSignupVC(vc: self)
        let scene = SignUpVC.instantiate(fromAppStoryboard: .PreLogin)
        scene.transitioningDelegate = self
        scene.modalPresentationStyle = .fullScreen
        self.present(scene, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let request = LoginRequest(email:emailTextField.text , password: passwordTextField.text)
        let validationResult = viewModel.loginUser(loginRequest: request)
        if validationResult.result {
            WelcomeVC.name = emailTextField.text!
            AppRouter.gotoWelcomeVC(vc: self)
        } else {
            Alert.sendAlert(self, "" , validationResult.error!)
        }
    }
    
    @IBAction func twitteButtonTapped(_ sender: UIButton) {
        self.swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY)
                self.swifter.authorize(withCallback: URL(string: TwitterConstants.CALLBACK_URL)!, presentingFrom: self, success: { accessToken, _ in
                    self.accToken = accessToken
                    self.getUserProfile()
                }, failure: { _ in
                    print("ERROR: Trying to authorize")
                })
    }
    
    @IBAction func fbButtonTapped(_ sender: UIButton) {
        FBSDKLoginKit.LoginManager().logIn(permissions: ["public_profile", "email"], from: self) { result, err in
            if err != nil {
                Alert.sendAlert(self, "fb Login Failed","")
            }
        }
        if let token = AccessToken.current,
               !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { connection, result, error in
                var dic:[String:String?] = [:]
                dic = result as! [String:String?]
                WelcomeVC.name = (dic["name"] ?? "") ?? ""
                AppRouter.gotoWelcomeVC(vc: self)
            }
        }
    }
}
 
//MARK:- Extension for Keyboard Notification
extension LoginVC {
    @objc func keyboardWillShow(notification: Notification) {
        toptitleGap.constant = 6
        passwordforgetGap.constant = 8
        titleEmailGap.constant = 12
        loginStackGap.constant = 4
        loginForgotGap.constant = 4
    }

    @objc func keyboardWillHide(notification: Notification) {
        toptitleGap.constant = 20
        passwordforgetGap.constant = 52
        titleEmailGap.constant = 72
        loginStackGap.constant = 32
        loginForgotGap.constant = 40
    }
}

//MARK:- Extension for Custom Transition
extension LoginVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitioningMode = .present
        transition.startingPoint = signUpButtonStack.center
        transition.circleColor = view.backgroundColor!
        return transition
   }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitioningMode = .dismiss
        transition.startingPoint = signUpButtonStack.center
        transition.circleColor = .clear
        return transition
   }
}

//MARK:- Extension for Facebook Login
extension LoginVC: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
        request.start { connection, result, error in
            var dic:[String:String?] = [:]
            dic = result as! [String:String?]
            WelcomeVC.name = (dic["name"] ?? "") ?? ""
        }
        AppRouter.gotoWelcomeVC(vc: self)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
}

//MARK: extension for twitter
extension LoginVC {
    func getUserProfile() {
            self.swifter.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { json in
                // Twitter Name
                if let twitterName = json["name"].string {
                    WelcomeVC.name = twitterName
                        AppRouter.gotoWelcomeVC(vc: self)
                } else {
                    print("Not exists")
                }
                print("Twitter Access Token: \(self.accToken?.key ?? "Not exists")")
            }) { error in
                print("ERROR: \(error.localizedDescription)")
            }
        }
}
