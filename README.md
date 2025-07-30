# ReaderApp 📚

An elegant iOS application that displays top news headlines fetched from an API. The app is built using the MVVM architecture and Core Data for offline caching. It supports bookmarking, searching, offline persistence, and smooth animations.

## Features Implemented ✅

- 📡 Fetch Top Headlines from API
- 🔍 Search functionality
- 🌙 Dark Mode support
- 📥 Offline-first design (CoreData backed)
- 📌 Bookmark and Unbookmark articles
- 🧠 MVVM architecture for scalability
- 🧹 Efficient Core Data cleanup using NSBatchDeleteRequest
- 📱 UITableView with dynamic heights and smooth UI
- 🧭 Open articles in SFSafariViewController
- 🔄 Pull to Refresh
- 🔎 Case-insensitive search using NSPredicate
- 🔗 Kingfisher for image caching
- 📊 NSFetchedResultsController for efficient state updates

## Tools & Frameworks Used 🛠

- **Core Data**: For local persistent storage
- **Kingfisher**: For image downloading and caching
- **NSFetchedResultsController**: To observe changes in bookmarks
- **NSBatchDeleteRequest**: To efficiently clean old articles
- **SFSafariViewController**: To open full news in browser
- **URLSession**: Used for networking via APIService abstraction
- **Alamofire** *(Optional)*: Can be used for advanced networking
- **SDWebImage** *(Optional)*: Alternative to Kingfisher if preferred

## Architecture 🧱

MVVM layered with Repository and DataStore pattern for separation of concerns and testability.

```
ViewController
   ↓
ViewModel
   ↓
Repository
   ↓
DataStore + APIService
```

## Requirements 📋

- iOS 15.0+
- Xcode 14+

## Getting Started ▶️

1. Clone the repo:
```bash
git clone https://github.com/Akash-R97/ReaderApp.git
cd ReaderApp
```

2. Open `ReaderApp.xcodeproj` in Xcode

3. Run the project on a simulator or device.

---

🧠 Created by Akash Razdan. Feel free to contribute!