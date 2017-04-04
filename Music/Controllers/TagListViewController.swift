import UIKit

class TagListViewController: UIViewController {
    fileprivate var viewModel: TagListViewModel

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TagCell.self, forCellReuseIdentifier: TagCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    init(viewModel: TagListViewModel) {
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
extension TagListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tagCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.identifier, for: indexPath) as! TagCell
        cell.setup(viewModel: viewModel.tagCellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TagListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tagCellViewModels[indexPath.row].selected()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
