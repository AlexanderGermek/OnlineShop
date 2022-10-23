//
//  MoreProductsView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 23.10.2022.
//

import SwiftUI

struct MoreProductsView: View {
		var body: some View {
				VStack {
						Text("More Products")
								.font(.custom(Font.raleway, size: 24).bold())
								.foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading)
				}
				.padding()
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
				.background(
						Color.homeBackground.ignoresSafeArea()
				)
		}
}

struct MoreProductsView_Previews: PreviewProvider {
		static var previews: some View {
				MoreProductsView()
		}
}
