//
//  ArticleDetailViewController.swift
//  ReaderApp
//
//  Created by Akash Razdan on 29/07/25.
//
import UIKit
import SafariServices

final class ArticleDetailViewController: UIViewController {

    private let article: Article

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let openInBrowserButton = UIButton(type: .system)

    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }

    private func setupUI() {
        title = "Article Detail"
        view.backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        contentStack.axis = .vertical
        contentStack.spacing = 12
        contentStack.alignment = .leading
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])

        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0

        authorLabel.font = .systemFont(ofSize: 16)
        authorLabel.textColor = .secondaryLabel

        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .tertiaryLabel

        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0

        openInBrowserButton.setTitle("Read Full Article", for: .normal)
        openInBrowserButton.setTitleColor(.systemBlue, for: .normal)
        openInBrowserButton.addTarget(self, action: #selector(openInBrowserTapped), for: .touchUpInside)

        [titleLabel, authorLabel, dateLabel, descriptionLabel, openInBrowserButton].forEach {
            contentStack.addArrangedSubview($0)
        }
    }

    private func populateData() {
        titleLabel.text = article.title
        authorLabel.text = article.author ?? "Unknown Author"
        descriptionLabel.text = article.desc ?? "No description available"

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: article.publishedAt)
    }
    
    private func showToast(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            alert.dismiss(animated: true)
        }
    }

    @objc private func openInBrowserTapped() {
        let urlString = article.url
        guard let url = URL(string: urlString) else {
            showToast(message: "Invalid article URL.")
            return
        }

        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}

