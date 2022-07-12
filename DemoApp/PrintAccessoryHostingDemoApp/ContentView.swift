/**
# PrintAccessoryHostingDemoApp: ContentView.swift

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
import PrintAccessoryHosting

struct ContentView: View
{
	var body: some View
	{
		Button("Print…") {
			let printPanel = NSPrintPanel()
			
			let formViewAccessoryController = PrintAccessoryHostingController(model: FormPAM()) { model in
				PrintAccessoryForm(model: model)
			}
			formViewAccessoryController.title = "Form View"
			printPanel.addAccessoryController(
				formViewAccessoryController
			)
			
			let customViewAccessoryController = PrintAccessoryHostingController(model: CustomPAM()) { model in
				CustomPAV(model: model)
			}
			customViewAccessoryController.title = "Custom View"
			printPanel.addAccessoryController(
				customViewAccessoryController
			)
			
			let targetView = NSImageView(image: .init(named: NSImage.applicationIconName)!)
			targetView.sizeToFit()
			let printOperation = NSPrintOperation(view: targetView)
			printOperation.showsPrintPanel = true
			printOperation.printPanel = printPanel
			printOperation.run()
		}
		.padding()
	}
}
