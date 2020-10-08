import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ContentViewModel()
    @State var isRecoding = false
        
    var body: some View {
        VStack {
            Text("Current Speed")
                .font(.body)
                .fontWeight(.medium)
            Speedometer(currentSpeed: $model.currentSpeed)
                
            Text("Current Acceleration")
                .font(.body)
                .fontWeight(.medium)
            Accelerometer(acceleration: $model.acceleration)
            
            Spacer()
            Button {
                isRecoding = !isRecoding
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: isRecoding ? "stop.circle": "play.circle")
                    Text(isRecoding ? "Stop Recording" : "Start Recording")
                }.padding()
            }
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(16)
        }
        .background(
            isRecoding
                ? Color.red.opacity(0.2).edgesIgnoringSafeArea(.all)
                : Color.white.edgesIgnoringSafeArea(.all)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
