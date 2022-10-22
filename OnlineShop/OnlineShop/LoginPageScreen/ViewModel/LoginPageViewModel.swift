//
//  LoginPageViewModel.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import Foundation

final class LoginPageViewModel: ObservableObject {
		/// Login properties
		@Published var email: String = ""
		@Published var password: String = ""
		@Published var isShowPassword: Bool = false

		/// Register properties
		@Published var isRegisterUser: Bool = false
		@Published var reEnterPassword: String = ""
		@Published var isShowReEnterPassword: Bool = false

		/// Functions
		func login() {

		}

		func register() {

		}

		func forgotPassword() {
				
		}

}
