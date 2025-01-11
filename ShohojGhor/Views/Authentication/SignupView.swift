import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var phoneNumber = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                Text("Create Account")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(ColorTheme.navigation)
                    .padding(.top, 30)
                
                // Name Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Full Name")
                        .foregroundColor(ColorTheme.secondaryText)
                    TextField("Enter your full name", text: $name)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textContentType(.name)
                }
                
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
                
                // Phone Number Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .foregroundColor(ColorTheme.secondaryText)
                    TextField("Enter your phone number", text: $phoneNumber)
                        .textFieldStyle(CustomTextFieldStyle())
                        .keyboardType(.phonePad)
                }
                
                // Password Fields
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .foregroundColor(ColorTheme.secondaryText)
                    
                    HStack {
                        if showPassword {
                            TextField("Create password", text: $password)
                        } else {
                            SecureField("Create password", text: $password)
                        }
                        
                        Button(action: { showPassword.toggle() }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(ColorTheme.secondaryText)
                        }
                    }
                    .textFieldStyle(CustomTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Confirm Password")
                        .foregroundColor(ColorTheme.secondaryText)
                    
                    HStack {
                        if showConfirmPassword {
                            TextField("Confirm password", text: $confirmPassword)
                        } else {
                            SecureField("Confirm password", text: $confirmPassword)
                        }
                        
                        Button(action: { showConfirmPassword.toggle() }) {
                            Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(ColorTheme.secondaryText)
                        }
                    }
                    .textFieldStyle(CustomTextFieldStyle())
                }
                
                // Sign Up Button
                Button(action: {
                    viewModel.signup(name: name, email: email, password: password, confirmPassword: confirmPassword, phoneNumber: phoneNumber)
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(ColorTheme.navigation)
                        .cornerRadius(12)
                }
                
                // Google Sign Up
                Button(action: { viewModel.signInWithGoogle() }) {
                    HStack {
                        Image("google_logo")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Sign up with Google")
                            .font(.headline)
                    }
                    .foregroundColor(ColorTheme.text)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(ColorTheme.primary)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                }
                
                // Login Link
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(ColorTheme.secondaryText)
                        Text("Login")
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