import Combine
import SwiftUI
import CoreMotion
import CoreLocation

class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentSpeed: (Double, Double, Double)?
    @Published var acceleration: CMAcceleration?
    @Published var startingMph: Int = 60
    
    let locationManager = CLLocationManager()
    private var previousAcceleration: CMAcceleration?
    let motionManager = CMMotionManager()
    var timer: Timer!
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        motionManager.accelerometerUpdateInterval = 1/60
        motionManager.startAccelerometerUpdates()

        timer = Timer.scheduledTimer(timeInterval: 1/10, target: self, selector: #selector(ContentViewModel.update), userInfo: nil, repeats: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentSpeed = (location.speed, 0, 0)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.startUpdatingLocation()
//        switch manager.authorizationStatus {
//        case .denined:
//            print("DENIED")
//        default:
//            print("default")
//            locationManager.startUpdatingLocation()
//        }
    }
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            previousAcceleration = acceleration
            acceleration = accelerometerData.acceleration
//            updateSpeed()
        } else {
          //  print("no acceleration data")
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
