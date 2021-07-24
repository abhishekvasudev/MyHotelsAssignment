//
//  HomeViewController.swift
//  MyHotels
//
//  Created by Abhishek Vasudev on 22/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let screenTitle = "My Hotels"
    
    private var homeViewModel: HomeViewModel!
    private var emptyView = UIView()
    private var hotelsTableView: UITableView = {
        let table = UITableView()
        table.accessibilityIdentifier = "tableView"
        table.translatesAutoresizingMaskIntoConstraints = false;
        table.register(HotelCell.self, forCellReuseIdentifier: "HotelCell")
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Starting point of source of truth for DataStore
        homeViewModel = HomeViewModel(dataStore: DataStore(), self)
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForEmptyViewAppearance()
        hotelsTableView.reloadData()
    }
    
    private func setupViews() {
        setupBackground()
        setupNavigationBar()
        setupEmptyView()
        setupTableView()
    }
    
    private func setupBackground() {
        self.view.backgroundColor = MHColorScheme.tertiaryColor
    }
    
    private func setupNavigationBar() {
        self.title = screenTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: MHColorScheme.secondaryColor]
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                           target: self,
                                           action: #selector(addButtonAction))
        addBarButton.tintColor = MHColorScheme.secondaryColor
        
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc
    private func addButtonAction() {
        let addOrdEditViewModel = AddOrEditViewModel(dataStore: homeViewModel.getDataStore())
        let viewController = AddOrEditViewController(addOrEditViewModel: addOrdEditViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(hotelsTableView)
        hotelsTableView.backgroundColor = .clear
        hotelsTableView.separatorStyle = .none
        hotelsTableView.dataSource = self
        hotelsTableView.delegate = self
        
        // One way of enabling constraints
        var constraints: [NSLayoutConstraint] = []
        constraints.append(hotelsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(hotelsTableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(hotelsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(hotelsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupEmptyView() {
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        let informationLabel = UILabel()
        informationLabel.text = "Add a hotel which will appear in this list"
        informationLabel.numberOfLines = 0
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.textColor = MHColorScheme.secondaryColor
        emptyView.addSubview(informationLabel)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(emptyView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(informationLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor))
        constraints.append(informationLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.fetchHotels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelCell", for: indexPath as IndexPath) as! HotelCell
        cell.hotel = homeViewModel.fetchHotels()[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let hotel = homeViewModel.fetchHotels()[indexPath.row]
        let addOrdEditViewModel = AddOrEditViewModel(dataStore: homeViewModel.getDataStore(), hotel: hotel, hotelPosition: indexPath.row)
        let viewController = AddOrEditViewController(addOrEditViewModel: addOrdEditViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            homeViewModel.removeHotel(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func checkForEmptyViewAppearance() {
        if homeViewModel.fetchHotels().count > 0 {
            emptyView.isHidden = true
        } else {
            emptyView.isHidden = false
        }
    }
}
