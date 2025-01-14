//
//  CodeBlockView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI
import Foundation

/**
A view that displays a block of code with syntax highlighting.
It accepts following parameters:
 - `code`: The source code to display in the view.
 - `displayMode`: A mode that controls the styling of the text, based on where the view is being used; in profile view or feeds view.
 */
struct CodeBlockView: View {
    var code: String
    var displayMode : PostDisplayMode
    var body: some View {
        VStack{
            ScrollView() { // Allow horizontal scrolling for long lines
                HStack{
                    Text(attributedString(for: code)) // Display the formatted code
                        .font(.system(displayMode == .displayModeFeed ? .body : .footnote, design: .monospaced)) // Use monospaced font
                        .padding()
                        .multilineTextAlignment(.leading) // Left-align the code
                        .foregroundColor(.white) // Default text color
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    
    /**
     Converts the given text into an `AttributedString` with syntax highlighting.
     It highlights Swift keywords in red and green.
     - Parameter code: The raw text to be attributed.
     - Returns: An `AttributedString` with highlighted keywords and strings.
     */
    func attributedString(for code: String) -> AttributedString {
        var attributedString = AttributedString(code)
        // Define Swift keywords and regex pattern for strings
            let keywords = ["let", "var", "if", "else", "struct", "func", "return", "print", "for", "while", "switch", "case"]
            let stringPattern = "\\\\.*?\\\\"
            // Regex pattern to match strings
            // Highlight keywords
            for keyword in keywords {
                let ranges = code.ranges(of: keyword)
                for range in ranges {
                    if let attributedRange = Range(NSRange(range, in: code), in: attributedString) {
                        attributedString[attributedRange].foregroundColor = .red // Highlight keywords in red
                    }
                }
            }
            // Highlight strings (text within quotation marks)
            if let regex = try? NSRegularExpression(pattern: stringPattern) {
                let matches = regex.matches(in: code, range: NSRange(code.startIndex..., in: code))
                for match in matches {
                    if let stringRange = Range(match.range, in: code),
                       let attributedRange = Range(NSRange(stringRange, in: code), in: attributedString) {
                        attributedString[attributedRange].foregroundColor = .green // Highlight strings in green
                    }
                }
            }
            return attributedString
    }
}

/**
 An Extension on String to add functionality for finding ranges of substrings within a string.
 */
extension String {
    func ranges(of substring: String) -> [Range<String.Index>] {
        var result: [Range<String.Index>] = []
        var startIndex = self.startIndex
        while startIndex < self.endIndex,
              let range = self.range(of: substring, range: startIndex..<self.endIndex) {
            result.append(range)
            startIndex = range.upperBound
        }
        return result
    }
}


#Preview{
    CodeBlockView(code: "var testVar = Test()", displayMode: .displayModeFeed )
}
