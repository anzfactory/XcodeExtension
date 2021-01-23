//
//  SourceEditorCommand.swift
//  DeepLConnecter
//
//  Created by sasato on 2021/01/22.
//

import AppKit
import Foundation
import XcodeKit

final class SelectedTextTranslator: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        defer {
            completionHandler(nil)
        }
        
        guard
            let lines = invocation.buffer.lines as? [String],
            let selectionRanges = invocation.buffer.selections as? [XCSourceTextRange],
            !selectionRanges.isEmpty
        else {
            return
        }
        
        let text = selectionRanges.map { (range) -> String in
            return (range.start.line ... range.end.line).map { row -> String in
                let line = lines[row] // 選択している行のテキストすべて
                let startColumn = row == range.start.line ? range.start.column : 0
                let endColumn = row == range.end.line ? range.end.column : line.count - 1
                let startIndex = line.index(line.startIndex, offsetBy: startColumn)
                let endIndex = line.index(line.startIndex, offsetBy: endColumn)
                return String(line[startIndex ..< endIndex]).trimmingCharacters(in: .whitespaces) // 選択範囲内の文字列を抽出
            }.joined(separator: " ")
        }.joined(separator: "\n")
        
        guard !text.isEmpty else {
            return
        }
        
        NSWorkspace.shared.open(.translationURL(text: text))
    }
}
