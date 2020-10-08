import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ContentViewModel()
    @State var isRecoding = false
    
    private var mph = { String(format: "%.2f", $0 * 2.37) }
    
    var body: some View {
        VStack {
            Text("Current Speed")
                .font(.body)
                .fontWeight(.medium)
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Text("x")
                        .font(.body)
                    Image(systemName: "arrow.right")
                    HStack {
                        Text(mph(model.currentSpeed?.0 ?? 0))
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
                        Text(mph(model.currentSpeed?.1 ?? 0))
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
                        Text(mph(model.currentSpeed?.2 ?? 0))
                        Text("MPH")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                    }.frame(maxWidth: .infinity)
                }
                Spacer()
            }.padding()
                
            Text("Current Acceleration")
                .font(.body)
                .fontWeight(.medium)
            VStack(spacing: 4) {
                Text("x:" + mph(model.acceleration?.x ?? 0))
                Text("y:" + mph(model.acceleration?.y ?? 0))
                Text("z:" + mph(model.acceleration?.z ?? 0))
            }.font(.caption)
            
            Spacer()
            Button {
                print("action!")
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "play.circle")
                    Text("Start Recording")
                }.padding()
            }
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
