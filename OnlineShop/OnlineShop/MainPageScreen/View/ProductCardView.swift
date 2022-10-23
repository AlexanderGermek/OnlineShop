//
//  ProductCardView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 23.10.2022.
//

import SwiftUI

struct ProductCardView: View {
		private var product: Product
		private var imageOffset: CGFloat

		init(product: Product, imageOffset: CGFloat = 50) {
				self.product = product
				self.imageOffset = imageOffset
		}

		var body: some View {
				VStack(spacing: 10) {

						Image(product.productImage)
								.resizable()
								.aspectRatio(contentMode: .fit)

						/// Moving image to top to look like its fixed at half top
								.offset(y: -imageOffset)
								.padding(.bottom, -imageOffset)

						Text(product.title)
								.font(.custom(Font.raleway, size: 18))
								.fontWeight(.semibold)
								.padding(.top)

						Text(product.subtitle)
								.font(.custom(Font.raleway, size: 14))
								.foregroundColor(.gray)

						Text(product.price)
								.font(.custom(Font.raleway, size: 16))
								.fontWeight(.bold)
								.foregroundColor(Color.customPurple)
								.padding(.top, 5)
				}
				.padding(.horizontal, 20)
				.padding(.bottom, 22)
				.background(
						Color.white.cornerRadius(25)
				)
				.padding(.top, imageOffset)
		}
}

struct ProductCardView_Previews: PreviewProvider {
		static var previews: some View {
				ProductCardView(product: Product(type: .phones, title: "iPhone 13", subtitle: "Black", price: "$799"))
		}
}
