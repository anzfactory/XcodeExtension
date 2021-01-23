//
//  ClipboardTextTranslator.swift
//  DeepLConnecter
//
//  Created by sasato on 2021/01/23.
//

import AppKit
import Foundation
import XcodeKit

final class ClipboardTextTranslator: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        defer {
            completionHandler(nil)
        }
        
        guard
            let text = NSPasteboard.general.pasteboardItems?.first?.string(forType: .init(rawValue: "public.utf8-plain-text")),
            !text.isEmpty
        else {
            return
        }
        
        NSWorkspace.shared.open(.translationURL(text: text))
    }
}
