import SwiftUI

struct IPadContentView: View {
    @ObservedObject private var locationManager = FakeLocationManager()
    @State private var navigationBarSelection: ToyotaNaviSidebar.Item = .map
    @State private var totalPoints: Int = 0
    
    var body: some View {
        ZStack {
            RouteNavigationView(locationManager: locationManager, totalPoints: $totalPoints)
                .toyotaNaviSidebar(selection: $navigationBarSelection)
                .overlay(alignment: .bottomTrailing) {
                    currentScoreCard
                }
            
            if locationManager.updatingFinished {
                ResultDialog(resultPoints: totalPoints)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
    
    var currentScoreCard: some View {
        VStack {
            Image("Eagles")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80)
            HStack {
                Image(systemName: "football.fill")
                    .foregroundStyle(.black)
                    .padding(4)
                    .background(Circle().fill(.white))
                Text("Points").italic().font(.title3)
                Spacer()
                Text("+\(totalPoints)")
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(RoundedRectangle(cornerRadius: 16).fill(.black))
        .frame(maxWidth: 300)
        .padding()
    }
}

struct ResultDialog: View {
    let resultPoints: Int
    @State private var progress: Float = 0
    @State private var points: Int = 0
    @State private var mileage: Float = 0
    @State private var time: Int = 0
    
    var body: some View {
        VStack {
            Image("Eagles")
                .padding()
            Text("Results").font(.largeTitle.bold())
            HStack(spacing: 0) {
                Image(systemName: "football.fill")
                    .font(.body)
                    .foregroundStyle(.black)
                    .padding(4)
                    .background(Circle().fill(.white))
                Text("Points").italic()
                Spacer()
                Text("+\(points)")
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
                    .foregroundStyle(.red)
                Text(" points")
                    .offset(y: 4)
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
            }
            .font(.title2)
            
            HStack(spacing: 0) {
                Text("Mileage").italic()
                Spacer()
                Text("\(String(format: "%.1f", mileage))")
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
                Text(" miles")
                    .offset(y: 4)
                    .fontWeight(.bold)
            }
            .font(.title2)
            
            HStack(spacing: 0) {
                Text("Time").italic()
                Spacer()
                Text("\(time)")
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
                Text("mins")
                    .offset(y: 4)
                    .fontWeight(.bold)
            }
            .font(.title2)
            
            ProgressView(value: progress)
                .tint(.red)
                .background(.gray)
            Text("Next Level 580/650")
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .frame(maxWidth: 300)
        .padding(.horizontal, 96)
        .padding(.vertical, 32)
        .background(RoundedRectangle(cornerRadius: 16).fill(.black))
        .foregroundStyle(.white)
        .onAppear {
            withAnimation {
                points = resultPoints
                mileage = 13.4
                time = 34
                progress = 0.6
            }
        }
    }
}

#Preview {
    IPadContentView()
}
