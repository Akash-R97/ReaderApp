# 🗞️ ReaderApp

A sleek, offline-first iOS news reader application built with UIKit, Core Data, and Kingfisher. The app showcases top headlines, bookmarking, search, and robust data sync — optimized for both light and dark modes.

---

## ✨ Features Implemented

### 📰 Top Headlines
- Displays news articles using mock API (local JSON simulation).
- Each article shows: title, author, image, description, and published date.
- Tapping an article opens it in `SFSafariViewController`.

### 🔄 Pull to Refresh
- Syncs data from mock API on pull-down.
- Deletes old non-bookmarked articles before saving new ones.
- Efficiently uses `NSBatchDeleteRequest` for cleanup.

### 🔖 Bookmarking
- Bookmark/unbookmark articles across both tabs (Headlines & Bookmarks).
- Bookmark status persists using Core Data.
- UI immediately reflects changes across tabs without duplication.

### 🔍 Search
- Dynamic, case-insensitive search by title.
- Operates entirely on locally stored articles.
- Integrated with `UISearchController`.

### 💾 Offline-First Architecture
- All articles saved using Core Data.
- The app functions without network access after initial load.

### 🌗 Dark Mode Support
- Fully supports system-wide dark/light appearance.
- UI components automatically adapt to appearance changes.

### 🚫 Empty States
- Shows user-friendly messages like:
  - "No articles found"
  - "No bookmarks yet"

---

## 📱 Tech Stack

- **Language**: Swift 5
- **Architecture**: MVVM
- **Frameworks**: UIKit, CoreData
- **Tools Used**:
  - `NSFetchedResultsController`
  - `NSBatchDeleteRequest`
  - `URLSession` (simulated via mock service)
  - `SFSafariViewController`

---

## 🚫 Third-party Libraries

- ✅ **Kingfisher** – used for efficient image downloading and caching.

### ℹ️ Optional Libraries (Not Used):
- **SDWebImage** – alternate image caching library; functionally similar to Kingfisher.
- **Alamofire** – for network abstraction and response handling.

---

## 📁 Folder Structure

```
ReaderApp/
├── Models/
├── Views/
├── ViewModels/
├── Controllers/
├── Services/
├── Resources/
├── CoreData/
└── Utils/
```

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Akash-R97/ReaderApp.git
   cd ReaderApp
   ```

2. Open the project:
   ```bash
   open ReaderApp.xcodeproj
   ```

3. Build and run using:
   - Xcode 15+
   - iOS 15.0+ Simulator

---

## 📸 Screenshots

*(Add screenshots if needed)*

---

## 👨‍💻 Author

**Akash Razdan**  
GitHub: [@Akash-R97](https://github.com/Akash-R97)

---

## ✅ Status

**Project Complete** — Ready for demonstration and evaluation.  
All assignment criteria implemented and verified.