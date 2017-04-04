import UIKit

class TagCell: UITableViewCell {
    static let identifier = "TagCell"

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(label)
        addConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(viewModel: TagCellViewModel) {
        label.text = viewModel.title
    }

    private func addConstraints() {
        let margins = layoutMarginsGuide

        NSLayoutConstraint.activate([
                label.leftAnchor.constraint(equalTo: margins.leftAnchor),
                label.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ])
    }
}
