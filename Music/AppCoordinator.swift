import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let navigationController = UINavigationController()
    private let services: Services

    init(window: UIWindow, services: Services) {
        self.window = window
        self.services = services
        self.window.rootViewController = self.navigationController
        self.window.backgroundColor = UIColor.white
        self.window.makeKeyAndVisible()
    }

    public func start() {
        self.showTagsList()
    }

    private func showTagsList() {
        let viewModel = TagListViewModel(apiClient: services.apiClient)

        viewModel.didSelectTag = { [weak self] tag in
            self?.showCategory(tag: tag)
        }

        let tagListViewController = TagListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(tagListViewController, animated: false)
    }

    private func showCategory(tag: Tag) {
        let viewModel = CategoryListViewModel(apiClient: services.apiClient, tag: tag)

        viewModel.didSelectCategory = { [weak self] category in
            self?.showSongs(category: category)
        }

        let categoryListViewController = CategoryListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(categoryListViewController, animated: true)
    }

    private func showSongs(category: Category) {
        let viewModel = SongListViewModel(apiClient: services.apiClient, imageCache: services.imageCache, category: category)

        let songListViewController = SongListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(songListViewController, animated: true)
    }
}
