//
//  NewsViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/20.
//

import UIKit

import RxCocoa
import RxSwift

final class NewsViewController: UIViewController {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    // MARK: - Property

    var viewModel = NewsViewModel() // 뷰모델 인스턴스 생성
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        bindData()
//        setupViews()
    }
    
    // MARK: - Bind : 객체를 연결하고 핸들링해주는 코드, 어디서 어떻게 데이터가 구성되어 있는지는 모르고 있음
    // 뷰모델에서 컨트롤러로 데이터가 흘러 들어오는 상태
    
    private func bindData() {
        
        viewModel.pageNumber
            .withUnretained(self)
            .bind { (vc, value) in
//            print("bind == \(value)")
            vc.numberTextField.text = value
        }.disposed(by: disposeBag)
        
        viewModel.sampleNews
            .bind { [weak self] item in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
            snapshot.appendSections([0])
            snapshot.appendItems(item)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }.disposed(by: disposeBag)
        
        loadButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.loadSample()
            }.disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.resetSample()
            }.disposed(by: disposeBag)
        
//        numberTextField.rx.
//            .withUnretained(self)
//            .bind { (vc, _) in
//                vc.viewModel.changePageNumberFormat(text: numberTextField.rx.text)
//            }
//            .disposed(by: disposeBag)
    }
    
    // MARK: - Custom Method
    
    private func setupViews() {
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
        resetButton.addTarget(self, action: #selector(touchupResetButton), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(touchupLoadButton), for: .touchUpInside)
    }
    
    // MARK: - @objc
    // 뷰모델한테 데이터를 변경해달라고 달려가고 있음
    @objc func numberTextFieldChanged() {
        // 데이터의 흐름
        /*
         글자가 입력되면, 뷰모델의 pageNumber에게 넘겨주고,
         뷰모델은 쉼표를 찍고 데이터가공을 해서
         결과를 컨트롤러에게 넘겨서 화면에 보여줘야 함
         */
        
//        print(#function)
        guard let text = numberTextField.text else { return }
        viewModel.changePageNumberFormat(text: text)
    }
    
    @objc func touchupResetButton() {
        viewModel.resetSample()
    }
    
    @objc func touchupLoadButton() {
        viewModel.loadSample()
    }
}

// MARK: - Compositional + Diffable

extension NewsViewController {
    
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .lightGray
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, News.NewsItem> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.body
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
