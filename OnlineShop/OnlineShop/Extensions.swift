//
//  Extensions.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI

extension Font {
		static let raleway = "Raleway-Regular"
}

extension Color {
		static let customPurple = Color("Purple")
		static let loginCirlceColor = Color("LoginCircle")
		static let homeBackground = Color("HomeBG")
		static let quantityColor = Color("Quantity")
}

extension View {
		func getScreenBounds() -> CGRect {
				return UIScreen.main.bounds
		}
}
