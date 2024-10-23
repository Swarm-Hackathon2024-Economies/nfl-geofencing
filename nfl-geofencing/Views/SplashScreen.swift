import SwiftUI


struct SplashScreen: View {
    @Binding var isShowSplash:Bool
    var body: some View {
        VStack {
            Image("TitleIcon")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .opacity(isShowSplash ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: isShowSplash)
        }
        .onAppear {
            isShowSplash = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 1)) {
                    isShowSplash = false
                }
            }
        }
        
    }
}
