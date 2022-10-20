//
//  OnBoardingPage.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI

struct OnBoardingPage: View {
		@State var showLoginPage: Bool = false
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
					withAnimation {
							showLoginPage = true
					}
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
			.offset(y: getScreenBounds().height < 750 ? 20 : 40)

			Spacer()

		}
		.padding(.horizontal, 10)
		.padding(.top, getScreenBounds().height < 750 ? 0 : 20)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.customPurple)
		.overlay {
				Group {
						if showLoginPage {
								LoginPage()
										.transition(.slide)
						}
				}
		}
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


