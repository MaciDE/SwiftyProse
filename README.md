# SwiftyProse
A customizable UI component that renders [ProseMirror](https://prosemirror.net) documents in SwiftUI.

[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg?style=flat)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)

## Example App
An example app is available to showcase and enable you to test some of `SwiftProse`'s features. It can be found in `./SwiftyProseDemo`. 

## Requirements
- Deployment target iOS 14.0+
- Swift 5+
- Xcode 

## Installation

### Swift Package Manager
To install `SwiftyProse` using [Swift Package Manager](https://swift.org/package-manager/), add `.package(name: "SwiftyProse", url: https://github.com/MaciDE/SwiftyProse.git", from: "1.0.0"),"` to your Package.swift, then follow [this](https://swift.org/package-manager#importing-dependencies) integration tutorial. 

## Using `SwiftProse`
Once you've installed `SwiftProse` into your project, creating a view that decodes and displays your ProseMirror-document is just a few steps.

### Currently supported node types
- Blockquote
- BulletList
- CodeBlock
- HardBreak
- Heading
- HorizontalRule
- OrderedList
- Paragraph
- Text

### Currently supported mark types
- bold
- code
- highlight
- italic
- link
- strike
- superscript
- underline

### Basic Setup

#### Importing `SwiftyProse`
At the top of the file where you'd like to use `SwiftyProse`, import `SwiftyProse`:
```swift
import SwiftyProse 
```

#### Decode and create ˋDocNodeˋ
Create an instance of `SwiftyProseDecoder`and use the `decode` function to decode a JSON string that represents your document. The `decode` function returns a view of type `DocNode` that you can render in a view's body. 

```swift
let JSON = #"""
    {
        "content" : [
            {
                "type" : "text",
                "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam"
            },
            {
                "type": "horizontalRule"
            },
            {
                "type" : "text",
                "text" : "nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"
            },
        ],
         "type" : "doc"
    }
"""#

var body: some View {
  if let doc = decode(str: JSON) {
      doc
  }
}

private func decode(str: String) -> DocNode? {
    do {
        let decoder = SwiftyProseDecoder()
        let document = try decoder.decode(str)
        return document
    } catch {
        NSLog("SwiftyProse: \(error.localizedDescription)")
    }
    return nil
}
```

### Customizing
SwiftyProse offers two options to customize the appearance of the decoded nodes.

#### Adjust the default styles
To adjust the default style of a node you can make use of a variety of view modifiers that update `EnvironmentValues`.

```swift
var body: some View {
    if let doc = decode(str: json) {
        doc
            // Change the text color of every text node
            .proseTextColor(UIColor.gray)
            // Change the link color
            .proseLinkColor(UIColor.blue)
            // Change the text color of all heading nodes
            .proseHeadingTextColor(UIColor.darkText)
            // Change the spacing between nodes
            .proseNodeSpacing(4)
            // Change the spacing between the lines of all paragraphs
            .proseParagraphLineSpacing(10)
            // Change the font used in all text nodes
            .proseTextFont(UIFont.systemFont(ofSize: 20))
            // Change the font used in all heading nodes
            .proseHeadingFont(UIFont.boldSystemFont(ofSize: 30))
            // Change the font used for displaying links
            .proseLinkFont(UIFont.systemFont(ofSize: 14, weight: .semibold))
    }
}   
``` 

#### Create your own styles
If you want to replace the default style used to display the nodes you are able to create your own styles.

To create your own style for a specific node, create a struct that confirms to the desired style and create your own view in the `makeBody` function. After that you are able to pass your custom style down to the desired nodes.

##### Available styles
- BlockquoteStyle
- BulletListStyle
- CodeBlockStyle
- HeadingStyle
- HorizontalRuleStyle
- OrderedListStyle
- ParagraphStyle

#### Examples

Custom heading style that uses SwiftUI's text view to display an attributed string instead of the default style that utilizes a UIextView.

```swift
import SwiftyProse
import SwiftUI

@available(iOS 15, *)
public struct CustomHeadingStyle: HeadingStyle {
    
    @Environment(\.proseTextColor)  var proseTextColor
    @Environment(\.proseTextFont) var proseTextFont
    @Environment(\.proseLinkColor) var proseLinkColor
    @Environment(\.proseLinkFont) var proseLinkFont
    
    public func makeBody(configuration: Configuration) -> some View {
        Text(AttributedString(buildAttributedString(
            from: configuration.content,
            attributes: configuration.attributes)))
    }
    
    private func buildAttributedString(
        from nodes: [NodeWrapper],
        attributes: HeadingAttributes?)
    -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            attributedString: nodes.reducedAttributedString(
                with: proseTextFont, textColor: proseTextColor))
        
        guard let attrs = attributes else { return attributedString }
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        var font = UIFont(name: "Asap-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        switch attrs.level {
        case 1:
            font = font.withSize(32)
        case 2:
            font = font.withSize(28)
        case 3:
            font = font.withSize(24)
        case 4:
            font = font.withSize(20)
        case 5:
            font = font.withSize(18)
        default:
            break
        }
        
        attributedString.addAttribute(.font, value: font, range: range)
        
        return attributedString
    }
}

@available(iOS 15, *)
public extension HeadingStyle where Self == CustomHeadingStyle {
    static var custom: Self { .init() }
}
```

Custom bullet list style that displays different bullets.

```swift
import SwiftyProse
import SwiftUI

public struct CustomBulletListStyle: BulletListStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            
            ForEach(configuration.content.indices, id: \.self) { i in
             
                let node = configuration.content[i]
                
                HStack(alignment: .firstTextBaseline) {
                    
                    Text(configuration.nestingLevel % 2 == 0 ? "👉" : "-")
                    
                    switch node {
                    case .listItem(let listItem):
                        listItem
                    default:
                        EmptyView()
                    }
                }
                
            }
            
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.red)
        )
    }
}

public extension BulletListStyle where Self == CustomBulletListStyle {
    static var custom: Self { .init() }
}
```

For more examples see the demo.
