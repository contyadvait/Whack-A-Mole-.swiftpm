//
//  GameView.swift
//  Whack-A-Mole
//
//  Created by Milind Contractor on 30/6/2024
//

import SwiftUI

enum GameItem {
    case mole, bomb, nothing
}

struct GameView: View {
    @State var score: Int = 0
    @State var lifes: Int = 3
    @State var gameBoard: [[GameItem]] = [[.nothing, .nothing, .nothing], [.nothing, .nothing, .nothing], [.nothing, .nothing, .nothing]]
    @State var countdownTimer: Int = 120
    @State var gameOver = true
    @State var timerRunning: Bool = false
    let possibleTypes: [GameItem] = [.nothing, .bomb, .mole]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var showEnd = false
    @AppStorage("highScore") var highScore: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("Whack-a-mole!")
                    .font(.title)
                Text("Score: \(score)")
                Text("Time: \(countdownTimer)")
                Text("Lives: \(lifes)")
                    .onReceive(timer) { _ in 
                        if timerRunning {
                            countdownTimer = countdownTimer - 1
                        }
                    }
                if !timerRunning {
                    Button {
                        timerRunning = true
                        generateBoard()
                    } label: {
                        Text("Start Game!")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background { Color.black }
            .cornerRadius(10.0)
            VStack {
                HStack {
                    button(row: 0, column: 0)
                    button(row: 0, column: 1)
                    button(row: 0, column: 2)
                }
                HStack {
                    button(row: 1, column: 0)
                    button(row: 1, column: 1)
                    button(row: 1, column: 2)
                }
                HStack {
                    button(row: 2, column: 0)
                    button(row: 2, column: 1)
                    button(row: 2, column: 2)
                }
            }
            
        }
        .alert("Game over!\nScore \(score)", isPresented: $showEnd, actions: {
            Button {
                timerRunning = true
                countdownTimer = 120
                generateBoard()
            } label: {
                Text("Restart")
            }
        })
    }
    
    func button(row: Int, column: Int) -> some View {
        Button {
            if gameBoard[row][column] == .mole {
                score = score + 1
            }
            reRoll(row: row, column: column)
        } label: {
            switch gameBoard[row][column] {
            case .nothing: 
                Image("Hole")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .cornerRadius(10.0)
            case .bomb: 
                Image("Bomb")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .cornerRadius(10.0)
            case .mole: 
                Image("Mole")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .cornerRadius(10.0)
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }
    
    func startStopTimer() {
        timerRunning.toggle()
        if timerRunning {
            lifes = 3
        }
    }
    
    func reRoll(row: Int, column: Int) {
        let previousOne: GameItem = gameBoard[row][column]
        if previousOne == .bomb {
            lifes = lifes - 1
            if lifes == 0 {
                timerRunning = false
                showEnd = true
            }
        }
        while gameBoard[row][column] == previousOne {
            gameBoard[row][column] = possibleTypes.randomElement() ?? .nothing
        }
        duplicateCheck()
        if highScore < score {
            highScore = score
        }
    }
    
    func duplicateCheck() {
        var mole = 0
        for row in gameBoard {
            for column in row {
                if column == .mole {
                    mole = mole + 1
                }    
            }
        }
        if mole == 0 {
            gameBoard[Int.random(in: 0...2)][Int.random(in: 0...2)] = .mole
        }
    }
    
    func generateBoard() {
        for (row, _) in gameBoard.enumerated() {
            for (column, _) in gameBoard[row].enumerated() {
                gameBoard[row][column] = possibleTypes.randomElement() ?? .nothing
            }
        }
    }
}


#Preview {
    GameView()
}
