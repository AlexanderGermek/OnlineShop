//
//  CustomCornerShape.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI

struct CustomCornerShape: Shape {
		var corners: UIRectCorner
		var radius: CGFloat

		func path(in rect: CGRect) -> Path {
				let path = UIBezierPath(roundedRect: rect,
																byRoundingCorners: corners,
																cornerRadii: CGSize(width: radius, height: radius)
				)
				return Path(path.cgPath)
		}
}
