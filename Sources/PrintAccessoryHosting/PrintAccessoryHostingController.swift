/**
# PrintAccessoryHosting: PrintAccessoryHostingController.swift

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

import AppKit
import SwiftUI
import Combine

public protocol PrintAccessoryModel: ObservableObject
{
	static var printAccessoryValueKeyPaths: [String] { get }
		
	static func localizedTile(forPrintAccessoryValueKeyPath keyPath: String) -> String
	func localizedValueDescription(forPrintAccessoryValueKeyPath keyPath: String) -> String
}

public class PrintAccessoryHostingController<ContentView, Model>: NSViewController, NSPrintPanelAccessorizing where ContentView: View, Model: PrintAccessoryModel
{
	@nonobjc let model: Model
	@objc(model) var model_objc: AnyObject { model }
	let contentView: (Model) -> ContentView
	
	//MARK: - Init & Deinit
	
	public required init(model: Model, contentView: @escaping (Model) -> ContentView)
	{
		self.model = model
		self.contentView = contentView
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) { fatalError() }
	
	public override func loadView()
	{
		let hostingView = NSHostingView(rootView: contentView(model))
		hostingView.translatesAutoresizingMaskIntoConstraints = false
		self.view = hostingView
	}
	
	//MARK: - NSPrintPanelAccessorizing Methods
	
	public func keyPathsForValuesAffectingPreview() -> Set<String>
	{
		.init(Model.printAccessoryValueKeyPaths.map { #keyPath(model_objc) + "." + $0 })
	}
	public func localizedSummaryItems() -> [[NSPrintPanel.AccessorySummaryKey : String]]
	{
		Model.printAccessoryValueKeyPaths.map { [
			.itemName: Model.localizedTile(forPrintAccessoryValueKeyPath: $0),
			.itemDescription: model.localizedValueDescription(forPrintAccessoryValueKeyPath: $0),
		] }
	}
}
