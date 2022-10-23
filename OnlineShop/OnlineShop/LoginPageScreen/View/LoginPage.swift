//
//  LoginPage.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI

struct LoginPage: View {
		
		@StateObject var loginData: LoginPageViewModel = LoginPageViewModel()
		var body: some View {

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
								SecureField(hint, text: value).padding(.top, 2)
						} else {
								TextField(hint, text: value).padding(.top, 2)
						}

						Divider().background(.black.opacity(0.4))
				}
				/// Show/ Hide Button
				.overlay(alignment: .trailing) {
						if isSecure {
								Button {
										isShow.wrappedValue.toggle()
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
				}
		}
}

struct LoginPage_Previews: PreviewProvider {
		static var previews: some View {
				LoginPage()
		}
}
