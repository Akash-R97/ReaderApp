# ReaderApp 🗞️

A clean, offline-capable iOS News Reader app that fetches top headlines, allows bookmarking, and works seamlessly with Core Data.

## Features

- 📲 Top headlines list
- 🔍 Search functionality
- ⭐ Bookmark and manage favorite articles
- 🔁 Pull to refresh with force refresh support
- 🌓 Dark mode support
- 🧠 Smart caching with Core Data
- 🔃 Automatic UI updates via `NSFetchedResultsController`
- 🧹 Background deletion with `NSBatchDeleteRequest`
- 🌐 Open articles in `SFSafariViewController`
- 🖼️ Image loading using **Kingfisher**
- 📡 Networking via **URLSession** with a custom APIService

## Tools Used

- **Core Data** – Persistent storage for articles and bookmarks
- **NSFetchedResultsController** – Efficient updates to UI when data changes
- **NSBatchDeleteRequest** – Efficient deletion of old unbookmarked data
- **URLSession** – Used through a custom `APIService` for network calls to fetch top headlines
- **SFSafariViewController** – In-app browser to read full articles
- **Kingfisher** – Async image downloading and caching

## Project Structure

- `ArticleListViewController` – Displays the top headlines and supports bookmarking
- `BookmarkViewController` – Shows bookmarked articles
- `ArticleRepository` – Handles all data logic between API and Core Data
- `ArticleDataStore` – Manages Core Data interactions
- `ArticleListViewModel` & `BookmarkViewModel` – MVVM logic layer

## Getting Started

1. Clone the repo:
```bash
git clone https://github.com/Akash-R97/ReaderApp.git
```

2. Open `ReaderApp.xcodeproj` in Xcode

3. Build and run the app on the Simulator or device

## Author

Akash Razdan