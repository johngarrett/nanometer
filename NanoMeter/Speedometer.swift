import SwiftUI

struct Speedometer: View {
    var mph = { String(format: "%.2f", $0) }
    @Binding var currentSpeed: Double?
    
    var body: some View {
        Text(mph(currentSpeed ?? 0))
            .font(.system(size: 100, weight: .medium, design: .monospaced))
    }
}
