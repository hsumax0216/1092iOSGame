//
//  ListDisableScroll.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/25.
//
//https://stackoverflow.com/questions/60905671/disable-scrolling-in-swiftui-list-form

import SwiftUI
//import UIKit

struct ListScrollingHelper: UIViewRepresentable {
    let proxy: ListScrollingProxy // reference type

    func makeUIView(context: Context) -> UIView {
        return UIView() // managed by SwiftUI, no overloads
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        proxy.catchScrollView(for: uiView) // here UIView is in view hierarchy
    }
}

class ListScrollingProxy {
    enum Action {
        case end
        case top
        case point(point: CGPoint)     // << bonus !!
    }

    private var scrollView: UIScrollView?

    func catchScrollView(for view: UIView) {
        if nil == scrollView {
            scrollView = view.enclosingScrollView()
        }
    }

    func scrollTo(_ action: Action) {
        if let scroller = scrollView {
            var rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
            switch action {
                case .end:
                    rect.origin.y = scroller.contentSize.height +
                        scroller.contentInset.bottom + scroller.contentInset.top - 1
                case .point(let point):
                    rect.origin.y = point.y
                default: {
                    // default goes to top
                }()
            }
            scroller.scrollRectToVisible(rect, animated: true)
        }
    }
    
    func disableScrolling(_ flag: Bool) {
        scrollView?.isScrollEnabled = !flag
    }
}

extension UIView {
    func enclosingScrollView() -> UIScrollView? {
        var next: UIView? = self
        repeat {
            next = next?.superview
            if let scrollview = next as? UIScrollView {
                return scrollview
            }
        } while next != nil
        return nil
    }
}
