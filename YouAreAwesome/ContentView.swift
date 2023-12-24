
import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State private var imageName = "image"
    @State private var imageNumber = 0
    @State private var messageNumber = 0
    @State private var lastMessageNumber = -1
    @State private var lastImageNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundNumber = 0
    @State private var lastSoundNumber = 0
    @State private var soundIsOn = true

    
    var body: some View {
        
        VStack {
            Text("Relax 😌")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.black)
                .background(Color("Gold"))
                .padding()
                .cornerRadius(0)
        
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("Gold"))
                .cornerRadius(12)
                .shadow(radius: 20)
                .animation(.linear, value: message)
                .frame(maxWidth:400, maxHeight: 400)
                .padding()
                
            Text(message)
                .font(.largeTitle)
                .minimumScaleFactor(0.2)
                .multilineTextAlignment(.center)
                .fontWeight(.heavy)
                .italic()
                .foregroundColor(.black)
                .background(Color("Gold"))
                .frame(width: 300, height: 100)
                .frame(maxWidth: .infinity)
                .border(Color("Gold"), width: 3)
                .animation(.easeInOut, value: message)
                .padding()
            
            Spacer()
            
            HStack {
                
                Text("Turn sound \(soundIsOn ? "Off": "On")")
                
                Toggle("", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) {_ in
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    }
                Spacer()
                
                Button("Show Message") {
                    
                    let messages = ["You are Awesome.",
                                    "You are great.",
                                    "Fabulous, That's you.",
                                    "You're swifty",
                                    "Relax with stretches"]
                    
                     lastMessageNumber = randomNonRepeatingNumber(
                        upperBound: messages.count-1,
                        lastRandomNumber: lastMessageNumber)
                    
                    message = messages[lastMessageNumber]
                    
                    lastImageNumber  = randomNonRepeatingNumber(
                        upperBound: 5,
                        lastRandomNumber: lastImageNumber)
                    
                    imageName = "image\(lastImageNumber)"
                    
                    lastSoundNumber = randomNonRepeatingNumber(
                        upperBound: 5,
                        lastRandomNumber: lastSoundNumber)
                                        
                    let soundName = "sound\(lastSoundNumber)"
                    
                    if soundIsOn {
                        playSound(soundName: soundName)
                    }
                    
                    
                    
                }
                .foregroundColor(.black)
                .buttonStyle(.borderedProminent)
            }
            .tint(Color("Gold"))
            .padding()
        }
    }
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😭 Could not read file. \(soundName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("🙄 Could not play audio. \(error.localizedDescription)")
        }
    }
    
    func randomNonRepeatingNumber(upperBound:Int, lastRandomNumber:Int)->Int {
        
        var randomNumber = Int.random(in: 0...upperBound)
        while randomNumber == lastRandomNumber {
            randomNumber = Int.random(in: 0...upperBound)
        }
        return randomNumber
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
