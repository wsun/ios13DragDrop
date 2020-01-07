//
//  ViewController.swift
//  DragDrop
//

import UIKit

struct GroceryItem {
    var id: String
    var title: String
}

class ViewController: UICollectionViewController {
    private var groceryList: [GroceryItem] = [GroceryItem(id: "1", title: "1 lb apples"), GroceryItem(id: "2", title: "3 loaves bread"), GroceryItem(id: "3", title: "2 lbs chicken"), GroceryItem(id: "4", title: "5 slices of cheese")]
    let cellIdentifier = "cell"

    private struct Constants {
        static let horizPadding: CGFloat = 24
        static let topPadding: CGFloat = 40
        static let bottomPadding: CGFloat = 0
        static let defaultInsets: UIEdgeInsets = UIEdgeInsets(top: Constants.topPadding, left: Constants.horizPadding, bottom: Constants.bottomPadding, right: Constants.horizPadding)
        static let cellSpacing: CGFloat = 5
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        layout.minimumLineSpacing = Constants.cellSpacing
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(GroceryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor.white
        collectionView.delaysContentTouches = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = Constants.defaultInsets

        installsStandardGestureForInteractiveMovement = false
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPress.delegate = self
        collectionView.addGestureRecognizer(longPress)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groceryList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        if let cell = cell as? GroceryCell {
            cell.bind(groceryList[indexPath.item].title)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.inset(by: collectionView.contentInset).width, height: GroceryCell.Constants.minCellHeight)
    }
}

// MARK: - GestureRecognizer

extension ViewController: UIGestureRecognizerDelegate {
    @objc private func handleLongPress(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: recognizer.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)

        case .changed:
            var target = recognizer.location(in: collectionView)
            // locked to vertical only
            target.x = collectionView.center.x - Constants.defaultInsets.left
            collectionView.updateInteractiveMovementTargetPosition(target)

        case .ended:
            collectionView.endInteractiveMovement()

        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var newList = groceryList
        let movingItem = groceryList[sourceIndexPath.item]
        newList.remove(at: sourceIndexPath.item)
        newList.insert(movingItem, at: destinationIndexPath.item)
        groceryList = newList
    }
}
