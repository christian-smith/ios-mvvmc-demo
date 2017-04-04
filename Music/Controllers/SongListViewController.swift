import UIKit

class SongListViewController: UIViewController {
    fileprivate var viewModel: SongListViewModel

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.allowsSelection = false
        return tableView
    }()

    init(viewModel: SongListViewModel) {
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
extension SongListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as! SongCell
        cell.setup(viewModel: viewModel.songCellViewModels[indexPath.row])
        return cell
    }
}
