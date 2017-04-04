import UIKit

class SongCell: UITableViewCell {
    static let identifier = "SongCell"

    private var viewModel: SongCellViewModel?

    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(albumImageView)
        contentView.addSubview(label)
        addConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(viewModel vm: SongCellViewModel) {
        vm.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        
        vm.loadAlbumImage()
        viewModel = vm
        viewModelDidUpdate()
    }

    private func viewModelDidUpdate() {
        label.text = viewModel?.title
        albumImageView.image = viewModel?.image
    }

    private func addConstraints() {
        let margins = layoutMarginsGuide

        NSLayoutConstraint.activate([
                albumImageView.leftAnchor.constraint(equalTo: margins.leftAnchor),
                albumImageView.topAnchor.constraint(equalTo: margins.topAnchor),
                albumImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
                albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),

                label.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 7),
                label.rightAnchor.constraint(equalTo: margins.rightAnchor),
                label.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ])
    }
}
