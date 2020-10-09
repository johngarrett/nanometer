import SwiftUI

struct IdleView: View {
    @ObservedObject var model = ContentViewModel()
    @State var currentSpeed: Double?
    
    
    var satisfiesSpeedRequirement: Bool {
        Int(model.currentSpeed ?? 0) == model.startingMph
    }
    
    var body: some View {
        VStack {
            Accelerometer(acceleration: $model.acceleration)
            
            Text("Current Speed")
                .font(.body)
                .fontWeight(.medium)
        }
    }
}
