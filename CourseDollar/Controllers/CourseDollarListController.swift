import UIKit


class CourseDollarListController: UIViewController {
        // MARK: - View Model
    
    var viewModel: CourseDollarViewModel?
    
    private var isFetchingObservation: NSKeyValueObservation?
    private var isErrorObservation: NSKeyValueObservation?
    private var courseDollarObservation: NSKeyValueObservation?
    // MARK: - Views

    lazy var loadIndicator: UIActivityIndicatorView = {
        let loadIndicator = UIActivityIndicatorView()
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadIndicator.startAnimating()
        loadIndicator.backgroundColor = .systemBackground
        loadIndicator.isHidden = true
        return loadIndicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CoureseDollarCell.self, forCellReuseIdentifier: "CoureseDollarCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var errorConnectionView: ErrorConnectionView = {
        let errorConnectionView = ErrorConnectionView()
        errorConnectionView.translatesAutoresizingMaskIntoConstraints = false
        errorConnectionView.delegate = self
        errorConnectionView.backgroundColor = .systemBackground
        errorConnectionView.isHidden = true
        return errorConnectionView
    }()
    // MARK: - Lifecycle

    deinit {
        courseDollarObservation?.invalidate()
        courseDollarObservation = nil

        isFetchingObservation?.invalidate()
        isFetchingObservation = nil

        isErrorObservation?.invalidate()
        isErrorObservation = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Course Dollar"

        view.addSubview(tableView)
        view.addSubview(loadIndicator)
        view.addSubview(errorConnectionView)
        
        setupConstraints()
        
        observeIsFetching()
        observeIsError()
        observeCourseDollar()
        
        viewModel?.getCourseDollar()
    }
    // MARK: - Methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            /// Table View
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            /// Load Indicator
            loadIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: loadIndicator.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: loadIndicator.bottomAnchor, constant: 0),
            loadIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            /// Error Connection View
            errorConnectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: errorConnectionView.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: errorConnectionView.bottomAnchor, constant: 0),
            errorConnectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        ])
    }
    
    private func observeIsFetching() {
        isFetchingObservation = viewModel?.observe(\.isFetching, options: [.new], changeHandler: { _, value in
            DispatchQueue.main.async {
                self.loadIndicator.isHidden = !(value.newValue ?? false)
            }
        })
    }
    
    private func observeIsError() {
        isErrorObservation = viewModel?.observe(\.isError, options: [.new], changeHandler: { _, value in
            DispatchQueue.main.async {
                self.errorConnectionView.isHidden = !(value.newValue ?? false)
            }
        })
    }
    
    private func observeCourseDollar() {
        courseDollarObservation = viewModel?.observe(\.courseDollar, options: [.new], changeHandler: { _, value in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}


extension CourseDollarListController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCourseDollarCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.getCourseDollarCell(tableView, indexPath: indexPath) as! CoureseDollarCell
    }
}


extension CourseDollarListController: ErrorConnectionViewDelegate {
    func errorConnectionView(didTapReload: ErrorConnectionView) {
        viewModel?.getCourseDollar()
    }
}
