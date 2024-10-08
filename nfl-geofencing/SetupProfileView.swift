import SwiftUI

struct SetupProfileView: View {
    let onFinish: () -> Void
    
    var body: some View {
        Text("Setup Profile")
        Button {
            onFinish()
        } label: {
            Text("Finish")
        }
    }
}

#Preview {
    SetupProfileView() {}
}
