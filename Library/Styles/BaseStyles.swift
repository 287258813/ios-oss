import Prelude
import Prelude_UIKit
import UIKit

public enum Styles {
  public static let cornerRadius: CGFloat = 4.0

  public static func grid(count: Int = 1) -> CGFloat {
    return 6.0 * CGFloat(count)
  }

  public static func gridHalf(count: Int = 1) -> CGFloat {
    return grid(count) / 2.0
  }
}

public func baseControllerStyle <VC: UIViewControllerProtocol> () -> (VC -> VC) {
  return VC.lens.view.backgroundColor .~ .ksr_grey_100
}

public func baseTableControllerStyle <TVC: UITableViewControllerProtocol>
  (estimatedRowHeight estimatedRowHeight: CGFloat = 44.0) -> (TVC -> TVC) {
  let style = baseControllerStyle()
    <> TVC.lens.tableView.rowHeight .~ UITableViewAutomaticDimension
    <> TVC.lens.tableView.estimatedRowHeight .~ estimatedRowHeight

  #if os(iOS)
    return style <> TVC.lens.tableView.separatorStyle .~ .None
  #else
    return style
  #endif
}

public let baseNavigationBarStyle =
  UINavigationBar.lens.titleTextAttributes .~ [
    NSForegroundColorAttributeName: UIColor.ksr_text_navy_600,
    NSFontAttributeName: UIFont.ksr_subhead(size: 15)
]

public func baseTableViewCellStyle <TVC: UITableViewCellProtocol> () -> (TVC -> TVC) {

  return
    TVC.lens.contentView.layoutMargins .~ .init(topBottom: Styles.grid(), leftRight: Styles.grid(2))
      <> (TVC.lens.contentView • UIView.lens.preservesSuperviewLayoutMargins) .~ false
      <> TVC.lens.layoutMargins .~ .init(all: 0.0)
      <> TVC.lens.preservesSuperviewLayoutMargins .~ false
      <> TVC.lens.selectionStyle .~ .None
}

/**
 - parameter radius: The corner radius. This parameter is optional, and will use a default value if omitted.

 - returns: A view transformer that rounds corners, sets background color, and sets border color.
 */
public func cardStyle <V: UIViewProtocol> (cornerRadius radius: CGFloat = Styles.cornerRadius) -> (V -> V) {

  return roundedStyle(cornerRadius: radius)
    <> V.lens.layer.borderColor .~ UIColor.ksr_grey_500.CGColor
    <> V.lens.layer.borderWidth .~ 1.0
    <> V.lens.backgroundColor .~ .whiteColor()
}

public let containerViewBackgroundStyle =
  UIView.lens.backgroundColor .~ .ksr_grey_100

public func dropShadowStyle <V: UIViewProtocol> (blurRadius blurRadius: CGFloat = 4.0,
                                                            cornerRadius: CGFloat = 0.0) -> ((V) -> V) {
  return
    V.lens.layer.shadowColor .~ UIColor.blackColor().CGColor
      <> V.lens.layer.shadowOffset .~ .zero
      <> V.lens.layer.shadowOpacity .~ 0.07
      <> V.lens.layer.shadowRadius .~ blurRadius
}

public let formFieldStyle =
  UITextField.lens.font .~ .ksr_body()
    <> UITextField.lens.textColor .~ .ksr_text_navy_900
    <> UITextField.lens.backgroundColor .~ .clearColor()
    <> UITextField.lens.borderStyle .~ .None
    <> UITextField.lens.autocapitalizationType .~ .None
    <> UITextField.lens.autocorrectionType .~ .No
    <> UITextField.lens.spellCheckingType .~ .No
    <> UITextField.lens.tintColor .~ .ksr_green_700

public let separatorStyle =
  UIView.lens.backgroundColor .~ .ksr_navy_300
  <> UIView.lens.accessibilityElementsHidden .~ true

/**
 - parameter r: The corner radius. This parameter is optional, and will use a default value if omitted.

 - returns: A view transformer that rounds corners.
 */
public func roundedStyle <V: UIViewProtocol> (cornerRadius r: CGFloat = Styles.cornerRadius) -> (V -> V) {
  return V.lens.layer.masksToBounds .~ true
    <> V.lens.layer.cornerRadius .~ r
}
