//
//  UIViewController+Alert.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

extension UIViewController {
  func presentAlert(title: String, message: String, actionText: String) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }

      let alertVC = GFAlertVC(title: title, message: message, buttonTitle: actionText)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }
}
