//
//  ContentView.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 08.11.21.
//

import SwiftUI
import SwiftyProse

struct ContentView: View {
    
    let blockQuoteJSON = #"""
        {
            "content" : [
                {
                    "type" : "blockquote",
                    "content": [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
                                }
                            ]
                        }
                    ]
                }
            ],
             "type" : "doc"
        }
    """#
    
    let bulletListJSON = #"""
        {
            "content" : [
                {
                    "type" : "bulletList",
                    "content" : [
                        {
                            "type" : "listItem",
                            "content" : [
                                {
                                    "type" : "paragraph",
                                    "content" : [
                                        {
                                            "type" : "text",
                                            "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "type" : "listItem",
                            "content" : [
                                {
                                    "type" : "paragraph",
                                    "content" : [
                                        {
                                            "type" : "text",
                                            "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "type" : "listItem",
                            "content" : [
                                 {
                                   "type" : "paragraph",
                                   "content" : [
                                     {
                                       "type" : "text",
                                       "text" : "Nested list"
                                     }
                                   ]
                                 },
                                {
                                    "type" : "bulletList",
                                    "content" : [
                                        {
                                            "type" : "listItem",
                                            "content" : [
                                                {
                                                    "type" : "paragraph",
                                                    "content" : [
                                                        {
                                                            "type" : "text",
                                                            "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                                                        }
                                                    ]
                                                }
                                            ]
                                        },
                                        {
                                            "type" : "listItem",
                                            "content" : [
                                                {
                                                    "type" : "paragraph",
                                                    "content" : [
                                                        {
                                                            "type" : "text",
                                                            "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
                                                        }
                                                    ]
                                                }
                                            ]
                                        },
                                        {
                                            "type" : "listItem",
                                            "content" : [
                                                {
                                                    "type" : "paragraph",
                                                    "content" : [
                                                        {
                                                            "type" : "text",
                                                            "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
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
            ],
             "type" : "doc"
        }
    """#
     
    let codeBlockJSON = #"""
        {
            "content" : [
                 {
                   "type" : "codeBlock",
                   "content" : [
                     {
                       "type" : "text",
                       "marks" : [
                         {
                           "type" : "bold"
                         }
                       ],
                       "text" : "Lorem ipsum"
                     },
                     {
                       "type" : "text",
                       "text" : " dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,"
                     },
                     {
                       "type" : "text",
                       "marks" : [
                         {
                           "type" : "bold"
                         }
                       ],
                       "text" : " sed diam voluptua."
                     },
                     {
                       "type" : "text",
                       "text" : " At vero eos et accusam et justo duo dolores et ea rebum."
                     }
                  ]
                }
            ],
             "type" : "doc"
        }
    """#
    
    let hardBreakJSON = #"""
        {
            "content" : [
                {
                    "type" : "text",
                    "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
                },
                {
                    "type": "hardBreak"
                },
                {
                    "type" : "text",
                    "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
                },
            ],
             "type" : "doc"
        }
    """#
    
    let headingJSON = #"""
        {
            "content" : [
                 {
                   "type" : "heading",
                   "attrs" : {
                     "level" : 5
                   },
                   "content" : [
                     {
                       "type" : "text",
                       "marks" : [
                         {
                           "type" : "bold"
                         }
                       ],
                       "text" : "Heading 5"
                     }
                   ]
                 },
                 {
                   "type" : "heading",
                   "attrs" : {
                     "level" : 4
                   },
                   "content" : [
                     {
                       "type" : "text",
                       "marks" : [
                         {
                           "type" : "bold"
                         }
                       ],
                       "text" : "Heading 4"
                     }
                   ]
                 },
                 {
                   "type" : "heading",
                   "attrs" : {
                     "level" : 3
                   },
                   "content" : [
                     {
                       "type" : "text",
                       "marks" : [
                         {
                           "type" : "bold"
                         }
                       ],
                       "text" : "Heading 3"
                     }
                   ]
                 },
                 {
                   "type" : "heading",
                   "attrs" : {
                     "level" : 2
                   },
                   "content" : [
                     {
                       "type" : "text",
                       "marks" : [
                         {
                           "type" : "bold"
                         }
                       ],
                       "text" : "Heading 2"
                     }
                   ]
                 },
                 {
                    "type" : "heading",
                    "attrs" : {
                        "level" : 1
                    },
                    "content" : [
                        {
                            "type" : "text",
                            "text" : "Heading 1"
                        }
                    ]
                },
                {
                    "type" : "heading",
                    "attrs" : {
                        "level" : 1
                    },
                    "content" : [
                        {
                            "type" : "text",
                            "marks" : [
                                {
                                    "type" : "bold"
                                }
                            ],
                            "text" : "Heading 1 bold"
                        }
                    ]
                },
                {
                    "type" : "heading",
                    "attrs" : {
                        "level" : 1
                    },
                    "content" : [
                        {
                            "type" : "text",
                            "marks" : [
                                {
                                    "type" : "italic"
                                }
                            ],
                            "text" : "Heading 1 italic"
                        }
                    ]
                },
                {
                    "type" : "heading",
                    "attrs" : {
                        "level" : 1
                    },
                    "content" : [
                        {
                            "type" : "text",
                            "marks" : [
                                {
                                    "type" : "italic"
                                },
                                {
                                    "type" : "bold"
                                }
                            ],
                            "text" : "Heading 1 bold italic"
                        }
                    ]
                }
            ],
             "type" : "doc"
        }
    """#
    
    let horizontalRuleJSON = #"""
        {
            "content" : [
                {
                    "type" : "text",
                    "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
                },
                {
                    "type": "horizontalRule"
                },
                {
                    "type" : "text",
                    "text" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
                },
            ],
             "type" : "doc"
        }
    """#
    
    let orderedListJSON = #"""
        {
            "content" : [
                {
                    "type" : "orderedList",
                    "content" : [
                        {
                            "type" : "listItem",
                            "content" : [
                                {
                                    "type" : "paragraph",
                                    "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 1"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 2"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 3"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 4"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 5"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 6"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 7"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                           "type" : "paragraph",
                           "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 8"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 9"
                                }
                            ]
                        }
                    ]
                },
                {
                    "type" : "listItem",
                    "content" : [
                        {
                            "type" : "paragraph",
                            "content" : [
                                {
                                    "type" : "text",
                                    "text" : "Item 10"
                                }
                            ]
                        }
                    ]
                },
           ]
         }
            ],
             "type" : "doc"
        }
    """#
    
    let paragraphJSON = #"""
        {
            "content" : [
                {
                    "type" : "paragraph",
                    "content" : [
                        {
                            "type" : "text",
                            "marks" : [
                                {
                                    "type" : "link",
                                    "attrs" : {
                                        "target" : "_blank",
                                        "href" : "https://github.com/MaciDE/SwiftyProse/"
                                    }
                                },
                                {
                                    "type" : "bold"
                                }
                            ],
                            "text" : "SwiftyProse:"
                        },
                        {
                            "type" : "text",
                            "text" : " A customizable UI component that renders "
                        },
                        {
                            "type" : "text",
                            "marks" : [
                                {
                                    "type" : "link",
                                    "attrs" : {
                                        "target" : "_blank",
                                        "href" : "https://prosemirror.net"
                                    }
                                },
                                {
                                    "type" : "bold"
                                }
                            ],
                            "text" : "ProseMirror"
                        },
                        {
                            "type" : "text",
                            "text" : " documents in "
                        },
                        {
                            "type" : "text",
                            "marks" : [
                                {
                                    "type" : "bold"
                                }
                            ],
                            "text" : "SwiftUI."
                        }
                    ]
                }
            ],
             "type" : "doc"
        }
    """#
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section(header: Text("BulletList")) {
                    if let doc = decode(str: bulletListJSON) {
                        doc
                    }
                }
                
                Section(header: Text("BlockQuote")) {
                    if let doc = decode(str: blockQuoteJSON) {
                        doc
                    }
                }
                
                Section(header: Text("CodeBlock")) {
                    if let doc = decode(str: codeBlockJSON) {
                        doc
                    }
                }
                
                Section(header: Text("HardBreak")) {
                    if let doc = decode(str: hardBreakJSON) {
                        doc
                    }
                }
                
                Section(header: Text("Heading")) {
                    if let doc = decode(str: headingJSON) {
                        doc
                    }
                }
                
                Section(header: Text("HorizontalRule")) {
                    if let doc = decode(str: horizontalRuleJSON) {
                        doc
                    }
                }
                
                Section(header: Text("OrderedList")) {
                    if let doc = decode(str: orderedListJSON) {
                        doc
                    }
                }
                
                Section(header: Text("Paragraph")) {
                    if let doc = decode(str: paragraphJSON) {
                        doc
                    }
                }
                
                NavigationLink {
                    PlaygroundView()
                } label: {
                    Text("Playground")
                }

                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("SwiftyProse")
            
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
}
