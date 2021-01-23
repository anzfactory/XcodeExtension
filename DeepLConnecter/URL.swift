//
//  URL.swift
//  DeepLConnecter
//
//  Created by sasato on 2021/01/23.
//

import Foundation

extension URL {
    static let deepL: URL = URL(string: "https://www.deepl.com/")!
    
    static func translationURL(text: String) -> URL {
        guard let textEncoded = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return .deepL
        }
        return URL(string: "ja/translator#en/ja/\(textEncoded)", relativeTo: .deepL)!
    }
}
