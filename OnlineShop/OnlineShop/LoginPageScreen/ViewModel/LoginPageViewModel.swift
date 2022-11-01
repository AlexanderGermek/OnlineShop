//
//  LoginPageViewModel.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI
import FirebaseAuth

final class LoginPageViewModel: ObservableObject {
		// MARK: - Properties
		/// AppStorage
		@AppStorage("logStatus") var logStatus = false

		/// Login properties
		@Published var email: String = ""
		@Published var password: String = ""
		@Published var isShowPassword: Bool = false

		/// Register properties
		@Published var isRegisterUser: Bool = false
		@Published var reEnterPassword: String = ""
		@Published var isShowReEnterPassword: Bool = false

		@Published var showAlert = false
		@Published var alertMsg = ""
		@Published var isLoading = false
		var wasRegister = false

		// MARK: - Functions
		func login() {
				/// Пароль или почта пустые
				guard (!email.isEmpty && !password.isEmpty) else {
						alertMsg = "Email and password shouldn't be empty!"
						showAlert.toggle()
						return
				}

				withAnimation {
						isLoading.toggle()
				}

				/// Ошибка авторизации
				Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
						guard let self = self else { return }

						withAnimation {
								self.isLoading.toggle()
						}

						guard error == nil else {
								self.alertMsg = error?.localizedDescription ?? "Auth error! Try one more time!"
								self.showAlert.toggle()
								return
						}

						/// Пользователь зарегистрирован, но не прошел верификацию
						guard let user = Auth.auth().currentUser, user.isEmailVerified else {
								self.alertMsg = "Please verify your email address, check your email box."
								self.showAlert.toggle()
								do {
										try? Auth.auth().signOut()
								}
								return
						}

						withAnimation {
								self.logStatus = true
						}
				}
		}

		func register() {
				/// Пароль, подтверждение пароля или почта пустые
				guard (!email.isEmpty && !password.isEmpty && !reEnterPassword.isEmpty) else {
						alertMsg = "Email, password and re-enter password shouldn't be empty!"
						showAlert.toggle()
						return
				}

				/// Пароли не совпадают
				guard password == reEnterPassword else {
						alertMsg = "Password mismatch!"
						showAlert.toggle()
						return
				}

				withAnimation {
						self.isLoading.toggle()
				}

				Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
						guard let self = self else { return }

						guard error == nil else {
								self.alertMsg = error?.localizedDescription ?? "Register error! Try one more time!"
								withAnimation {
										self.isLoading.toggle()
								}
								self.showAlert.toggle()
								return
						}

						result?.user.sendEmailVerification { error in
								guard error == nil else {
										self.alertMsg = error?.localizedDescription ?? "Send email verification error!"
										withAnimation {
												self.isLoading.toggle()
										}
										self.showAlert.toggle()
										return
								}

								withAnimation {
										self.isLoading.toggle()
								}

								self.alertMsg = "Email verification has been sent! Verify your email ID, check your email box!"
								self.showAlert.toggle()
								self.wasRegister = true
						}
				}
		}

		func forgotPassword() {
				let alert = UIAlertController(
						title: "Reset Password",
						message: "Enter Your Email ID to reset password",
						preferredStyle: .alert)

				alert.addTextField { (password) in
						password.placeholder = "email"
				}

				let proceedAction = UIAlertAction(title: "Reset", style: .default) { (_) in
						guard let email = alert.textFields?.first?.text, !email.isEmpty else { return }

						withAnimation {
								self.isLoading.toggle()
						}

						Auth.auth().sendPasswordReset(withEmail: email) { error in
								withAnimation {
										self.isLoading.toggle()
								}

								guard error == nil else {
										self.alertMsg = error?.localizedDescription ?? "Reset Error! Try Again!"
										self.showAlert.toggle()
										return
								}

								self.alertMsg = "Password Reset Link Has Been Sent!"
								self.showAlert.toggle()
						}
				}

				let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

				alert.addAction(proceedAction)
				alert.addAction(cancelAction)

				UIApplication
						.shared
						.connectedScenes
						.compactMap { $0 as? UIWindowScene }
						.flatMap { $0.windows }
						.first { $0.isKeyWindow }?
						.rootViewController?
						.present(alert, animated: true)
		}

}
