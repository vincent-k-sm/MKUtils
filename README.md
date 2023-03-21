# MKTUtils

## 소개  
* 공통 유틸성 프레임워크

- [Requirements](#requirements)
- [Installation](#installation)
- [Features](#features)

<br><br>

## Requirements

| Platform | Minimum Swift Version | Installation | Status |
| --- | --- | --- | --- |
| iOS 13.0+ | 5.0 | [Swift Package Manager](#swift-package-manager), [Manual](#manually) | Need Test |

<br><br>

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding MKTUtils as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/vincent-k-sm/MKUtils", .upToNextMajor(from: "1.0.0"))
]
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate MKTUtils into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add MKTUtils as a git [submodule](https://github.com/vincent-k-sm/MKUtils) by running the following command:

  ```bash
  $ git submodule add https://github.com/vincent-k-sm/MKUtils
  ```

- Click on the `+` button under th Frameworks, Libraries, and Embedded Content
- Click on the `Add Other` and Select in `MKUtils` Directory
- Drag the `MKUtils` Directory into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.
    
- And that's it!

<br><br>

## Features
* [x] [Debug Print](#debug-print)
    * [x] [DebugOption](#debugoption)
* [x] [Swift Lint](#swift-lint)
* [x] [MKLocalize](#mklocalize)
<br><br>

# Debug Print
## Configuration
### DebugOption
* For set up appearance Debug.print
```swift
    struct DebugOption {
        var prefix: String?
        var ignoreDeinit: Bool = false
        var indent: Int = 2
    }

```
### HOW TO USE
```swift
let options: Debug.DebugOption(
    prefix: #what/you/wan't/setup/prefix'#,
    ignoreDeinit: #ignore/`deinit`print/for/debug#,
    indent: #indent/in/console#
)
Debug.configure(options: options)
```

### Output 
```swift
DebugOption(prefix: "TEST")
> 📌 [TEST] [MKTUtilsTests.swift](21)
```

```swift
Debug.configure(options: .init(indent: 2))
```
```swift
📌 [MKTUtilsTests.swift](22) | ⚙️ Function: testExample() | ⏱ TimeStamp: 14:57:17.9950
Code(
  title: "TEST",
  desc: "ddesc"
)
```

```swift
Debug.configure(options: .init(indent: 4))
```
```swift
📌 [MKTUtilsTests.swift](22) | ⚙️ Function: testExample() | ⏱ TimeStamp: 14:57:17.9950
Code(
    title: "TEST",
    desc: "ddesc"
)
```
---

<br><br>

# Swift Lint
## Configuration
Follow guide doc.
> [README](/Resources/SwiftLint/README.md)

# LocalizeKit
## Configuration
Follow guide doc.
> [README](/LocalizeKit/README.md)
