import SwiftUI

struct LoginView: View {
    @Environment(AuthManager.self) private var authManager
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false
    @State private var showForgotPassword = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // Logo area
                    VStack(spacing: 12) {
                        Image(systemName: "car.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.tint)
                        Text("kolata.me")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Your car companion")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 60)

                    // Form
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                        if let error = authManager.errorMessage {
                            Text(error)
                                .font(.caption)
                                .foregroundStyle(.red)
                        }

                        Button {
                            Task {
                                await authManager.login(email: email, password: password)
                            }
                        } label: {
                            if authManager.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else {
                                Text("Sign In")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(email.isEmpty || password.isEmpty || authManager.isLoading)

                        Button("Forgot Password?") {
                            showForgotPassword = true
                        }
                        .font(.subheadline)
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 40)

                    // Register
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.secondary)
                        Button("Sign Up") {
                            showRegister = true
                        }
                        .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding()
            }
            .sheet(isPresented: $showRegister) {
                RegisterView()
            }
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordView()
            }
        }
    }
}
