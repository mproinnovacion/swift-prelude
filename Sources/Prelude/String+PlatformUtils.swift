import Foundation
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit) || canImport(UIKit)
extension String {
	public static func htmlToPlain(_ string: String) -> String {
		let attributed = string.data(using: .utf8).flatMap { data in
			try? NSAttributedString(
				data: data,
				options: [
					NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
					NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
				],
				documentAttributes: nil
			)
		}
		
		return attributed?.string ?? string
	}
}
#endif
