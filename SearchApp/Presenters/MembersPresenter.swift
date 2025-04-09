import Foundation
import Combine

class MembersPresenter: ObservableObject {
    @Published var members: [Members] = []
    @Published var isLoading = false

    let interactor: MembersInteractorProtocol
    var cancellables = Set<AnyCancellable>()

    init(interactor: MembersInteractorProtocol = MembersInteractor()) {
        self.interactor = interactor
    }

    func searchCharacters(name: String) {
        guard !name.isEmpty else {
            members = []
            return
        }

        isLoading = true
        interactor.fetchMembersResults(name: name) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let members):
                    self?.members = members
                case .failure:
                    self?.members = []
                }
            }
        }
    }
}
