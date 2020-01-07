//
//  GroceryCell.swift
//  DragDrop
//

import UIKit

class GroceryCell: UICollectionViewCell {
    struct Constants {
        static let horizPadding: CGFloat = 12.0
        static let vertPadding: CGFloat = 8.0
        static let minCellHeight: CGFloat = 55.0
    }

    private struct Fonts {
        static let title = UIFont.appFontMedium(ofSize: 15.0)
        static let subtitle = UIFont.appFont(ofSize: 13.0)
    }

    private struct Colors {
        static let title = UIColor(rgb: 0x444444)
        static let highlight = UIColor(rgb: 0xECECEC)
        static let background = UIColor(rgb: 0xF4F5F6)
    }

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.title
        label.textColor = Colors.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var item: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = Colors.background
        contentView.layer.cornerRadius = 6.0
        contentView.addSubview(titleLabel)

        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizPadding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizPadding).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = isHighlighted ? Colors.highlight : Colors.background
        }
    }

    func bind(_ item: String) {
        self.item = item
        titleLabel.text = item
        contentView.backgroundColor = Colors.background
    }
}
