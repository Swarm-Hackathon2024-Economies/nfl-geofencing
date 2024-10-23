import SwiftUI

struct ResultDialog: View {
    let resultPoints: Int
    @State private var progress: Float = 0
    @State private var points: Int = 0
    @State private var mileage: Float = 0
    @State private var time: Int = 0
    
    var body: some View {
        VStack {
            Text("Results").font(.largeTitle.bold())
            HStack(spacing: 0) {
                Image(systemName: "heart.circle")
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
    ResultDialog(resultPoints: 123)
}
