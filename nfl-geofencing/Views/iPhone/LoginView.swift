import SwiftUI

struct LoginInfo {
    var emailId: String
    var password: String
    
    static var blank: LoginInfo {
        LoginInfo(emailId: "", password: "")
    }
}

struct LoginView: View {
    let onFinish: () -> Void
    @State private var loginInfo = LoginInfo.blank
    @State private var isPresented = false
    @State private var isAnimating = false
    @State private var offsetY: CGFloat = -500
    @State private var offsetX: CGFloat = -700
    @State private var isBouncing = false
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("TitleIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 294, height: 111)
                    .offset(x: offsetX, y: offsetY)
                    .rotationEffect(.degrees(isAnimating ? 5 : 0))
                    .onAppear {
                        dropAnimation()
                    }
                Spacer()
                Button {
                    if let url = URL(string: "https://id.toyota/") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    ZStack {
                        Image("TOYOTA_logo")
                            .resizable()
                            .frame(width: 143, height: 24)
                    }
                    .frame(width: 334, height: 50)
                    .background()
                    .cornerRadius(8)
                    .shadow(color:.gray, radius: 3, y: 2)
                    
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            Spacer()
            Text("or")
                .font(.system(size: 24))
                .foregroundStyle(.gray)
            Spacer()
            VStack {
                VStack(alignment: .leading) {
                    Text("Email ID")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                    TextField("", text: $loginInfo.emailId)
                        .frame(maxWidth: .infinity)
                    Divider()
                }
                .frame(height: 72)
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                    SecureField("", text: $loginInfo.password)
                    Divider()
                }
                .frame(height: 72)
                HStack {
                    Spacer()
                    Text("Forgot Password?")
                        .font(.callout)
                        .foregroundStyle(.red)
                }
                Spacer()
                Button {
                    onFinish()
                } label: {
                    Text("Login")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(.red))
                }
                .buttonStyle(BorderlessButtonStyle())
                .listRowBackground(Color.clear)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(.gray)
                    Button {
                        isPresented = true
                    } label: {
                        Text("Register Now")
                            .foregroundStyle(.red)
                    }
                }
                .font(.system(size: 16))
            }
            .padding(30)
            .navigationDestination(isPresented: $isPresented) {
                SetupProfileView(isShowSetUpProfile: $isPresented)
            }
        }
    }
    private func dropAnimation() {
        withAnimation(.easeIn(duration: 1.0)) {
            offsetY = 0
            offsetX = -50
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            bounceAnimation()
        }
    }
    
    private func bounceAnimation() {
        let bounceCount = 4
        for i in 0..<bounceCount {
            withAnimation(.interpolatingSpring(stiffness: 50,  damping: 5)) {
                if bounceCount == 0 {
                    offsetY -= 20
                    offsetX += 10
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {print("a")
                        withAnimation {
                            offsetY += 20
                            offsetX += 10
                        }
                    }
                } else if i == 1 {
                    offsetY -= 15
                    offsetX += 7
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            offsetY += 15
                            offsetX += 7
                        }
                    }
                }
                else{
                    offsetY -= 10
                    offsetX += 5
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            offsetY += 10
                            offsetX += 5
                        }
                    }
                    if i == bounceCount - 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.linear(duration: 0.3).delay(1)) {
                                isAnimating.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView() {}
}
