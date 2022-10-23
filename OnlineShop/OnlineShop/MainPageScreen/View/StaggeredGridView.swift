//
//  StaggeredGridView.swift
//  OnlineShop
//
//  Created by Alexander Germek on 23.10.2022.
//

import SwiftUI

struct StaggeredGridView<Content: View, T: Identifiable>: View where T: Hashable {
		// MARK: - Properties
		private var content: (T) -> Content

		private var list: [T]
		private var columns: Int

		private var showsIndicators: Bool
		private var spacing: CGFloat

		// MARK: - Init
		init(columns: Int,
				 showsIndicators: Bool = false,
				 spacing: CGFloat = 10,
				 list: [T],
				 content: @escaping (T) -> Content) {
				self.columns = columns
				self.showsIndicators = showsIndicators
				self.spacing = spacing
				self.list = list
				self.content = content
		}

		// MARK: - Body
		var body: some View {
				HStack(alignment: .top, spacing: 20) {
						ForEach(setUpList(), id: \.self) { columnData in
								LazyVStack(spacing: spacing) {
										ForEach(columnData) { object in
												content(object)
										}
								}
								.padding(.top, getIndex(values: columnData) == 1 ? 80: 0)
						}
				}
				.padding(.vertical)
		}

		// MARK: - Functions
		private func setUpList() -> [[T]] {
				var gridArray: [[T]] = Array(repeating: [], count: columns)

				/// splitting array for VStack oriented View
				var currentIndex = 0

				for object in list {
						gridArray[currentIndex].append(object)

						if currentIndex == columns-1 {
								currentIndex = 0
						} else {
								currentIndex += 1
						}
				}

				return gridArray
		}

		private func getIndex(values: [T]) -> Int {
				let index = setUpList().firstIndex { element in
						return element == values
				} ?? 0
				return index
		}

}

//struct StaggeredGridView_Previews: PreviewProvider {
//		static var previews: some View {
//		StaggeredGridView()
//		}
//}
