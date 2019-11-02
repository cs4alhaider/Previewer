//
//  SourceEditorCommand.swift
//  XcodeExtension
//
//  Created by Abdullah Alhaider on 11/3/19.
//  Copyright © 2019 Abdullah Alhaider. All rights reserved.
//

import Foundation
import XcodeKit

class CanvasForUIViewController: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

        let lines = invocation.buffer.lines
        let name = lines.getClassName() ?? ""

        let newCode = """

        // MARK: PreviewProvider
        #if DEBUG
        import SwiftUI

        struct \(name)_Previews: PreviewProvider {
            static var previews: some View {
                Container<\(name)>()
                    .edgesIgnoringSafeArea(.all)
                    .environment(\\.colorScheme, .light)
                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            }
            struct Container<T: UIViewController>: UIViewControllerRepresentable {
                func makeUIViewController(context: Context) -> T { T() }
                func updateUIViewController(_ uiViewController: T, context: Context) { }
            }
        }
        #endif
        """

        lines.addObjects(from: [newCode])
        completionHandler(nil)
    }

}

class CanvasForUIView: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

        let lines = invocation.buffer.lines
        let name = lines.getClassName() ?? ""

        let newCode = """

        // MARK: PreviewProvider
        #if DEBUG
        import SwiftUI

        struct \(name)_Previews: PreviewProvider {
            static var previews: some View {
                Container<\(name)>()
                    .edgesIgnoringSafeArea(.all)
                    .environment(\\.colorScheme, .light)
                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            }
            struct Container<T: UIView>: UIViewRepresentable {
                func makeUIView(context: Context) -> T { T() }
                func updateUIView(_ uiView: T, context: Context) { }
            }
        }
        #endif
        """

        lines.addObjects(from: [newCode])
        completionHandler(nil)
    }

}
