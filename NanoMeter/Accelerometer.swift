import SwiftUI
import CoreMotion

struct Accelerometer: View {
    @Binding var acceleration: CMAcceleration?
    var mph = { String(format: "%.2f", $0 * 23.7) }

    var body: some View {
        VStack(spacing: 4) {
            Text("x:" + mph(acceleration?.x ?? 0))
            Text("y:" + mph(acceleration?.y ?? 0))
            Text("z:" + mph(acceleration?.z ?? 0))
        }.font(.caption)
    }
}
