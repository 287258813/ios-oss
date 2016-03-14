import class UIKit.UIButton
import class UIKit.UIAlertController
import class UIKit.UIAlertAction
import class UIKit.UIBarButtonItem
import class Library.BorderButton
import class Library.MVVMViewController
import enum Library.HelpType
import func Library.localizedString
import enum Library.Color
import class SafariServices.SFSafariViewController

internal final class LoginToutViewController: MVVMViewController {
  @IBOutlet weak var loginButton: BorderButton!
  @IBOutlet weak var signupButton: BorderButton!
  @IBOutlet weak var helpButton: BorderButton!

  let viewModel: LoginToutViewModelType = LoginToutViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

   let helpButton = UIBarButtonItem(
    title: localizedString(key: "general.navigation.buttons.help", defaultValue: "Help"),
    style: .Plain,
    target: self,
    action: "showHelp")
    helpButton.tintColor = Color.Green.toUIColor()
    self.navigationItem.rightBarButtonItem? = helpButton
  }

  override func bindViewModel() {
    self.viewModel.outputs.startLogin
      .observeForUI()
      .observeNext { [weak self] _ in
        self?.startLoginViewController()
    }
    self.viewModel.outputs.startSignup
      .observeForUI()
      .observeNext { [weak self] _ in
        self?.startSignupViewController()
    }
  }

  func startLoginViewController() {
    let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(loginVC, animated: true)
  }

  func startSignupViewController() {

  }

  @IBAction
  internal func loginButtonPressed(sender: UIButton) {
    self.viewModel.inputs.loginButtonPressed()
  }

  @IBAction func helpButtonPressed(sender: UIButton) {
    showHelp()
  }

  internal func showHelp() {
    let helpAlert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
    HelpType.allValues.forEach { h in
      helpAlert.addAction(UIAlertAction(title: h.title(),
        style: .Default,
        handler: { [weak self] (UIAlertAction) -> Void in
          switch h {
          case .Contact: break
          default:
            let svc = SFSafariViewController.help(h)
            self?.presentViewController(svc, animated: true, completion: nil)
          }
        }))
    }
    helpAlert.addAction(UIAlertAction(title: localizedString(key: "login_tout.help_sheet.cancel",
      defaultValue: "Cancel"),
      style: .Cancel,
      handler: nil))

    self.presentViewController(helpAlert, animated: true, completion: nil)
  }
}
