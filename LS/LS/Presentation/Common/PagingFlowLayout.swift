//
//  PagingFlowLayout.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import UIKit

class PagingFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {

    private(set) var cellWitdhPercentage: CGFloat = 0.8
    private(set) var distanceBetweenCells: CGFloat = 16.0

    private var currentPositionIndex = 0

    init(cellWitdhPercentage: CGFloat, distanceBetweenCells: CGFloat) {
        self.cellWitdhPercentage = cellWitdhPercentage
        self.distanceBetweenCells = distanceBetweenCells
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = cellWitdh(forCollectionViewWidth: collectionView.frame.width)
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellDistance(forCollectionViewWidth: collectionView.frame.width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let collectionViewWidth = collectionView.frame.width
        let sides = collectionViewWidth - cellWitdh(forCollectionViewWidth: collectionViewWidth)
        let horizontalInset: CGFloat = sides / 2.0
        return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offsetWidthForOneItem = caculateContentOffsetForOneItem(scrollView)
        let offsetForCurrentItem = { CGPoint(x: offsetWidthForOneItem * CGFloat(self.currentPositionIndex),
                                             y: targetContentOffset.pointee.y) }

        enum HorizontalDirection { case left, right }
        let horizontalDirection: HorizontalDirection = velocity.x > 0 ? .right : .left

        switch horizontalDirection {
        case .left:
            let isFirstItem = currentPositionIndex <= 0
            guard isFirstItem == false else {
                targetContentOffset.pointee = offsetForCurrentItem()
                return
            }

            currentPositionIndex -= 1
            targetContentOffset.pointee = offsetForCurrentItem()

        case .right:
            let isLastItem = (scrollView.contentOffset.x + offsetWidthForOneItem >= scrollView.contentSize.width)
            guard isLastItem == false else {
                targetContentOffset.pointee = offsetForCurrentItem()
                return
            }

            currentPositionIndex += 1
            targetContentOffset.pointee = offsetForCurrentItem()
        }
    }

    private func cellWitdh(forCollectionViewWidth collectionViewWidth: CGFloat) -> CGFloat {
        let itemWidth = collectionViewWidth * cellWitdhPercentage
        return itemWidth
    }

    private func cellDistance(forCollectionViewWidth collectionViewWidth: CGFloat) -> CGFloat {
        let sides = collectionViewWidth - cellWitdh(forCollectionViewWidth: collectionViewWidth)
        let oneSide = sides / 2.0
        let final = min(distanceBetweenCells, oneSide / 2.0)
        return final
    }

    private func caculateContentOffsetForOneItem(_ scrollView: UIScrollView) -> CGFloat {
        let cellItemWidth = cellWitdh(forCollectionViewWidth: scrollView.frame.width)
        let sides = scrollView.frame.width - cellItemWidth
        let oneSide: CGFloat = sides / 2.0
        let nextItemVisiblePart = scrollView.frame.width - (oneSide + cellItemWidth + cellDistance(forCollectionViewWidth: scrollView.frame.width))
        return oneSide + (cellItemWidth - nextItemVisiblePart)
    }
}
