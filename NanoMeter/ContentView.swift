import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ContentViewModel()
    @State var isRecording = false
    @State var countingDown = false
    @State var countdownValue = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var satisfiesSpeedRequirement: Bool {
        Int(model.currentSpeed ?? 0) == model.startingMph
    }
    
    var body: some View {
        VStack {
            Accelerometer(acceleration: $model.acceleration)
            
            Text("Current Speed")
                .font(.body)
                .fontWeight(.medium)
            Speedometer(currentSpeed: $model.currentSpeed)
            Spacer()
            if !isRecording {
                VStack {
                    Text("Starting Speed")
                        .font(.body)
                        .fontWeight(.medium)
                    Text(String(model.startingMph))
                        .font(.system(size: 100, weight: .medium, design: .monospaced))
                    Stepper(value: $model.startingMph, in: 45...80, step: 1) { }
                    .frame(width: 100)
                }.padding()
                Spacer()
            }
            Button {
                isRecording = !isRecording
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: isRecording ? "stop.circle": "play.circle")
                    Text(isRecording ? "Stop Recording" : "Start Recording")
                }.padding()
            }
            .padding(.horizontal, 8)
            .foregroundColor(.white)
            .background(
                Color.red
                    .opacity(satisfiesSpeedRequirement ? 1.0 : 0.2)
            )
            .disabled(!satisfiesSpeedRequirement)
            .cornerRadius(16)
        }
        .background((satisfiesSpeedRequirement ? Color.green.opacity(0.2) : Color.white).edgesIgnoringSafeArea(.all))
        .overlay(
            VStack {
                if isRecording {
                    let text = countdownValue != 0 ? String(countdownValue) : "RECORDING NOW"
                    Text(text)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                }
            }
        )
        .onReceive(timer) { _ in
            guard isRecording else { return }
            if countdownValue > 0 {
                countdownValue -= 1
            } else {
                timer.upstream.connect().cancel()
                model.beginRecording()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
