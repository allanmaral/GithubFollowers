//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Allan Amaral on 03/11/22.
//

import UIKit

enum UIHelpers {
  static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let gridGap: CGFloat = 10
    let availableWidth = width - (padding * 2) - (gridGap * 2)
    let itemWidth = availableWidth / 3

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 48)

    return flowLayout
  }
}
