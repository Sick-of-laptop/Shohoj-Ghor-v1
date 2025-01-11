import Foundation
import FirebaseAuth
import GoogleSignIn

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var alertItem: AlertItem?
    
    init() {
        user = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.alertItem = AlertItem(
                    title: "Login Error",
                    message: error.localizedDescription
                )
                return
            }
            
            self?.user = result?.user
        }
    }
    
    func signup(name: String, email: String, password: String, confirmPassword: String, phoneNumber: String) {
        // Validate inputs
        guard !name.isEmpty else {
            alertItem = AlertItem(title: "Invalid Name", message: "Please enter your name")
            return
        }
        
        guard !email.isEmpty, email.contains("@") else {
            alertItem = AlertItem(title: "Invalid Email", message: "Please enter a valid email")
            return
        }
        
        guard password.count >= 6 else {
            alertItem = AlertItem(title: "Invalid Password", message: "Password must be at least 6 characters")
            return
        }
        
        guard password == confirmPassword else {
            alertItem = AlertItem(title: "Password Mismatch", message: "Passwords do not match")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.alertItem = AlertItem(
                    title: "Signup Error",
                    message: error.localizedDescription
                )
                return
            }
            
            // Update user profile
            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("Error updating profile: \(error.localizedDescription)")
                }
            }
            
            self?.user = result?.user
        }
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                self?.alertItem = AlertItem(
                    title: "Google Sign In Error",
                    message: error.localizedDescription
                )
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self?.alertItem = AlertItem(
                        title: "Authentication Error",
                        message: error.localizedDescription
                    )
                    return
                }
                
                self?.user = result?.user
            }
        }
    }
    
    func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.alertItem = AlertItem(
                    title: "Password Reset Error",
                    message: error.localizedDescription
                )
                return
            }
            
            self?.alertItem = AlertItem(
                title: "Password Reset",
                message: "Password reset email has been sent"
            )
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            alertItem = AlertItem(
                title: "Sign Out Error",
                message: error.localizedDescription
            )
        }
    }
} 