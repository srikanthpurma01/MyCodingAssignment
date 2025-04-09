import SwiftUI

struct MembersView: View {
    @StateObject private var presenter = MembersPresenter()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search characters...", text: $searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }

                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                .onChange(of: searchText) {
                    presenter.searchCharacters(name: searchText)
                }

                if presenter.isLoading {
                    ProgressView().padding()
                }

                List(presenter.members) { member in
                    NavigationLink(destination: MemberDetailView(member: member)) {
                        HStack {
                            AsyncImage(url: URL(string: member.image)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text(member.name)
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Text(member.species).font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Rick & Morty Search")
        }
    }
}
