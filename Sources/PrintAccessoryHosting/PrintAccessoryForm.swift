/**
# PrintAccessoryHosting: PrintAccessoryForm.swift

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

import SwiftUI

public protocol PrintAccessoryFormModel: PrintAccessoryModel
{
	associatedtype ValueView: View
	func view(forPrintAccessoryValueKeyPath keyPath: String) -> ValueView
}

public struct PrintAccessoryForm<Model: PrintAccessoryFormModel>: View
{
	public init(model: Model)
	{
		self.model = model
	}
	
	@ObservedObject var model: Model
	
	public var body: some View
	{
		Form {
			ForEach(Model.printAccessoryValueKeyPaths, id: \.self) { keyPath in
				model.view(forPrintAccessoryValueKeyPath: keyPath)
			}
		}
		.frame(width: 300)
		.padding()
	}
}

public extension PrintAccessoryFormModel where Self: NSObject
{
	func binding<Value>(forPrintAccessoryValueKeyPath keyPath: String) -> Binding<Value> where Value: Equatable
	{
		return .init(
			get: { self.value(forKeyPath: keyPath) as! Value },
			set: { [weak self] in
				guard let self = self else { return }
				self.setValue($0, forKeyPath: keyPath)
			}
		)
	}
}
