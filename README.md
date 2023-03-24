# SwiftUI Motion Ball Tilt Game

## Overview

SwiftUI Motion Ball is a simple iOS application that demonstrates the use of SwiftUI and Core Motion to create an interactive ball on the screen. The ball moves in response to the device's accelerometer data, creating a path as it goes. Users can change the color of the ball and the path it leaves behind by single-tapping the screen, or alter the width of the path by double-tapping.

This project was developed through pair programming with ChatGPT-4, an advanced AI language model by OpenAI.

## Features

- Interactive ball that moves based on the device's accelerometer data
- Single tap to change the ball and path color (rotates through red, orange, yellow, green, blue, and purple)
- Double tap to change the width of the path (rotates through 1, 2, 3, 4, and 5)
- Paths drawn with different colors and widths remain unchanged when new settings are applied

## Requirements

- iOS 16.0 or later
- Xcode 13.0 or later
- Swift 5.5 or later

> Note: Accelerometer data does not work on the Simulator, so although you can build the app on it, the application will not function as expected. It is recommended to test the app on a physical device.

## Installation

1. Clone the repository:
    ```
    git clone https://github.com/thegafo/tilt.git
    ```

2. Open the project in Xcode by double-clicking the `SwiftUIMotionBall.xcodeproj` file or by opening Xcode and selecting "Open an existing project" from the Welcome screen.

3. Build and run the project by clicking the "Play" button in the top-left corner of the Xcode window or by pressing `Cmd + R`.

## Usage

1. Launch the app on an iOS device or an iOS Simulator.
2. Tilt the device to control the ball's movement. The ball will respond to the accelerometer data.
3. Single tap the screen to change the ball and path color. The colors will rotate through red, orange, yellow, green, blue, and purple.
4. Double tap the screen to change the path width. The path width will rotate through 1, 2, 3, 4, and 5.

## Acknowledgments

This project was built with the assistance of ChatGPT-4, an AI language model by OpenAI. ChatGPT-4 played a significant role in the development process through pair programming, helping to refine the code and implement new features.

