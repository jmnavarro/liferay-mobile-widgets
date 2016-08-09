/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import UIKit


@objc public protocol CommentDisplayScreenletDelegate : BaseScreenletDelegate {

	optional func screenlet(screenlet: CommentDisplayScreenlet,
	                        onCommentLoaded comment: Comment)

	optional func screenlet(screenlet: CommentDisplayScreenlet,
	                        onLoadCommentError error: NSError)

}


@IBDesignable public class CommentDisplayScreenlet: BaseScreenlet {

	public static let DeleteAction = "deleteAction"
	public static let UpdateAction = "updateAction"

	@IBInspectable public var groupId: Int64 = 0

	@IBInspectable public var commentId: Int64 = 0

	@IBInspectable public var autoLoad: Bool = true

	public var commentDisplayDelegate: CommentDisplayScreenletDelegate? {
		return delegate as? CommentDisplayScreenletDelegate
	}

	@IBInspectable public var editable: Bool = false {
		didSet {
			screenletView?.editable = self.editable
		}
	}

	public var viewModel: CommentDisplayViewModel? {
		return screenletView as? CommentDisplayViewModel
	}

	public var computedHeight: CGFloat? {
		return viewModel?.computedHeight
	}

	//MARK: Public methods

	override public func onShow() {
		if !isRunningOnInterfaceBuilder {
			if autoLoad {
				load()
			}
		}
	}

	public override func onCreated() {
		super.onCreated()
		screenletView?.editable = self.editable
	}

	public func load() {
		performDefaultAction()
	}

	//MARK: BaseScreenlet

	override public func createInteractor(name name: String, sender: AnyObject?) -> Interactor? {
		let interactor = CommentLoadInteractor(
			screenlet: self,
			groupId: self.groupId,
			commentId: self.commentId)

		interactor.onSuccess = {
			if let resultComment = interactor.resultComment {
				self.viewModel?.comment = resultComment
				self.commentDisplayDelegate?.screenlet?(self, onCommentLoaded: resultComment)
			}
			else {
				self.commentDisplayDelegate?.screenlet?(self,
					onLoadCommentError: NSError.errorWithCause(.InvalidServerResponse))
			}
		}

		interactor.onFailure = {
			self.commentDisplayDelegate?.screenlet?(self, onLoadCommentError: $0)
		}
		
		return interactor
	}
	
}