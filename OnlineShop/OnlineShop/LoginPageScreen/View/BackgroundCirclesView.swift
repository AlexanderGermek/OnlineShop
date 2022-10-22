//
//  BackgroundCirclesView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 20.10.2022.
//

import SwiftUI

struct BackgroundCirclesView: View {
		var body: some View {
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

						Circle()
								.strokeBorder(.white.opacity(0.3), lineWidth: 3)
								.frame(width: 30, height: 30)
								.blur(radius: 2)
								.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
								.padding(30)

						Circle()
								.strokeBorder(.white.opacity(0.3), lineWidth: 3)
								.frame(width: 23, height: 23)
								.blur(radius: 2)
								.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
								.padding(.leading, 30)
				}
		}
}

struct BackgroundCirclesView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCirclesView()
						.background(Color.customPurple)
    }
}
