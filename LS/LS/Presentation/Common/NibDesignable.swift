//
//  NibDesignable.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

public protocol NibDesignableProtocol: NSObjectProtocol {

    /**
     Identifies the view that will be the superview of the contents loaded from
     the Nib. Referenced in setupNib().
     - returns: Superview for Nib contents.
     */
    var nibContainerView: UIView { get }

    /**
     Called to load the nib in setupNib().
     - returns: UIView instance loaded from a nib file.
     */
    func loadNib() -> UIView

    /**
     Called in the default implementation of loadNib(). Default is class name.
     - returns: Name of a single view nib file.
     */
    func nibName() -> String

    /**
     Called in the default implementation of loadNib(). When nib loaded
     */
    func nibLoaded()
}

extension NibDesignableProtocol {

    /**
     Called to load the nib in setupNib().
     - returns: UIView instance loaded from a nib file.
     */
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName(), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    /**
     Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
     */
    fileprivate func setupNib() {
        let view = loadNib()
        view.backgroundColor = .clear
        nibContainerView.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                       options: [],
                                                                       metrics: nil,
                                                                       views: bindings))
        nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                       options: [],
                                                                       metrics: nil,
                                                                       views: bindings))
        nibLoaded()
    }
}

extension UIView {

    public var nibContainerView: UIView { self }

    /**
     Called in the default implementation of loadNib(). Default is class name.
     - returns: Name of a single view nib file.
     */
    @objc
    open func nibName() -> String {
        Self.description().components(separatedBy: ".").last!
    }
}

open class NibDesignable: UIView, NibDesignableProtocol {

    public func nibLoaded() {
        // to overrride
    }

    // MARK: - Initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}
