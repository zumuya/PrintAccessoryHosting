/**
# PrintAccessoryHostingDemoApp: CustomPAM.swift

Copyright © 2022 zumuya
Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR
APARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
**/

import Foundation
import SwiftUI
import PrintAccessoryHosting

final class CustomPAM: NSObject, PrintAccessoryModel
{
	@Published @objc dynamic var x = 0.0
	@Published @objc dynamic var y = 0.0

	//MARK: - PrintAccessoryModel Methods
	
	static var printAccessoryValueKeyPaths = [
		#keyPath(x),
		#keyPath(y),
	]
	static func localizedTile(forPrintAccessoryValueKeyPath keyPath: String) -> String
	{
		switch keyPath {
		case #keyPath(x):
			return "X"
		case #keyPath(y):
			return "Y"
		default:
			fatalError()
		}
	}
	func localizedValueDescription(forPrintAccessoryValueKeyPath keyPath: String) -> String
	{
		switch keyPath {
		case #keyPath(x):
			return "\(round(x * 100)) %"
		case #keyPath(y):
			return "\(round(y * 100)) %"
		default:
			fatalError()
		}
	}
}
struct CustomPAV: View
{
	@ObservedObject var model: CustomPAM
	@Environment(\.colorScheme) private var colorScheme
	
	var body: some View
	{
		HStack(spacing: 20) {
			ZStack {
				Rectangle()
					.fill((colorScheme == .dark) ? .gray : .white)
				
				Rectangle()
					.stroke(.primary , lineWidth: 1)
				
				Ellipse()
					.fill(Color.red)
					.frame(width: 8, height: 8)
					.offset(x: (model.x * 70), y: (model.y * 70))
			}
			.gesture(
				DragGesture(minimumDistance: 0, coordinateSpace: .local)
					.onChanged { value in
						model.x = ((value.location.x - 70) / 70.0)
						model.y = ((value.location.y - 70) / 70.0)
					}
			)
			.clipped()
			.frame(width: 140, height: 140)
			
			VStack(alignment: .leading) {
				Text("X: \(model.localizedValueDescription(forPrintAccessoryValueKeyPath: #keyPath(CustomPAM.x)))")
				Text("Y: \(model.localizedValueDescription(forPrintAccessoryValueKeyPath: #keyPath(CustomPAM.y)))")
			}
			.frame(width: 80, alignment: .leading)
		}
		.padding()
	}
}
