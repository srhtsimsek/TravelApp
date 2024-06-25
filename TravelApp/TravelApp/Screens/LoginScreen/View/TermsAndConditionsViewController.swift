//
//  TermsAndConditionsViewController.swift
//  notriphoiba
//
//  Created by Serhat  Şimşek  on 10.05.2024.
//

import UIKit
import WebKit

final class TermsAndConditionsViewController: UIViewController {
    
    //MARK: Properties
    private var urlString: String?
    
    //MARK: View
    private lazy var termsAndConditionsWebView = WKWebView()
    
    //MARK: Init
    init(url: String) {
        urlString = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        controlURL()
    }
    
    private func controlURL() {
        guard let url = URL(string: self.urlString!) else {
            self.dismiss(animated: true)
            return
        }
        self.termsAndConditionsWebView.load(URLRequest(url: url))
    }
    
    //MARK: Selector
    @objc private func clickedDoneBarButton() {
        self.dismiss(animated: true)
    }
    
    //MARK: SetupUI
    private func setupUI(){
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        configWebView()
        configBarButton()
    }
    
    private func configBarButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(clickedDoneBarButton))
    }
    
    private func configWebView() {
        view.addSubview(termsAndConditionsWebView)

        termsAndConditionsWebView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
}
