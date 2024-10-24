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
    //    let onFinish: () -> Void
    @Environment(\.dismiss) var dismiss
    @State private var draftProfile = Profile.blank
    let positionList = FootballPosition().positions
    @Binding var isShowSetUpProfile: Bool
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Create Profile")
                    .font(.title)
                    .bold()
                Spacer()
            }
            Spacer()
            ScalableImageView(UIImage(named: "add_photo")!)
                .frame(width: 100, height: 100)
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            Spacer()
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Your Car")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                    TextField("Crown Hybrid", text: $draftProfile.car)
                        .frame(maxWidth: .infinity)
                    Divider()
                }
                .frame(height: 72)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Player Name")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                        Text("*")
                            .foregroundStyle(.red)
                    }
                    TextField("", text: $draftProfile.name)
                        .frame(maxWidth: .infinity)
                    Divider()
                }
                .frame(height: 72)
                VStack(alignment: .leading, spacing: 10){
                    HStack {
                        Text("Your Position")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                        Text("*")
                            .foregroundStyle(.red)
                    }
                    HStack {
                        Menu {
                            ForEach(positionList, id: \.self) { content in
                                Button {
                                    draftProfile.footballPosition = content
                                } label: {
                                    Text(content.description)
                                }
                            }
                        } label: {
                            HStack {
                                Text(draftProfile.footballPosition.description).lineLimit(1)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(.black)
                        }
                    }
                    .frame(height: 22)
                    Divider()
                }
                .frame(height: 72)
                VStack(alignment: .leading, spacing: 10){
                    HStack {
                        Text("Your First Team")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                        Text("*")
                            .foregroundStyle(.red)
                    }
                    HStack {
                        Menu {
                            ForEach(positionList, id: \.self) { content in
                                Button {
                                    draftProfile.team = content
                                } label: {
                                    Text(content.description)
                                }
                            }
                        } label: {
                            HStack {
                                Text(draftProfile.team.description).lineLimit(1)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(.black)
                        }
                    }
                    .frame(height: 22)
                    Divider()
                }
                .frame(height: 72)
            }
            Spacer()
            NavigationLink {
                //                onFinish()
                TeamSelectView(isShowSetUpProfile: $isShowSetUpProfile)
            } label: {
                Text("Next")
                    .font(.system(size: 20))
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.red, lineWidth: 1)
                        .fill(.white))
                
            }
            .padding(1)
        }
        .padding(30)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                    }
                ).tint(.black)
            }
        }
    }
}


#Preview {
    SetupProfileView(isShowSetUpProfile: .constant(true))
}
