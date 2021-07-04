import UIKit


class TabBarController: UITabBarController {
    // MARK: - Observations
    
    private var notificationObservation: NSKeyValueObservation?
    // MARK: - Tabs

    lazy var courseDollar: UINavigationController = {
        let vc = CourseDollarListController()
        vc.viewModel = CourseDollarViewModel()

        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem.image = UIImage(systemName: "dollarsign.circle")
        nc.tabBarItem.title = nil
        return nc
    }()
    
    lazy var notifications: UINavigationController = {
        let vc = NotificationListController()
        vc.viewModel = NotificationViewModel()
        
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem.image = UIImage(systemName: "message")
        nc.tabBarItem.title = nil
        return nc
    }()
    //  MARK: - Lifecycle

    deinit {
        notificationObservation?.invalidate()
        notificationObservation = nil

        NotificationCenter.default.removeObserver(self, name: .didCreateNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didUpdateNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [courseDollar, notifications]

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didCreateNotification),
            name: .didCreateNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateNotification),
            name: .didUpdateNotification,
            object: nil
        )
        
        checkNotifications()
    }
    // MARK: - Actions

    @objc func didCreateNotification() {
        checkNotifications()
    }
    
    @objc func didUpdateNotification() {
        checkNotifications()
    }
    // MARK: - Private Methods
    
    private func checkNotifications() {
        DispatchQueue.main.async {
            let notifications = DataBaseManager.shared.getAllNotifications()
            let lookeds = notifications.filter({ $0.looked == false })
            
            self.tabBar.items?[1].badgeValue = lookeds.count != 0 ? String(lookeds.count) : nil
        }
    }
}
