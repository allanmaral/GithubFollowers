//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

class GFAlertVC: UIViewController {
  let containerView = GFDialogView()
  let titleLabel = GFTitleLabel(fontSize: 20, textAlignment: .center)
  let messageLabel = GFBodyLabel(textAlignment: .center)
  let actionButton = GFButton(backgroundColor: .systemPink, title: "OK")

  var alertTitle: String?
  var message: String?
  var buttonTitle: String?

  let padding: CGFloat = 20

  init(title: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)

    self.alertTitle = title
    self.message = message
    self.buttonTitle = buttonTitle
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureView()
  }

  private func configureView() {
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    modalPresentationStyle = .overFullScreen
    modalTransitionStyle = .crossDissolve

    configContainerView()
    configTitleLabel()
    configureMessageLabel()
    configureActionButton()
  }

  private func configContainerView() {
    view.addSubview(containerView)

    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280)
    ])
  }

  private func configTitleLabel() {
    containerView.addSubview(titleLabel)

    titleLabel.text = alertTitle ?? "Something went wrong"

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
    ])
  }

  private func configureMessageLabel() {
    containerView.addSubview(messageLabel)

    messageLabel.text = message ?? "Unable to complete request"
    messageLabel.numberOfLines = 4

    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
    ])
  }

  private func configureActionButton() {
    containerView.addSubview(actionButton)

    actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
    actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)

    NSLayoutConstraint.activate([
      actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: padding),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44),
      containerView.bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: padding)
    ])
  }

  @objc private func actionTapped() {
    dismiss(animated: true)
  }
}
