//
//  Liked.swift
//  OnlineShop
//
//  Created by Alexander Germek on 26.10.2022.
//

import SwiftUI

struct Liked: View {
		@EnvironmentObject var detailViewModel: DetailProductViewModel

		@State var showDeleteOption = false

		var body: some View {
				NavigationView {

						ScrollView(.vertical, showsIndicators: false) {

								VStack {

										HStack {
												Text("Favorities")
														.font(.custom(Font.raleway, size: 28).bold())

												Spacer()

												Button {
														withAnimation {
																showDeleteOption.toggle()
														}
												} label: {
														Image("Delete")
																.resizable()
																.aspectRatio(contentMode: .fit)
																.frame(width: 25, height: 25)
												}
												.opacity(detailViewModel.likedProducts.isEmpty ? 0 : 1)
										}

										if detailViewModel.likedProducts.isEmpty {
												NoLikedProductsView()
										} else {
												LikedProductsView()
										}
								}
								.padding()
						}
						.toolbar(.hidden, for: .navigationBar)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(Color.homeBackground.ignoresSafeArea())
				}
		}

		// MARK: some Views
		private func NoLikedProductsView() -> some View {
				Group {
						Image("NoLiked")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.padding()
								.padding(.top, 35)

						Text("No favorites yet")
								.font(.custom(Font.raleway, size: 25))
								.fontWeight(.semibold)

						Text("Hit the like button on each product page to save favorites ones.")
								.font(.custom(Font.raleway, size: 18))
								.padding(.horizontal)
								.padding(.top, 10)
								.multilineTextAlignment(.center)
				}
		}

		private func LikedProductsView() -> some View {
				VStack(spacing: 15) {
						ForEach(detailViewModel.likedProducts) { product in

								HStack(spacing: 0) {

										if showDeleteOption {

												Button {
														delete(product: product)
												} label: {
														Image(systemName: "minus.circle.fill")
																.font(.title2)
																.foregroundColor(.red)
												}
												.padding(.trailing)
										}

										CardView(product: product)
								}
						}
				}
				.padding(.top, 25)
				.padding(.horizontal)
		}

		private func CardView(product: Product) -> some View {
				HStack(spacing: 15) {
						Image(product.productImage)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 100, height: 100)

						VStack(alignment: .leading, spacing: 8) {
								Text(product.title)
										.font(.custom(Font.raleway, size: 18).bold())
										.lineLimit(1)

								Text(product.subtitle)
										.font(.custom(Font.raleway, size: 17))
										.fontWeight(.semibold)
										.foregroundColor(Color.customPurple)

								Text("Type: \(product.type.rawValue)")
										.font(.custom(Font.raleway, size: 13))
										.foregroundColor(.gray)
						}
				}
				.padding(.horizontal, 10)
				.padding(.vertical, 10)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color.white.cornerRadius(10))
		}

		// MARK: Private additional func's
		private func delete(product: Product) {
				if let index = detailViewModel.likedProducts.firstIndex(of: product) {
						let _ = withAnimation {
								detailViewModel.likedProducts.remove(at: index)
						}
				}
		}
}

struct Liked_Previews: PreviewProvider {
		static var previews: some View {
				Liked()
						.environmentObject(HomeViewModel())
						.environmentObject(DetailProductViewModel())

		}
}
