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
										ZStack {
												LinearGradient(colors: [
														Color.loginCirlceColor,
														Color.loginCirlceColor.opacity(0.8),
														Color.customPurple
												], startPoint: .top, endPoint: .bottom)
												.frame(width: 100, height: 100)
												.clipShape(Circle())
												.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
												.padding(.trailing)
												.offset(y: -25)
												.ignoresSafeArea()
										}
								)

						/// Custom white rectangle
						ScrollView(.vertical, showsIndicators: false) {

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
}

struct LoginPage_Previews: PreviewProvider {
		static var previews: some View {
				LoginPage()
		}
}
