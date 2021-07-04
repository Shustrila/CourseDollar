import UIKit


class NotificationListController: UIViewController {
    // MARK: - View Model
    
    var viewModel: NotificationViewModel?
    // MARK: - Observations
    
    private var notificationObservation: NSKeyValueObservation?
    // MARK: - Views

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        return tableView
    }()
    
    lazy var emptyNotificationsView: UILabel = {
        let emptyNotificationsView = UILabel()
        emptyNotificationsView.translatesAutoresizingMaskIntoConstraints = false
        emptyNotificationsView.textAlignment = .center
        emptyNotificationsView.backgroundColor = .systemBackground
        emptyNotificationsView.text = "No notifications"
        emptyNotificationsView.tintColor = .label
        return emptyNotificationsView
    }()
    // MARK: - Lifecycle
    
    deinit {
        notificationObservation?.invalidate()
        notificationObservation = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeNotification()
        
        navigationItem.title = "Notification"
        
        view.addSubview(tableView)
        view.addSubview(emptyNotificationsView)
        
        setupConstraints()
        
        viewModel?.getNotification()
    }
    // MARK: - Methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            /// Table View
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            /// Empty Notifications View
            emptyNotificationsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: emptyNotificationsView.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: emptyNotificationsView.bottomAnchor, constant: 0),
            emptyNotificationsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
    }

    private func observeNotification() {
        notificationObservation = viewModel?.observe(\.notifications, options: [.new], changeHandler: { _, value in
            self.emptyNotificationsView.isHidden = value.newValue?.count ?? 0 > 0
            self.tableView.reloadData()
        })
    }
}


extension NotificationListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNotificationCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.getNotificationCell(tableView, indexPath: indexPath) as! NotificationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.lookedNotification(index: indexPath)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "delete") { (action, view, success) in
            self.viewModel?.deleteNotification(index: indexPath)
            success(true)
        }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
