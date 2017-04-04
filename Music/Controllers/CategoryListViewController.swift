import UIKit

class CategoryListViewController: UIViewController {
    fileprivate var viewModel: CategoryListViewModel

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    init(viewModel: CategoryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        addConstraints()
        bindViewModel()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
    }

    private func viewModelDidUpdate() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CategoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoryCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.setup(viewModel: viewModel.categoryCellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.categoryCellViewModels[indexPath.row].selected()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
