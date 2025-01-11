import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var navigateToSignup = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Logo or App Name
                    Text("Shohoj Ghor")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(ColorTheme.navigation)
                        .padding(.top, 50)
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .foregroundColor(ColorTheme.secondaryText)
                        
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(CustomTextFieldStyle())
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .foregroundColor(ColorTheme.secondaryText)
                        
                        HStack {
                            if showPassword {
                                TextField("Enter your password", text: $password)
                            } else {
                                SecureField("Enter your password", text: $password)
                            }
                            
                            Button(action: { showPassword.toggle() }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(ColorTheme.secondaryText)
                            }
                        }
                        .textFieldStyle(CustomTextFieldStyle())
                    }
                    
                    // Forgot Password
                    Button(action: { viewModel.sendPasswordReset(email: email) }) {
                        Text("Forgot Password?")
                            .foregroundColor(ColorTheme.navigation)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    // Login Button
                    Button(action: {
                        viewModel.login(email: email, password: password)
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(ColorTheme.navigation)
                            .cornerRadius(12)
                    }
                    
                    // Google Sign In
                    Button(action: { viewModel.signInWithGoogle() }) {
                        HStack {
                            Image("google_logo") // Add this image to your assets
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Continue with Google")
                                .font(.headline)
                        }
                        .foregroundColor(ColorTheme.text)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(ColorTheme.primary)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                    }
                    
                    // Sign Up Link
                    NavigationLink(destination: SignupView(), isActive: $navigateToSignup) {
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(ColorTheme.secondaryText)
                            Text("Sign up")
                                .foregroundColor(ColorTheme.navigation)
                        }
                    }
                }
                .padding()
            }
            .background(ColorTheme.background)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(
                    title: Text(alertItem.title),
                    message: Text(alertItem.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
} 