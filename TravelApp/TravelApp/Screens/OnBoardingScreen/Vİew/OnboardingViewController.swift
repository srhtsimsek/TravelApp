//
//  OnboardingViewController.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 27.04.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    //MARK: View
    private lazy var sliderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 13
        button.backgroundColor = .whiteFromColorSet
        button.tintColor = .blueFromColorSet
        button.addTarget(self, action: #selector(prevButtonClicked), for: .touchUpInside)
        return button
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 13
        button.backgroundColor = .whiteFromColorSet
        button.tintColor = .blueFromColorSet
        button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        return button
    }()
    private lazy var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.currentPage = self.currentPage
        pageControl.pageIndicatorTintColor = .grayFromColorSet
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: Properties
    private lazy var currentPage: Int = 0
    private lazy var isSignInButtonClicked: Bool = false
    private lazy var slideItems: [OnboardingSlideItem] = [
            OnboardingSlideItem(headline: "MACERAYA ATIL", subheadline: "Yüzlerce gezi rotasını keşfet. Tüm turistik yerleri gör.", image: UIImage(resource: ._1)),
            OnboardingSlideItem(headline: "SEYEHAT ARKADAŞLARI EDİN", subheadline: "Dünya çapında seyahat arkadaşı bul. Yüzlerce seyehatsever seni bekliyor. Hemen arkadaş ekle. Yola çık, mesajlaş. Eğlen.", image: UIImage(resource: ._2)),
            OnboardingSlideItem(headline: "HADİ BAŞLAYALIM", subheadline: "Gideceğin ülkedeki konaklama yerlerini gör. Rezervasyon oluştur.", image: UIImage(resource: ._3))
        ]
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Button Funcs
    @objc func prevButtonClicked() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if prevIndex == slideItems.count - 2 {
            nextButton.setTitle("Next", for: .normal)
            nextButton.tintColor = .blueFromColorSet
        }
    }
    
    @objc func nextButtonClicked() {
        let nextIndex = min(pageControl.currentPage + 1, slideItems.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        pageControl.currentPage = nextIndex
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if nextIndex == slideItems.count - 1 {
            if self.isSignInButtonClicked {
                redirectToLogin()
            } else {
                self.nextButton.setTitle("Sign In", for: .normal)
                self.nextButton.tintColor = .systemGreen
                self.isSignInButtonClicked = true
            }
        }
        
    }
    
    //MARK: Helpers
    private func redirectToLogin(){
        let loginScreenViewController = SignInViewController()
        loginScreenViewController.modalPresentationStyle = .fullScreen
        self.present(loginScreenViewController, animated: true)
        configFirstLaunch()
    }
    private func configFirstLaunch() {
        UserDefaults.standard.set(true, forKey: "isLaunchedBefore")
    }
    
    
    //MARK: Config UI
    private func setupUI(){
        addUIElements()
        configCollectionView()
        configStackView()
    }
    private func addUIElements(){
        view.addSubViewsFromExtension(sliderCollectionView, buttonsStackView)
    }
    private func configCollectionView(){
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
        sliderCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0)
    }
    private func configStackView(){
        buttonsStackView.addArrangedSubview(previousButton)
        buttonsStackView.addArrangedSubview(pageControl)
        buttonsStackView.addArrangedSubview(nextButton)
//        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.spacing = 0
        buttonsStackView.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingBottom: 30, paddingRight: 10)
    }
}

//MARK: -UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let countItems = slideItems.count
        pageControl.numberOfPages = countItems
        pageControl.isHidden = !(countItems > 1)
        return countItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as! OnboardingCollectionViewCell
        let slideItem = slideItems[indexPath.row]
        cell.updateItems(image: slideItem.image, headline: slideItem.headline, subheadline: slideItem.subheadline)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
                pageControl.currentPage = Int(x / view.frame.width)
    }
}
