//
//  GoogleSignInController.swift
//  iOS Auth
//
//  Created by Nato Egnatashvili on 28.02.22.
//


import UIKit
import GoogleSignIn
import SDWebImage
import FacebookLogin

class GoogleSignInController: UIViewController {
    // MARK: Properties
    // ================
    
    let signInConfig = GIDConfiguration.init(clientID: "450556851187-0hcdtag9n6jg6v9jj5rbe9b2idcjebu3.apps.googleusercontent.com")
    
    private lazy var googleButton: GIDSignInButton = {
        var btn: GIDSignInButton = GIDSignInButton()
        btn.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var facebookButton: FBLoginButton = {
        var btn: FBLoginButton = FBLoginButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var loginButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.isHidden = true
        stack.alignment = .center
        return stack
    }()
    
    private lazy var icon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
        img.widthAnchor.constraint(equalToConstant: 40).isActive = true
        img.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return img
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var ageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var signOutBtn: UIButton = {
        let lbl = UIButton()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // On-screen controls
    
    // App and user status
    
    // Auth0 data
    // MARK: View events
    // =================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addButtonInView()
        addStack()
        facebookTokensNotification()
    }
    
    private func addButtonInView() {
        self.view.addSubview(loginButtonStack)
        loginButtonStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loginButtonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        loginButtonStack.addArrangedSubview(googleButton)
        loginButtonStack.addArrangedSubview(facebookButton)
    }
    
    private func addStack() {
        self.view.addSubview(stack)
        stack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        stack.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 16).isActive = true
        stack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.googleButton.topAnchor, constant: 10).isActive = true
        addAddangedSubviewsInStack()
    }
    
    private func addAddangedSubviewsInStack() {
        self.stack.addArrangedSubview(icon)
        self.stack.addArrangedSubview(emailLabel)
        self.stack.addArrangedSubview(nameLabel)
        self.stack.addArrangedSubview(ageLabel)
    }
    
    // MARK: Actions + notifications
    // =============
    @objc private func didTapSignIn() {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user,
            let profile = user.profile else { return }
            print(user.authentication.accessToken)
            self.updateUI(profile)
          }
    }
   
    @objc private func didTapSignOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    private func facebookTokensNotification() {
        if let token = AccessToken.current,
                !token.isExpired {
            print(token.tokenString)
                // User is logged in, do work such as go to next view controller.
        }
        
        // Observe access token changes
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }
    
    // MARK: UI updaters
    // =================
    private func updateUI(_ profile: GIDProfileData) {
        self.googleButton.isHidden = true
        self.stack.isHidden = false
        self.emailLabel.text = profile.email
        self.nameLabel.text = profile.name
        icon.sd_setImage(with: profile.imageURL(withDimension: 320)) { img, err, _, _ in
            print("yes")
        }
    }
}


