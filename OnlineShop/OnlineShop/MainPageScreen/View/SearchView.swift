//
//  SearchView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 23.10.2022.
//

import SwiftUI

struct SearchView: View {
		var animation: Namespace.ID
		var searchBarMGE = "searchBarMGE"

		@EnvironmentObject var viewModel: HomeViewModel
		@FocusState var startTextField: Bool

		var body: some View {
				VStack(spacing: 0) {
						HStack(spacing: 20) {
								/// Close Button
								Button {
										withAnimation {
												viewModel.isSearchActivated = false
										}
										viewModel.searchText = ""
								} label: {
										Image(systemName: "arrow.left")
												.font(.title2)
												.foregroundColor(.black.opacity(0.7))
								}

								/// Search Bar
								HStack(spacing: 15) {
										Image(systemName: "magnifyingglass")
												.font(.title2)
												.foregroundColor(.gray)

										TextField("Search", text: $viewModel.searchText)
												.focused($startTextField)
												.textCase(.lowercase)
												.disableAutocorrection(true)
								}
								.padding(.vertical, 12)
								.padding(.horizontal)
								.background(
										Capsule()
												.strokeBorder(Color.customPurple, lineWidth: 1.5)
								)
								.matchedGeometryEffect(id: searchBarMGE, in: animation)
								.padding(.trailing, 20)
						}
						.padding(.horizontal)
						.padding(.top)
						.padding(.bottom, 5)

						/// Searching...
						if let searchedProducts = viewModel.searchedProducts {
								if searchedProducts.isEmpty {
										/// No results
										NoSearchedProductsView()
								} else {
										/// Filter Results
										ScrollView(.vertical, showsIndicators: false) {
												/// Staggered Grid
												VStack(spacing: 0) {
														Text("Found \(searchedProducts.count) results")
																.font(.custom(Font.raleway, size: 24).bold())
																.padding(.vertical)

														StaggeredGridView(columns: 2, spacing: 20, list: searchedProducts) { product in
																ProductCardView(product: product)
														}
												}
												.padding()
										}
								}
						} else {
								ProgressView()
										.padding(.top, 30)
										.opacity(viewModel.searchText == "" ? 0 : 1)
						}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
				.background(
						Color.homeBackground.ignoresSafeArea()
				)
				.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
								startTextField = true
						}
				}
		}


		private func NoSearchedProductsView() -> some View {
				VStack(spacing: 10) {

						Image("NotFound")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.padding(.top, 60)

						Text("Items Not Found")
								.font(.custom(Font.raleway, size: 22).bold())

						Text("Try a more generic search term or try looking for alternative products.")
								.font(.custom(Font.raleway, size: 16))
								.foregroundColor(.gray)
								.multilineTextAlignment(.center)
								.padding(.horizontal, 30)
				}
				.padding()
		}
}

struct SearchView_Previews: PreviewProvider {
		static var previews: some View {
				Home()
		}
}
