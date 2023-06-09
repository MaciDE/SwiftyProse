//
//  PlaygroundView.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 29.04.23.
//

import SwiftyProse
import SwiftUI

struct PlaygroundView: View {
    
    let json = #"""
        {
          "type": "doc",
          "content": [
            {
              "type": "heading",
              "attrs": {
                "level": 1
              },
              "content": [
                {
                  "type": "text",
                  "marks": [
                    {
                      "type": "bold"
                    }
                  ],
                  "text": "Heading 1"
                }
              ]
            },
            {
              "type": "paragraph",
              "content": [
                {
                  "type": "text",
                  "marks": [
                    {
                      "type": "link",
                      "attrs": {
                        "target": "_blank",
                        "href": "https://github.com/MaciDE/SwiftyProse/"
                      }
                    },
                    {
                      "type": "bold"
                    }
                  ],
                  "text": "SwiftyProse:"
                },
                {
                  "type": "text",
                  "text": " A customizable UI component that renders "
                },
                {
                  "type": "text",
                  "marks": [
                    {
                      "type": "link",
                      "attrs": {
                        "target": "_blank",
                        "href": "https://prosemirror.net"
                      }
                    },
                    {
                      "type": "bold"
                    }
                  ],
                  "text": "ProseMirror"
                },
                {
                  "type": "text",
                  "text": " documents in "
                },
                {
                  "type": "text",
                  "marks": [
                    {
                      "type": "bold"
                    }
                  ],
                  "text": "SwiftUI."
                }
              ]
            },
            {
              "type": "blockquote",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
                    }
                  ]
                }
              ]
            },
            {
              "type": "bulletList",
              "content": [
                {
                  "type": "listItem",
                  "content": [
                    {
                      "type": "paragraph",
                      "content": [
                        {
                          "type": "text",
                          "text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                        }
                      ]
                    }
                  ]
                },
                {
                  "type": "listItem",
                  "content": [
                    {
                      "type": "paragraph",
                      "content": [
                        {
                          "type": "text",
                          "text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                        }
                      ]
                    }
                  ]
                },
                {
                  "type": "listItem",
                  "content": [
                    {
                      "type": "paragraph",
                      "content": [
                        {
                          "type": "text",
                          "text": "Nested list"
                        }
                      ]
                    },
                    {
                      "type": "bulletList",
                      "content": [
                        {
                          "type": "listItem",
                          "content": [
                            {
                              "type": "paragraph",
                              "content": [
                                {
                                  "type": "text",
                                  "text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                                }
                              ]
                            }
                          ]
                        },
                        {
                          "type": "listItem",
                          "content": [
                            {
                              "type": "paragraph",
                              "content": [
                                {
                                  "type": "text",
                                  "text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                                }
                              ]
                            }
                          ]
                        },
                        {
                          "type": "listItem",
                          "content": [
                            {
                              "type": "paragraph",
                              "content": [
                                {
                                  "type": "text",
                                  "text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                                }
                              ]
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
    """#
    
    @State private var textColor: Color = .red
    @State private var linkColor: Color = .blue
    @State private var headingTextColor: Color = .yellow
    @State private var nodeSpacing: CGFloat = 0
    @State private var paragraphLineSpacing: CGFloat = 0
    @State private var textFont: UIFont = .systemFont(ofSize: 14)
    @State private var headingFont: UIFont = .systemFont(ofSize: 14)
    @State private var linkFont: UIFont = .systemFont(ofSize: 14)
    
    @State private var presentSettings: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Group {
                    if #available(iOS 15, *),
                       let doc = decode(str: json)
                    {
                        doc
                            .headingStyle(.custom)
                    }
                    if let doc = decode(str: json) {
                        doc
                    }
                    if let doc = decode(str: json) {
                        doc
                    }
                    if let doc = decode(str: json) {
                        doc
                    }
                    if let doc = decode(str: json) {
                        doc
                    }
                    if let doc = decode(str: json) {
                        doc
                    }
                    if let doc = decode(str: json) {
                        doc
                    }
                    if #available(iOS 15, *),
                        let doc = decode(str: json) {
                        doc
                            .paragraphStyle(.custom)
                    }
                }
            }
            .padding()
            .proseTextColor(UIColor(textColor))
            .proseLinkColor(UIColor(linkColor))
            .proseHeadingTextColor(UIColor(headingTextColor))
            .proseNodeSpacing(nodeSpacing)
            .proseParagraphLineSpacing(paragraphLineSpacing)
            .proseTextFont(textFont)
            .proseHeadingFont(headingFont)
            .proseLinkFont(linkFont)
        }.toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button {
                    presentSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                }

            }
        }.sheet(isPresented: $presentSettings) {
            if #available(iOS 16, *) {
                SettingsView(
                    textColor: $textColor,
                    linkColor: $linkColor,
                    headingTextColor: $headingTextColor,
                    nodeSpacing: $nodeSpacing,
                    paragraphLineSpacing: $paragraphLineSpacing,
                    textFont: $textFont,
                    headingFont: $headingFont,
                    linkFont: $linkFont
                )
                    .presentationDetents([.medium])
            } else {
                SettingsView(
                    textColor: $textColor,
                    linkColor: $linkColor,
                    headingTextColor: $headingTextColor,
                    nodeSpacing: $nodeSpacing,
                    paragraphLineSpacing: $paragraphLineSpacing,
                    textFont: $textFont,
                    headingFont: $headingFont,
                    linkFont: $linkFont
                )
            }
        }
    }
    
    private func decode(str: String) -> DocNode? {
        do {
            let decoder = SwiftyProseDecoder()
            let document = try decoder.decode(str)
            return document
        } catch {
            NSLog("SwiftProse: \(error.localizedDescription)")
        }
        return nil
    }
}
