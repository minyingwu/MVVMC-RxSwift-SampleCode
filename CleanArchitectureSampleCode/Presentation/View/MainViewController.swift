//
//  MainViewController.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/17.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var sortedSegement: UISegmentedControl!
    
    @IBOutlet weak var emptyPageLabel: UILabel!
    
    var refreshControl: UIRefreshControl?
    var viewModel: MainViewModel?
    weak var coordinator: MainCoordinator?
    
    private lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    func setupUI() {
        bindLoading()?.disposed(by: disposeBag)
        mainTableView.rx.setDelegate(self).disposed(by: disposeBag)
        mainTableView.setTransparentFooter()
        mainTableView.keyboardDismissMode = .onDrag
        setKeyboardGesture()
        addRefreshControl()
    }
    
    func setupViewModel() {
        guard let viewModel = viewModel else { return }
        
        sortedSegement.rx.value
            .map({APIEndpoints.DiscoverSorted(rawValue: $0)})
            .unwrap()
            .bind(to: viewModel.sortedRelay)
            .disposed(by: disposeBag)
        
        viewModel.isHiddenEmpty
            .bind(to: emptyPageLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.errorRelay
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] in
                    guard let error = $0 else { return }
                    self?.showAlert(message: error.localizedDescription) })
            .disposed(by: self.disposeBag)
        
        viewModel.movieItemsRelay
            .bind(to: mainTableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(type: MovieItemCell.self)
                return cell.configure(item) }
            .disposed(by: disposeBag)
        
        mainTableView.rx.willDisplayCell
            .filter { [weak self] in
                guard let self = self else { return false }
                return self.isLoadingIndexPath(indexPath: $0.indexPath) }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel?
                    .query()
                    .disposed(by: self.disposeBag) })
            .disposed(by: self.disposeBag)
        
        mainTableView.rx.itemSelected
            .bind(onNext: { [weak self] in
                    guard let items = self?.viewModel?.movieItemsRelay.value else { return }
                    self?.coordinator?+
                        .movieItem(items[safe: $0.row])-
                        .toNext() })
            .disposed(by: disposeBag)
    }
    
    private func isLoadingIndexPath(indexPath: IndexPath) -> Bool {
        let lastSectionIndex = self.mainTableView.numberOfSections - 1
        let lastItemIndex = self.mainTableView.numberOfRows(inSection: lastSectionIndex) - 1
        return indexPath.section == lastSectionIndex && indexPath.row == lastItemIndex
    }

}

extension MainViewController: Storyboarded {}
extension MainViewController: ViewModelable {}
extension MainViewController: Coordinated {}
extension MainViewController: Loadable {}
extension MainViewController: Alertable {}

extension MainViewController: Refreshable {
    func handleRefresh(_ sender: Any) {
        refreshControl?.endRefreshing()
        guard let selectSorted = viewModel?.selectSorted else { return }
        viewModel?.sortedRelay.accept(selectSorted)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
