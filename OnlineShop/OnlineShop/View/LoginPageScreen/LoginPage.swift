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
								.frame(height: getScreenBounds().height / 3.5)
								.padding()
								.padding(.leading, 30)
						/// Circles
								.background(
										BackgroundCirclesView()
								)

						/// Custom white rectangle
						ScrollView(.vertical, showsIndicators: false) {
								/// Login page form
								VStack(spacing: 15) {
										Text("Login")
												.font(.custom(Font.raleway, size: 22).bold())
												.frame(maxWidth: .infinity, alignment: .leading)

										/// Custom Text Fields
										CustomTextField(title: "Email",
																		hint: "example@gmail.com",
																		value: $loginData.email,
																		isShow: $loginData.isShowPassword,
																		icon: "envelope")
										.padding(.top, 30)

										CustomTextField(title: "Password",
																		hint: "123456",
																		value: $loginData.email,
																		isShow: $loginData.isShowPassword,
																		icon: "lock")
										.padding(.top, 30)
								}
								.padding(30)
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
		}

		func CustomTextField(title: String,
												 hint: String,
												 value: Binding<String>,
												 isShow: Binding<Bool>,
												 icon: String) -> some View {

				VStack(alignment: .leading, spacing: 12) {
						Label {
								Text(title)
										.font(.custom(Font.raleway, size: 14))
						} icon: {
								Image(systemName: icon)
						}
						.foregroundColor(.black.opacity(0.8))

						TextField(hint, text: value).padding(.top, 2)

						Divider().background(.black.opacity(0.4))
				}
		}
}

struct LoginPage_Previews: PreviewProvider {
		static var previews: some View {
				LoginPage()
		}
}
