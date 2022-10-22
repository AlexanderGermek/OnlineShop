//
//  Home.swift
//  OnlineShop
//
//  Created by Alexander Germek on 22.10.2022.
//

import SwiftUI

struct Home: View {
		@Namespace var animation
		private var productLineAnimationName = "productLineAnimationName"
		@StateObject var viewModel: HomeViewModel = HomeViewModel()
		var body: some View {
				ScrollView(.vertical, showsIndicators: false) {
						VStack(spacing: 15) {

								/// Search Bar
								HStack(spacing: 15) {
										Image(systemName: "magnifyingglass")
												.font(.title2)
												.foregroundColor(.gray)

										TextField("Search", text: .constant(""))
												.disabled(true)
								}
								.padding(.vertical, 12)
								.padding(.horizontal)
								.background(
										Capsule()
												.strokeBorder(.gray, lineWidth: 0.8)
								)
								.frame(width: getScreenBounds().width / 1.6)
								.padding(.horizontal, 25)

								/// Main  Home Text
								Text("Order online\ncollect in store")
										.font(.custom(Font.raleway, size: 28).bold())
										.frame(maxWidth: .infinity, alignment: .leading)
										.padding(.top)
										.padding(.horizontal, 25)

								/// Products tabview
								ScrollView(.horizontal, showsIndicators: false) {
										HStack(spacing: 18) {
												ForEach(ProductType.allCases, id: \.self) { type in
														productTypeView(for: type)
												}
										}
										.padding(.horizontal, 25)
								}
								.padding(.top, 28)
						}
						.padding(.vertical)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(Color.homeBackground)
		}

		// MARK: Private functions
		private func productTypeView(for type: ProductType) -> some View {
				Button {
						withAnimation {
								viewModel.productType = type
						}
				} label: {
						Text(type.rawValue)
								.font(.custom(Font.raleway, size: 15))
								.fontWeight(.semibold)
								.foregroundColor(viewModel.productType == type ? Color.customPurple : .gray)
								.padding(.bottom, 10)
								/// Purple Line
								.overlay(
										/// Matched Geometry Effect - перетекающая анимация между элементами
										ZStack {
												if viewModel.productType == type {
														Capsule()
																.fill(Color.customPurple)
																.matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
																.frame(height: 2)
												} else {
														Capsule()
																.fill(.clear)
																.frame(height: 2)
												}
										}
										.padding(.horizontal, -5)
										, alignment: .bottom
								)
				}
		}
}

struct Home_Previews: PreviewProvider {
		static var previews: some View {
				Home()
		}
}
