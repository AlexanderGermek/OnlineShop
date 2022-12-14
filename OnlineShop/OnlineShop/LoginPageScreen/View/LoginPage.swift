//
//  LoginPage.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import FirebaseAuth

struct LoginPage: View {
		
		@StateObject var loginData: LoginPageViewModel = LoginPageViewModel()
		var body: some View {
				ZStack {
						VStack {
								/// Welcome Background text
								Text("Welcome\nback")
										.font(.custom(Font.raleway, size: 55)).bold()
										.foregroundColor(.white)
										.frame(maxWidth: .infinity, alignment: .leading)
										.frame(height: getScreenBounds().height / 4)
										.padding()
										.padding(.leading, 30)
										.shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
								/// Circles
										.background(
												BackgroundCirclesView()
										)

								/// Custom white rectangle
								ScrollView(.vertical, showsIndicators: false) {
										VStack {
												/// Login TextFields
												GetLoginTextFields().padding(30)

												/// Login Buttons
												GetButtons()

												/// Google Apple Sign In Button
												VStack {
														GetAppleSignInButton()

														GetGoogleSignInButton()
												}

										}
								}
								.frame(maxWidth: .infinity, maxHeight: .infinity)
								.background(
										Color.white
												.clipShape(CustomCornerShape(corners: [.topLeft, .topRight], radius: 25))
												.ignoresSafeArea()
								)
						}
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(Color.customPurple)
						/// Clearing data when Changes
						.onChange(of: loginData.isRegisterUser) { newValue in
								loginData.email = ""
								loginData.password = ""
								loginData.reEnterPassword = ""
								loginData.isShowPassword = false
								loginData.isShowReEnterPassword = false
						}
						.alert(isPresented: $loginData.showAlert) {

								if !loginData.wasRegister {
										return Alert(title: Text("Message"),
													message: Text(loginData.alertMsg),
													dismissButton: .destructive(Text("OK")))
								} else {
										return Alert(title: Text("Message"),
													message: Text(loginData.alertMsg),
													dismissButton: .destructive(Text("Ok, go to Login!"), action: {

												withAnimation {
														loginData.isRegisterUser.toggle()
												}

												loginData.wasRegister = false
										})
										)
								}
						}

						if loginData.isLoading {
								SpinnerView()
						}

				}
		}

		// MARK: some View
		private func CustomTextField(title: String,
																 hint: String,
																 value: Binding<String>,
																 isShow: Binding<Bool>,
																 icon: String,
																 isSecure: Bool) -> some View {

				VStack(alignment: .leading, spacing: 12) {
						Label {
								Text(title)
										.font(.custom(Font.raleway, size: 14))
						} icon: {
								Image(systemName: icon)
						}
						.foregroundColor(.black.opacity(0.8))

						if isSecure && !isShow.wrappedValue {
								SecureField(hint, text: value)
										.padding(.top, 2)
										.textInputAutocapitalization(.never)
										.autocorrectionDisabled()
						} else {
								TextField(hint, text: value)
										.padding(.top, 2)
										.textInputAutocapitalization(.never)
										.autocorrectionDisabled()
						}

						Divider().background(.black.opacity(0.4))
				}
				/// Show/ Hide Button
				.overlay(alignment: .trailing) {
						if isSecure {
								Button {

										withAnimation {
												isShow.wrappedValue.toggle()
										}

								} label: {
										Text(isShow.wrappedValue ? "Hide": "Show")
												.font(.custom(Font.raleway, size: 13).bold())
												.foregroundColor(Color.customPurple)
								}
								.offset(y: 8)
						}
				}
		}

		private func GetLoginTextFields() -> some View {
				VStack(spacing: 15) {

						Text(loginData.isRegisterUser ? "Register" : "Login")
								.font(.custom(Font.raleway, size: 22).bold())
								.frame(maxWidth: .infinity, alignment: .leading)

						/// Custom Text Fields
						CustomTextField(title: "Email",
														hint: "example@gmail.com",
														value: $loginData.email,
														isShow: $loginData.isShowPassword,
														icon: "envelope",
														isSecure: false)
						.padding(.top, 30)

						CustomTextField(title: "Password",
														hint: "123456",
														value: $loginData.password,
														isShow: $loginData.isShowPassword,
														icon: "lock",
														isSecure: true)
						.padding(.top, 10)

						if loginData.isRegisterUser {
								CustomTextField(title: "Re-Enter Password",
																hint: "123456",
																value: $loginData.reEnterPassword,
																isShow: $loginData.isShowReEnterPassword,
																icon: "envelope",
																isSecure: true)
								.padding(.top, 10)
						}
				}
		}

		private func GetButtons() -> some View {
				VStack {
						/// Forgot password button
						Button {
								loginData.forgotPassword()
						} label: {
								Text("Forgot password?")
										.font(.custom(Font.raleway, size: 14))
										.fontWeight(.semibold)
										.foregroundColor(Color.customPurple)
						}
						.padding(.leading, 30)
						.frame(maxWidth: .infinity, alignment: .leading)

						/// Login button
						Button {
								if loginData.isRegisterUser {
										loginData.register()
								} else {
										loginData.login()
								}
						} label: {
								Text(loginData.isRegisterUser ? "Register": "Login")
										.font(.custom(Font.raleway, size: 17).bold())
										.padding(.vertical, 20)
										.frame(maxWidth: .infinity)
										.foregroundColor(.white)
										.background(Color.customPurple)
										.cornerRadius(15)
										.shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
						}
						.padding(.top, 25)
						.padding(.horizontal)

						/// Register user button
						Button {
								withAnimation {
										loginData.isRegisterUser.toggle()
								}
						} label: {
								Text(loginData.isRegisterUser ? "Back to Login" : "Create account")
										.font(.custom(Font.raleway, size: 14))
										.fontWeight(.semibold)
										.foregroundColor(Color.customPurple)
						}
						.padding(.top, 8)
						.padding(.bottom, 10).ignoresSafeArea()
				}
		}

		private func GetAppleSignInButton() -> some View {
				SignInWithAppleButton { request in

						loginData.currentNonce = loginData.randomNonceString()
						request.requestedScopes = [.email, .fullName]
						request.nonce = loginData.sha256(loginData.currentNonce)

				} onCompletion: { result in

						switch result {
						case .success(let auth):
								guard let credential = auth.credential as? ASAuthorizationAppleIDCredential else {
										loginData.showError(nil, text: "Error with apple sign in")
										return
								}
								loginData.authenticate(credential: credential)
						case .failure(let error):
								loginData.showError(error)
						}
				}
				.signInWithAppleButtonStyle(.black)
				.frame(height: 40)
				.clipShape(Capsule())
				.padding(.horizontal, 50)
		}

		private func GetGoogleSignInButton() -> some View {
				HStack {
						Button {
								loginData.googleSignIn()
						} label: {
								Image("google")
										.renderingMode(.template)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: 22, height: 22)
										.foregroundColor(.white)

								Text("Sign in with Google")
										.font(.custom(Font.raleway, size: 15))
										.foregroundColor(.white)
						}
				}
				.foregroundColor(.white)
				.padding(.horizontal, 50)
				.frame(height: 40)
				.background(
						RoundedRectangle(cornerRadius: 20, style: .continuous)
								.fill(.black)
				)
		}
}

struct LoginPage_Previews: PreviewProvider {
		static var previews: some View {
				LoginPage()
		}
}
