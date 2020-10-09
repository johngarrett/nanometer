import SwiftUI
import CoreMotion

struct Accelerometer: View {
    @Binding var acceleration: CMAcceleration?
    var mph = { String(format: "%.2f", $0 * 2.37) }

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                HStack {
                    Text("x")
                        .font(.body)
                    Image(systemName: "arrow.right")
                }
                HStack {
                    Text(String(acceleration?.x ?? 0))
                    Text("m/s²")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }.frame(maxWidth: .infinity)
            }
            Spacer()
            VStack(alignment: .center) {
                HStack {
                    Text("y")
                        .font(.body)
                    Image(systemName: "arrow.up")
                }
                HStack {
                    Text(String(acceleration?.y ?? 0))
                    Text("m/s²")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }.frame(maxWidth: .infinity)
            }
            Spacer()
            VStack(alignment: .center) {
                HStack {
                    Text("z")
                        .font(.body)
                    Image(systemName: "arrow.uturn.up")
                }
                HStack {
                    Text(String(acceleration?.z ?? 0))
                    Text("m/s²")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }.frame(maxWidth: .infinity)
            }
            Spacer()
        }.padding()
    }
}
