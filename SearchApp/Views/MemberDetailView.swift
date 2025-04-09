import SwiftUI

struct MemberDetailView: View {
    let member: Members
    @State private var imageLoaded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(member.name)
                    .font(.largeTitle)
                    .bold()

                AsyncImage(url: URL(string: member.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(imageLoaded ? 1 : 0)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    imageLoaded = true
                                }
                            }
                            .transition(.opacity.combined(with: .scale))
                    case .failure:
                        Image(systemName: "xmark.octagon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.red)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text("Species: \(member.species)")
                Text("Status: \(member.status)")
                Text("Origin: \(member.origin.name)")
                if !member.type.isEmpty {
                    Text("Type: \(member.type)")
                }
                Text("Created: \(member.created)")
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}
