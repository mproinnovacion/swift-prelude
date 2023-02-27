import Foundation

extension String {
	public func contains(_ find: String) -> Bool {
		self.range(of: find) != nil
	}
	
	public func containsIgnoringCase(_ find: String) -> Bool {
		self.range(of: find, options: .caseInsensitive) != nil
	}
	
	public func equalsIgnoringCase(_ other: String) -> Bool {
		self.uppercased() == other.uppercased()
	}
	
	public func containsDiacriticInsensitive(_ find: String) -> Bool {
		self.range(of: find, options: [ .caseInsensitive, .diacriticInsensitive ]) != nil
	}
	
	public static func isBlank(_ string: String?) -> Bool {
		guard string != nil else { return true }
		return string?.trimmingCharacters(
			in: CharacterSet.whitespacesAndNewlines
		).count == 0
	}
	
	public func trimmingHead(_ maxLength: Int, ellipsis: String = "…") -> String {
		let result = String(self.prefix(maxLength))
		
		guard result.count != self.count else {
			return result
		}
		
		return result + ellipsis
	}
	
	public func trimmingTail(_ maxLength: Int, ellipsis: String = "…") -> String {
		let result = String(self.suffix(maxLength))

		guard result.count != self.count else {
			return result
		}
		
		return ellipsis + result
	}
	
	public static func upperCase(_ string: String) -> String {
		string.uppercased()
	}
	
	public static func camelCase(_ string: String) -> String {
		string.capitalized(with: nil)
	}
	
	public static func underlineSpaces(_ string: String) -> String {
		string.replacingOccurrences(of: " ", with: "_")
	}
	
	public static func removeSpaces(_ string: String) -> String {
		string.replacingOccurrences(of: " ", with: "")
	}
	
	public static func removeTildeN(_ string: String) -> String {
		string
			.replacingOccurrences(of: "ñ", with: "n")
			.replacingOccurrences(of: "Ñ", with: "N")
	}

	public static func removeDiacritics(_ string: String) -> String {
		string.folding(
			options: [
				.diacriticInsensitive,
				.widthInsensitive,
				.caseInsensitive
			],
			locale: nil
		)
	}
	
	public static func trimWhitespace(_ string: String) -> String {
		string.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	public static func onlyAlphanumeric(_ string: String) -> String {
		String(string.unicodeScalars.filter(CharacterSet.alphanumerics.contains))
	}
}
