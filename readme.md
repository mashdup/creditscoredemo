# Credit Score App
## Quick Dashboard Display

Time Taken: **4** Hours\
Dependencies: Cocoapods, only for SwiftLint\
Linting: SwiftLint

## Features

- Animated Circular Progress Bar
- Colour change according to score progress level (-Inf-0.33. 0.34-0.66, 0.67 - Inf)
- Basic Localisation
- Dark Mode!
- Some Accessibility (for text)
- Blur effect for fun
- Background Image changing with dark mode

No tests were wrote due to little time, but code is split in layers for easy testing.\
Protocols used at Service Layer to provide Mocking\
Use of generics in the NetworkManager ensures responses are parsed correctly\
Error Handling using UIAlertController for now
