import SwiftUI
import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var acceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    
    func startMotionUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] (accelerometerData, error) in
                guard let self = self, let accelerometerData = accelerometerData else { return }
                self.acceleration = accelerometerData.acceleration
            }
        }
    }
    
    func stopMotionUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.stopAccelerometerUpdates()
        }
    }
}

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
        @State private var ballPosition = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        @State private var ballSize: CGFloat = 20
        @State private var ballVelocity = CGPoint(x: 0, y: 0)
        @State private var ballPath: [CGPoint] = []
        private let speedMultiplier: CGFloat = 2.0

        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    // Draw the path
                    Path { path in
                        if let firstPoint = ballPath.first {
                            path.move(to: firstPoint)
                            for point in ballPath {
                                path.addLine(to: point)
                            }
                        }
                    }
                    .stroke(Color.blue, lineWidth: 1)

                    // Draw the ball
                    Circle()
                        .fill(Color.blue)
                        .frame(width: ballSize, height: ballSize)
                        .position(ballPosition)
                }
                .onAppear {
                    motionManager.startMotionUpdates()
                    startUpdatingBallPosition(geometry: geometry)
                }
                .onDisappear {
                    motionManager.stopMotionUpdates()
                }
            }
        }

        private func startUpdatingBallPosition(geometry: GeometryProxy) {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                updateBallPosition()
            }
        }
    
    private func updateBallPosition() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let ax = CGFloat(motionManager.acceleration.x)
        let ay = CGFloat(motionManager.acceleration.y)
        let az = CGFloat(motionManager.acceleration.z)
        let damping: CGFloat = 0.95
        
        // Update velocity based on accelerometer data and damping factor
        ballVelocity.x += ax * 5 * speedMultiplier
        ballVelocity.y -= ay * 5 * speedMultiplier
        ballVelocity.x *= damping
        ballVelocity.y *= damping
        
        let newPositionX = ballPosition.x + ballVelocity.x
        let newPositionY = ballPosition.y + ballVelocity.y
        
        let minX = ballSize / 2
        let maxX = screenWidth - ballSize / 2
        let minY = ballSize / 2
        let maxY = screenHeight - ballSize / 2 - 100
        if newPositionX >= minX && newPositionX <= maxX {
            ballPosition.x = newPositionX
        } else {
            ballVelocity.x = 0
            ballPosition.x = newPositionX < minX ? minX : maxX
        }
        
        if newPositionY >= minY && newPositionY <= maxY {
            ballPosition.y = newPositionY
        } else {
            ballVelocity.y = 0
            ballPosition.y = newPositionY < minY ? minY : maxY
        }
        
        // Save only the last 1000 ball positions
        if ballPath.count >= 500 {
            ballPath.removeFirst()
        }
        ballPath.append(ballPosition)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
