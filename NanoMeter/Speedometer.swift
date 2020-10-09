import SwiftUI

struct Speedometer: View {
    var mph = { String(format: "%.2f", $0 * 2.373) }
    @Binding var currentSpeed: (Double, Double, Double)?
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Text("x")
                    .font(.body)
                Image(systemName: "arrow.right")
                HStack {
                    Text(mph(currentSpeed?.0 ?? 0))
                    Text("MPH")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }.frame(maxWidth: .infinity)
            }
            Spacer()
            VStack(alignment: .center) {
                Text("y")
                    .font(.body)
                Image(systemName: "arrow.up")
                HStack {
                    Text(mph(currentSpeed?.1 ?? 0))
                    Text("MPH")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }.frame(maxWidth: .infinity)
            }
            Spacer()
            VStack(alignment: .center) {
                Text("z")
                    .font(.body)
                Image(systemName: "arrow.uturn.up")
                HStack {
                    Text(mph(currentSpeed?.2 ?? 0))
                    Text("MPH")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }.frame(maxWidth: .infinity)
            }
            Spacer()
        }.padding()
    }
}
