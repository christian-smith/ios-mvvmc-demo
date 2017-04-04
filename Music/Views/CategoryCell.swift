import UIKit

class CategoryCell: UITableViewCell {
    static let identifier = "CategoryCell"

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

    public func setup(viewModel: CategoryCellViewModel) {
        label.text = viewModel.name
    }

    private func addConstraints() {
        let margins = layoutMarginsGuide

        NSLayoutConstraint.activate([
                label.leftAnchor.constraint(equalTo: margins.leftAnchor),
                label.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ])
    }
}
