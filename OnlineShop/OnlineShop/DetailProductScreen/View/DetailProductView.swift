//
//  DetailProductView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 24.10.2022.
//

import SwiftUI

struct DetailProductView: View {
//		var product: Product

		@EnvironmentObject var viewModel: DetailProductViewModel
		var body: some View {
				VStack {
						/// Title Bar and Product Image
						VStack {

								/// Title Bar
								HStack {
										/// Close detail view
										Button {
												withAnimation(.easeInOut) {
														viewModel.isShowDetailProduct = false
												}
										} label: {
												Image(systemName: "arrow.left")
														.font(.title2)
														.foregroundColor(.black.opacity(0.7))
										}

										Spacer()

										/// Liked
										Button {

										} label: {
												Image("Liked")
														.renderingMode(.template)
														.resizable()
														.aspectRatio(contentMode: .fit)
														.frame(width: 22, height: 22)
														.foregroundColor(.black.opacity(0.7))
										}
								}
								.padding()

								/// Product Image
								Image(viewModel.product?.productImage ?? "")
										.resizable()
										.aspectRatio(contentMode: .fit)
										.padding(.horizontal)
										.offset(y: -12)
										.frame(maxHeight: .infinity)

						}
						.frame(height: getScreenBounds().height / 2.7)

						/// Product Details
						ScrollView(.vertical, showsIndicators: false) {
								ProductDetailsView()
						}
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(
								Color.white
										.clipShape(CustomCornerShape(corners: [.topLeft, .topRight], radius: 25))
										.ignoresSafeArea()
						)
				}
				.background(Color.homeBackground.ignoresSafeArea())
		}

		// MARK: some Views
		private func ProductDetailsView() -> some View {
				VStack(alignment: .leading, spacing: 15) {
						/// Descriptions
						Text(viewModel.product?.title ?? "")
								.font(.custom(Font.raleway, size: 20).bold())

						Text(viewModel.product?.subtitle ?? "")
								.font(.custom(Font.raleway, size: 18))
								.foregroundColor(.gray)

						Text("Get Apple TV+ free for a year")
								.font(.custom(Font.raleway, size: 16).bold())
								.padding(.top)

						Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, $4.99/month after free trial.")
								.font(.custom(Font.raleway, size: 15))
								.foregroundColor(.gray)

						/// Full description
						Button {

						} label: {
								Label {
										Image(systemName: "arrow.right")
								} icon: {
										Text("Full description")
								}
								.font(.custom(Font.raleway, size: 15).bold())
								.foregroundColor(Color.customPurple)
						}

						/// Price
						HStack {
								Text("Total")
										.font(.custom(Font.raleway, size: 17))

								Spacer()

								Text("\(viewModel.product?.price ?? "")")
										.font(.custom(Font.raleway, size: 20).bold())
										.foregroundColor(Color.customPurple)
						}
						.padding(.vertical, 20)

				}
				.padding([.horizontal, .bottom], 20)
				.padding(.top, 25)
				.frame(maxWidth: .infinity, alignment: .leading)
		}

}

struct DetailProductView_Previews: PreviewProvider {
		static var previews: some View {
				let object = DetailProductViewModel()
				object.product = HomeViewModel().products[0]
				return DetailProductView()
						.environmentObject(object)
		}
}
