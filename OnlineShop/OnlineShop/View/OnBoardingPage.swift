//
//  OnBoardingPage.swift
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
}

extension View {
		func getRect() -> CGRect {
				return UIScreen.main.bounds
		}
}

struct OnBoardingPage: View {
	var body: some View {
		VStack(alignment: .leading) {

			Text("Find your\nGadget")
				.font(.custom(Font.raleway, size: 55))
				.fontWeight(.bold)
				.foregroundColor(.white)

			Image("OnBoard")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)

			Button {

			} label: {
				Text("Get started")
					.font(.custom(Font.raleway, size: 18))
					.fontWeight(.semibold)
					.padding(.vertical, 18)
					.frame(maxWidth: .infinity)
					.background(.white)
					.cornerRadius(10)
					.shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
					.foregroundColor(Color.customPurple)
			}
			.padding(.horizontal, 30)
			.offset(y: getRect().height < 750 ? 20 : 40)

			Spacer()

		}
		.padding(.horizontal, 10)
		.padding(.top, getRect().height < 750 ? 0 : 20)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.customPurple)
	}
}

struct OnBoardingPage_Previews: PreviewProvider {
	static var previews: some View {
		OnBoardingPage()
			.previewDevice("iPhone 13")

		OnBoardingPage()
					.previewDevice(.init(rawValue: "iPhone 8"))
	}
}

