//
//  UIViewController+Loading.swift
//  GHFollowers
//
//  Created by Allan Amaral on 08/11/22.
//

import UIKit

private var loadingView: GFLoadingView?

extension UIViewController {
    func showLoadingView() {
        let loading = GFLoadingView(frame: view.bounds)
        view.addSubview(loading)

        loading.startAnimating()
        loadingView = loading
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }

    func showEmptySateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
