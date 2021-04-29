import UIKit

class TableView: UITableView {
    init(
        style: UITableView.Style = .plain,
        refreshControl: RefreshControl? = nil,
        backgroundColor: UIColor = .clear,
        allowsSelection: Bool = true,
        allowsMultipleSelectionDuringEditing: Bool = false,
        cells: [AnyClass] = [],
        automaticDimentioned: Bool = false,
        contentInset: UIEdgeInsets = .zero,
        emptyPlaceholderView: EmptyPlaceholderView? = nil
    ) {
        super.init(frame: .zero, style: style)
        
        if automaticDimentioned {
            self.rowHeight = UITableView.automaticDimension
            self.estimatedRowHeight = UITableView.automaticDimension
        }
        self.contentInset = contentInset
        self.refreshControl = refreshControl
        self.backgroundColor = backgroundColor
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelectionDuringEditing = allowsMultipleSelectionDuringEditing
        cells.forEach { register($0, forCellReuseIdentifier: String(describing: $0)) }
        self.showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        alwaysBounceVertical = false
        self.backgroundView = emptyPlaceholderView
        self.backgroundView?.isHidden = false
        self.backgroundView?.alpha = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func changePlaceholder(_ state: EmptyPlaceholderView.State) {
        switch state {
        case .hidden:
            self.backgroundView?.alpha = 0
        case .visible:
            UIView.animate(
                withDuration: 0.2,
                animations: {
                    self.backgroundView?.alpha = 1
                }
            )
        }
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
