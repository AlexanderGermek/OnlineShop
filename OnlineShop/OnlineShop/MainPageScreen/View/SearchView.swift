//
//  SearchView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 23.10.2022.
//

import SwiftUI

struct SearchView: View {
		var animation: Namespace.ID

		@EnvironmentObject var viewModel: HomeViewModel
		var body: some View {
				VStack {
						
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(
						Color.homeBackground.ignoresSafeArea()
				)
		}
}

struct SearchView_Previews: PreviewProvider {
		static var previews: some View {
				Home()
		}
}
