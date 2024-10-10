import SwiftUI
import MapKit

struct HomeScreen: View {
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(.cyan)
                    .frame(width: 50, height: 50)
                VStack {
                    Text("Rikuto Yasuda")
                    Text("Aichi High School")
                }
                ZStack {
                    Rectangle()
                        .fill(.cyan)
                        .frame(width: 80, height: 30)
                        .cornerRadius(10)
                    Text("204Point")
                        .foregroundStyle(Color.white)
                        .font(.footnote)
                }
            }
            HStack {
                Button(action:{}) {
                    Button(action:{}) {
                        Text("NFL")
                            .padding(10)
                    }
                    .border(Color.cyan, width: 1)
                    Button(action:{}) {
                        Text("college")
                            .padding(10)
                    }
                    .border(Color.cyan, width: 1)
                    Button(action:{}) {
                        Text("High School")
                            .padding(10)
                    }
                    .border(Color.cyan, width: 1)
                    Button(action:{}) {
                        Text("FlagFootball")
                            .padding(10)
                    }
                    .border(Color.cyan, width: 1)
                }
                .frame(maxWidth: .infinity)
            }
            Text("League result")
            HStack {
                Circle()
                    .fill(.cyan)
                    .frame(width: 50)
                Text("2021")
            }
            HStack {
                Circle()
                    .fill(.cyan)
                    .frame(width: 50)
                Text("1942")
            }
            HStack {
                Circle()
                    .fill(.cyan)
                    .frame(width: 50)
                Text("1802")
            }
            Text("スケジュール")
            HStack {
                Text("14 September")
                Circle()
                    .fill(.cyan)
                    .frame(width: 50)
                Circle()
                    .fill(.cyan)
                    .frame(width: 50)
            }
            HStack {
                Text("15 September")
                Circle()
                    .fill(.cyan)
                    .frame(width: 50)
                Circle()
                    .fill(.cyan)
                    .frame(width: 50)
            }
            Text("Map")
            Map()
                .frame(width: 300, height: 200)
        }
    }
}

#Preview {
    HomeScreen()
}
