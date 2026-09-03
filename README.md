# 🎬 Movie Discovery App

A Flutter movie discovery application built with the **TMDB API**. The app allows users to discover popular, trending, now-playing, top-rated, and upcoming movies, along with movie search and pagination.

The project follows **Clean Architecture** and uses **BLoC** for state management.

## ✨ Features

* 🎬 Popular Movies
* 🔥 Trending Movies
* 🎥 Now Playing Movies
* ⭐ Top Rated Movies
* 📅 Upcoming / Coming Soon Movies
* 🔍 Movie Search with debounce
* 📄 Pagination / Load More
* 🖼️ Cached movie images
* ✨ Shimmer loading states
* ⚠️ Error handling with Retry
* 📭 Empty states
* 👤 Profile selection
* 📱 Responsive UI
* 🏗️ Clean Architecture
* 🔄 BLoC state management

## 🛠️ Tech Stack

| Technology           | Purpose                    |
| -------------------- | -------------------------- |
| Flutter              | Cross-platform application |
| Dart                 | Programming language       |
| BLoC                 | State management           |
| Dio                  | HTTP/API requests          |
| TMDB API             | Movie data                 |
| Cached Network Image | Image caching              |
| Shimmer              | Loading placeholders       |

## 🏗️ Architecture

The application follows **Clean Architecture** with three layers:

```text
Presentation
     ↓
   Domain
     ↓
    Data
     ↓
  TMDB API
```

### Project Structure

```text
lib/
├── core/
│   ├── api/
│   │   └── api_client.dart
│   ├── constants/
│   │   └── api_constants.dart
│   └── theme/
│
└── features/
    ├── home/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── bloc/
    │       ├── pages/
    │       └── widgets/
    │
    ├── search/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    └── comming_soon/
        ├── data/
        ├── domain/
        └── presentation/
```

## 🌐 API

This project uses the **TMDB API** for real-time movie data.

**Base URL:**

```text
https://api.themoviedb.org/3
```

**Endpoints used:**

```text
/movie/popular
/trending/movie/week
/movie/now_playing
/movie/top_rated
/movie/upcoming
/search/movie
```

The application uses real API data rather than hard-coded mock data.

## 🔐 API Configuration

The TMDB **API Read Access Token** is not hard-coded or committed to the repository.

The token is provided at runtime using Flutter's `--dart-define`.

### Run the application

```bash
flutter pub get

flutter run --dart-define=TMDB_TOKEN="YOUR_TMDB_READ_ACCESS_TOKEN"
```

Replace `YOUR_TMDB_READ_ACCESS_TOKEN` with your actual TMDB Read Access Token.

### Build Release APK

```bash
flutter build apk --release --dart-define=TMDB_TOKEN="YOUR_TMDB_READ_ACCESS_TOKEN"
```

> ⚠️ Never commit your actual API token to GitHub.

## 🔍 Search

Movie search is implemented using the TMDB search endpoint.

A **400ms debounce** is used to reduce unnecessary API requests while the user is typing.

Search supports:

* Loading state
* Search results
* Empty results
* Error state
* Clear search

## 📄 Pagination

Pagination is implemented using TMDB's page-based API.

Additional pages are requested as the user approaches the end of the movie list.

Pagination handles:

* Page tracking
* Loading-more state
* End-of-results handling
* Duplicate request prevention
* Shimmer loading cards

## 🖼️ Image Handling

Movie posters and backdrops are loaded using `CachedNetworkImage`.

The UI provides:

* Image caching
* Shimmer placeholders
* Error placeholders
* Poster/backdrop fallback handling

## ⚠️ Loading & Error Handling

The application provides dedicated states for API operations:

* Shimmer loading
* Empty state
* Error state
* Retry action
* Pagination loading

This prevents blank screens and provides feedback while network requests are running.

## 📦 Main Dependencies

```yaml
flutter_bloc:
dio:
cached_network_image:
shimmer:
```

Install dependencies with:

```bash
flutter pub get
```

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### 2. Open the project

```bash
cd movie_discovery_app
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Add your TMDB token

```bash
flutter run --dart-define=TMDB_TOKEN="YOUR_TMDB_READ_ACCESS_TOKEN"
```

### 5. Build APK

```bash
flutter build apk --release --dart-define=TMDB_TOKEN="YOUR_TMDB_READ_ACCESS_TOKEN"
```

## 🧪 Code Quality

Before submitting the project:

```bash
flutter analyze
```

Format the code:

```bash
dart format lib
```

## 📝 Git Commit History

The project was developed using meaningful incremental commits, for example:

```text
feat: add tmdb api client and constants
feat: add movie entity and model
feat: implement home data layer
feat: implement home use cases
feat: add home bloc state management
feat: implement movie search
feat: implement upcoming movies
feat: add movie pagination
feat: add cached network images
feat: add shimmer loading states
feat: add error and retry handling
fix: prevent duplicate profile navigation
docs: add project readme
```

## 🔒 Security

The TMDB Read Access Token is supplied through `--dart-define` and is not stored in the committed source code.

```dart
const String.fromEnvironment('TMDB_TOKEN')
```

This keeps the credential out of the Git repository.

> Note: A credential supplied during a release build can still potentially be extracted from the compiled application. `--dart-define` is used here to prevent the token from being committed to source control.

---

**Built with Flutter, Dart, BLoC, Dio and TMDB API.**
