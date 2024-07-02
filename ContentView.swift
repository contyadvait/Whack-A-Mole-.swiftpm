import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameOpening
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            if gameManager.action.isPresented {
                GameView()
            } else {
                VStack(spacing: 10) {
                    Image("Application Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(12.5, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding()
                    Text("Whack-A-Mole")
                        .font(.system(size: 45, weight: .heavy))
                        .padding()
                        .background { Color.black }
                        .cornerRadius(10.0)
                    Text("_Please play in fullscreen for the best view_")
                        .font(.system(size: 20, weight: .medium))
                        .padding()
                        .background { Color.black }
                        .cornerRadius(10.0)
                    Button {
                        gameManager.present()
                    } label: {
                        Text("Start")
                            .font(.system(size: 30, weight: .regular))
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical, 35.0)
                    Spacer()
                        .frame(width: 300.0, height: 100.0)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
