/**
# PrintAccessoryHostingDemoApp: FormPAM.swift

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

final class FormPAM: NSObject, PrintAccessoryFormModel
{
	@Published @objc dynamic var hello = ""
	@Published @objc dynamic var hola = false
	@Published @objc dynamic var moi = 0.5
	
	//MARK: - PrintAccessoryModel Methods
	
	static var printAccessoryValueKeyPaths = [
		#keyPath(hello),
		#keyPath(hola),
		#keyPath(moi),
	]
	static func localizedTile(forPrintAccessoryValueKeyPath keyPath: String) -> String
	{
		switch keyPath {
		case #keyPath(hello):
			return "Hello"
		case #keyPath(hola):
			return "Hola"
		case #keyPath(moi):
			return "Moi"
		default:
			fatalError()
		}
	}
	func localizedValueDescription(forPrintAccessoryValueKeyPath keyPath: String) -> String
	{
		switch keyPath {
		case #keyPath(hello):
			return hello
		case #keyPath(hola):
			return "\(hola)"
		case #keyPath(moi):
			return "\(moi)"
		default:
			fatalError()
		}
	}
	
	//MARK: - PrintAccessoryFormModel Methods
	
	@ViewBuilder func view(forPrintAccessoryValueKeyPath keyPath: String) -> some View
	{
		let title = Self.localizedTile(forPrintAccessoryValueKeyPath: keyPath)
		switch keyPath {
		case #keyPath(hello):
			TextField(title, text: binding(forPrintAccessoryValueKeyPath: #keyPath(hello)))
		case #keyPath(hola):
			Toggle(title, isOn: binding(forPrintAccessoryValueKeyPath: #keyPath(hola)))
		case #keyPath(moi):
			Slider(value: binding(forPrintAccessoryValueKeyPath: #keyPath(moi)), in: 0...1) { Text(verbatim: title) }
		default:
			fatalError()
		}
	}
}
