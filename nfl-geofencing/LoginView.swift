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
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("Eagles_logo")
                    .resizable()
                    .frame(width: 210, height: 91)
                Spacer()
                Text("APP NAME")
                    .font(.title)
                    .bold()
                Spacer()
                Button {
                    // TOYOTA LOGIN PAGE
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
                SetupProfileView()
            }
        }
    }
}

#Preview {
    LoginView() {}
}
