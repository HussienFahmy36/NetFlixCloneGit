//
//  HomeViewController.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 12/10/2023.
//

import UIKit

enum Sections: Int {
    case TrendingMovies
    case TrendingTv
    case Popular
    case Upcoming
    case TopRated
}

@MainActor
class HomeViewController: UIViewController {
    let sectionTitles = [
        "Trending movies",
        "Trending Tv",
        "Popular",
        "Upcoming movies",
        "Top rated",
        
    ]

    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(homeFeedTable)
        homeFeedTable.dataSource = self
        homeFeedTable.delegate = self
        
        configureNavbar()

        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingMovies {[weak self] result in
            switch result {
            case .success(let titles):
                self?.randomTrendingMovie = titles.randomElement()
                DispatchQueue.main.async {
                    self?.headerView?.configure(with: TitleViewModel(titleName: self?.randomTrendingMovie?.original_name ?? "", posterURL: self?.randomTrendingMovie?.poster_path ?? ""))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func configureNavbar() {
        let image = UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        homeFeedTable.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)

    }
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
