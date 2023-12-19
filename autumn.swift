import SwiftUI
import WebKit

struct ContentView: View {
    @State private var chatInputEncode = ""
    @State private var chatInputDecode = ""
    @State private var chatOutputEncode = ""
    @State private var chatOutputDecode = ""
    @State private var chatOutputCore = ""
    
    var body: some View {
        VStack {
            // Your logo image here
            WebView(url: "https://raw.githubusercontent.com/radicaldeepscale/Autumn/main/AutumnMindMap.png")
                .frame(width: 800, height: 400) // Adjust size accordingly
            
            // Algorithm Optimal State
            HStack {
                Text("Algorithm Optimal State:")
                Toggle("In", isOn: .constant(false))
                Toggle("Out", isOn: .constant(false))
            }
            .padding()
            
            // Encode Chat
            ChatContainer(title: "Encode", chatOutput: $chatOutputEncode, chatInput: $chatInputEncode)
            
            // Connections Stack
            VStack {
                Text("Connections:")
                ConnectionCheckbox(label: "Encode Send", dropdownOptions: ["Receive", "Respond"])
                ConnectionCheckbox(label: "Generation DATA", dropdownOptions: ["Receive Full Array", "Respond"])
                ConnectionCheckbox(label: "Receive", dropdownOptions: ["Encode Send"])
                ConnectionCheckbox(label: "Receive Full Array", dropdownOptions: ["Encode Send"])
                ConnectionCheckbox(label: "Respond", dropdownOptions: ["Paragraph Input Field"])
                // Add more ConnectionCheckbox views for other connection variables
            }
            .padding()
            
            // NLP Generation Core
            ChatContainer(title: "NLP Generation Core", chatOutput: $chatOutputCore, chatInput: .constant(""), isEditable: true)
            
            Button(action: {
                // Export logic
                exportParagraphToFile()
            }) {
                Text("Export Model (*.para)")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .padding()
            
            // Checkbox Stack
            VStack {
                Text("Order of Natural Tools:")
                Checkbox(label: "Maze, First")
                Checkbox(label: "Puzzle, Second")
                Checkbox(label: "Envelope, Third")
                Checkbox(label: "Hammer, Fourth")
                Checkbox(label: "Stick, Fifth")
                Checkbox(label: "Knife, Sixth")
                Checkbox(label: "Scissors, Seventh")
            }
            .padding()
            
            // Decode Chat
            DecodeChatContainer(chatOutput: $chatOutputDecode, chatInput: $chatInputDecode)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WebView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ChatContainer: View {
    let title: String
    @Binding var chatOutput: String
    @Binding var chatInput: String
    let isEditable: Bool

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
            
            TextEditor(text: $chatOutput)
                .frame(height: 100)
                .border(Color.black)
                .disabled(!isEditable)
            
            TextField("Type your message here...", text: $chatInput)
                .padding()
            
            Button(action: {
                // Send logic
            }) {
                Text("Send")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .padding()
        }
        .border(Color.black)
        .padding()
    }
}

struct ConnectionCheckbox: View {
    let label: String
    let dropdownOptions: [String]

    var body: some View {
        HStack {
            Text(label)
            Toggle("", isOn: .constant(false))
            Picker("", selection: .constant(0)) {
                ForEach(0..<dropdownOptions.count) { index in
                    Text(dropdownOptions[index])
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
    }
}

struct Checkbox: View {
    let label: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Toggle("", isOn: .constant(false))
        }
        .padding()
    }
}

struct DecodeChatContainer: View {
    @Binding var chatOutput: String
    @Binding var chatInput: String

    var body: some View {
        VStack {
            Text("Decode")
                .font(.title)
            
            TextEditor(text: $chatOutput)
                .frame(height: 100)
                .border(Color.black)
            
            TextField("Type your message here...", text: $chatInput)
                .padding()
            
            HStack {
                Button(action: {
                    // Receive logic
                }) {
                    Text("Receive")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    // Receive Full Array logic
                }) {
                    Text("Receive Full Array")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    // Respond logic
                }) {
                    Text("Respond")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding()
        }
        .border(Color.black)
        .padding()
    }
}

func exportParagraphToFile() {
    // Export logic
}