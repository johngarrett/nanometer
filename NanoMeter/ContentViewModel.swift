import Combine
import SwiftUI
import CoreMotion
import CoreLocation

class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentSpeed: Double?
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

        timer = Timer.scheduledTimer(timeInterval: 1/10, target: self, selector: #selector(ContentViewModel.updateAcceleration), userInfo: nil, repeats: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentSpeed = location.speed * 2.373 // convert to mph
        }
    }
    
    func beginRecording() {
        print("starting recording")
        var dataPoints = [Date: Double]()
        while currentSpeed! > 0 {
            dataPoints[Date()] = currentSpeed
            print(dataPoints)
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
    
    @objc func updateAcceleration() {
        if let accelerometerData = motionManager.accelerometerData {
            previousAcceleration = acceleration
            acceleration = accelerometerData.acceleration
        } else {
//            print("no acceleration data")
        }
    }
}
