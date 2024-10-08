import SwiftUI

struct Profile {
    var name: String
    var car: String
    var footballPosition: String
    var team: String
    
    static var blank: Profile {
        Profile(name: "", car: "", footballPosition: "", team: "")
    }
}

struct SetupProfileView: View {
    let onFinish: () -> Void
    @State private var draftProfile = Profile.blank
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack {
                        Circle().fill(.cyan).frame(height: 200)
                        Button {
                            
                        } label: {
                            Text("Connect with TOYOTA ID")
                                .foregroundStyle(.black)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).fill(.cyan))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                Section {
                    FormRow(title: "Name", text: $draftProfile.name)
                    FormRow(title: "Car", text: $draftProfile.car)
                    FormRow(title: "Football Position", text: $draftProfile.footballPosition)
                    FormRow(title: "Team", text: $draftProfile.team)
                }
                
                Button {
                    onFinish()
                } label: {
                    Text("OK")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(.cyan))
                }
                .buttonStyle(BorderlessButtonStyle())
                .listRowBackground(Color.clear)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .navigationTitle("Create Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FormRow: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
            TextField(title, text: $text)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    SetupProfileView() {}
}
