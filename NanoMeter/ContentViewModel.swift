import Combine
import SwiftUI
import CoreMotion

class ContentViewModel: ObservableObject {
    @Published var currentSpeed: (Double, Double, Double)?
    @Published var acceleration: CMAcceleration?
    @Published var startingMph: Int = 60
    private var previousAcceleration: CMAcceleration?
    let motionManager = CMMotionManager()
    var timer: Timer!
    
    init() {
        motionManager.accelerometerUpdateInterval = 1/60
        motionManager.startAccelerometerUpdates()

        timer = Timer.scheduledTimer(timeInterval: 1/10, target: self, selector: #selector(ContentViewModel.update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            previousAcceleration = acceleration
            acceleration = accelerometerData.acceleration
            updateSpeed()
        } else {
            print("no acceleration data")
        }
    }
    
    private func updateSpeed() {
        guard let acceleration = acceleration, let prevAcceleration = previousAcceleration else {
            return
        }
        let x = (acceleration.x - prevAcceleration.x) / (1/10) / 0.98
        let y = (acceleration.y - prevAcceleration.y) / (1/10) / 0.98
        let z = (acceleration.z - prevAcceleration.z) / (1/10) / 0.98
        currentSpeed = (x, y, z)
    }
}
