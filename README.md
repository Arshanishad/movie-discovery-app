# 🎬 Movie Discovery App

A Flutter movie discovery application built as part of a technical assignment.

The application uses the **TMDB API** to allow users to discover popular, trending, now-playing, top-rated, and upcoming movies. It also provides movie search, pagination, cached images, loading states, error handling, and retry functionality.

The project follows **Clean Architecture** and uses **BLoC** for state management.

---

## ✨ Features

* 🎬 Popular Movies
* 🔥 Trending Movies
* 🎥 Now Playing Movies
* ⭐ Top Rated Movies
* 📅 Upcoming Movies
* 🔍 Movie Search
* ⏱️ 400ms Search Debounce
* 📄 Pagination / Load More
* 🖼️ Cached Movie Images
* ✨ Shimmer Loading States
* ⚠️ API Error Handling
* 🔄 Retry on API Failure
* 📭 Empty States
* 👤 Profile Selection
* 📱 Responsive UI
* 🏗️ Clean Architecture
* 🔄 BLoC State Management

---

# 🛠️ Tech Stack

| Technology           | Purpose               |
| -------------------- | --------------------- |
| Flutter              | Application framework |
| Dart                 | Programming language  |
| BLoC                 | State management      |
| Dio                  | HTTP client           |
| TMDB API             | Movie data            |
| Cached Network Image | Image caching         |
| Shimmer              | Loading placeholders  |
| Logger               | Debug/error logging   |

---

# 🏗️ Architecture

The application follows **Clean Architecture** to separate UI, business logic, and data-access responsibilities.

```text
Presentation
     ↓
   Domain
     ↓
    Data
     ↓
  TMDB API
```

### Presentation

Responsible for:

* Screens/pages
* Widgets
* BLoC
* UI states
* User interactions

### Domain

Responsible for:

* Entities
* Repository contracts
* Use cases
* Application business rules

### Data

Responsible for:

* API communication
* Data sources
* Models
* JSON parsing
* Repository implementations

This separation makes the application easier to maintain, test, and extend.

---

# 📁 Project Structure

```text
lib/
├── core/
│   ├── api/
│   │   └── api_client.dart
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── image_constants.dart
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
    └── coming_soon/
        ├── data/
        ├── domain/
        └── presentation/
```

---

# 🌐 API

This application uses the **TMDB API** to retrieve movie information.

### Base URL

```text
https://api.themoviedb.org/3
```

### Endpoints Used

| Endpoint               | Purpose                      |
| ---------------------- | ---------------------------- |
| `/movie/popular`       | Fetch popular movies         |
| `/trending/movie/week` | Fetch weekly trending movies |
| `/movie/now_playing`   | Fetch now-playing movies     |
| `/movie/top_rated`     | Fetch top-rated movies       |
| `/movie/upcoming`      | Fetch upcoming movies        |
| `/search/movie`        | Search for movies            |

The application consumes movie data from the API rather than using hard-coded movie lists.

---

# 🔐 TMDB API Configuration

A **TMDB API Read Access Token** is required to run the application.

The token is **not hard-coded in the source code** and is not committed to the repository.

The application reads the token using:

```dart
const String.fromEnvironment('TMDB_TOKEN');
```

The token is supplied at runtime using Flutter's `--dart-define`.

## Step 1 — Create a TMDB Account

Create/sign in to a TMDB account.

Go to your TMDB account settings and open the **API** section.

Create an API credential and use the:

```text
API Read Access Token
```

The application uses the TMDB **Read Access Token**, not the API Key.

---

# 🚀 Getting Started

## Prerequisites

Make sure the following are installed:

* Flutter SDK
* Dart SDK
* Android Studio / Android SDK
* Git
* A connected Android device or emulator

Verify Flutter installation:

```bash
flutter doctor
```

Check the Flutter version:

```bash
flutter --version
```

---

## 1. Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

Navigate to the project:

```bash
cd movie_discovery_app
```

---

## 2. Install Dependencies

Run:

```bash
flutter pub get
```

---

## 3. Run the Application

Pass the TMDB Read Access Token using `--dart-define`.

```bash
flutter run --dart-define="TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN"
```

Replace:

```text
YOUR_TMDB_READ_ACCESS_TOKEN
```

with your actual TMDB Read Access Token.

### Example

```bash
flutter run --dart-define="TMDB_TOKEN=eyJhbGciOiJIUzI1NiJ9..."
```

> Do not commit the real token to GitHub.

---

# 📱 Running on a Physical Android Device

Connect an Android phone with **USB Debugging** enabled.

Verify that Flutter detects the device:

```bash
flutter devices
```

Then run:

```bash
flutter run --dart-define="TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN"
```

Flutter will build, install, and launch the application on the connected device.

---

# 📦 Build Release APK

To create a release APK:

```bash
flutter build apk --release --dart-define="TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN"
```

The generated APK will be located at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

The APK can then be installed on an Android device for testing.

---

# 🔍 Movie Search

Movie search uses the TMDB:

```text
/search/movie
```

endpoint.

A **400ms debounce** is applied to avoid making an API request for every keystroke.

The search feature handles:

* Search input
* Debouncing
* Loading state
* Search results
* Empty results
* API errors
* Retry
* Clearing the search

---

# 📄 Pagination

Movie listing endpoints use TMDB's page-based pagination.

When the user approaches the end of the currently loaded movie list, the next page is requested.

Pagination handles:

* Current page tracking
* Loading-more state
* Duplicate request prevention
* End-of-results handling
* Additional page requests
* Shimmer loading cards

---

# 🖼️ Image Handling

Movie posters and backdrops are loaded using `CachedNetworkImage`.

The application provides:

* Network image caching
* Loading placeholders
* Shimmer effects
* Error placeholders
* Fallback handling for missing images

---

# ⚠️ Loading, Empty & Error States

The application provides separate UI states for different API conditions.

### Loading

Displays shimmer placeholders while data is being fetched.

### Success

Displays the retrieved movie data.

### Empty

Displays an appropriate empty state when no movies or search results are available.

### Error

Displays an error message and provides a retry action.

### Pagination Loading

Displays loading indicators while additional pages are being fetched.

This prevents blank screens and gives the user feedback during network operations.

---

# 🔄 API Client

Dio is used as the HTTP client.

The central API client is responsible for:

* Base URL configuration
* Request timeouts
* Authorization headers
* GET requests
* POST requests
* PUT requests
* Multipart requests
* API error logging

The TMDB token is added to requests using the HTTP `Authorization` header:

```text
Authorization: Bearer <TMDB_READ_ACCESS_TOKEN>
```

---

# 🧪 Testing

Run all tests using:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

Format the project:

```bash
dart format lib test
```

---

# 📊 Code Quality

The project follows:

* Clean Architecture
* Separation of concerns
* Repository pattern
* Use-case based domain logic
* BLoC state management
* Reusable widgets
* Centralized API configuration
* Centralized constants
* Error and loading state handling

---

# 🔒 Security

The TMDB Read Access Token is not committed to the Git repository.

It is provided through:

```bash
--dart-define="TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN"
```

and accessed in Dart using:

```dart
const String.fromEnvironment('TMDB_TOKEN');
```

> **Important:** `--dart-define` prevents the token from being stored in the source repository, but it does not make a credential completely secret inside a distributed mobile application. A token included in a compiled APK may potentially be extracted.

Never commit the actual token to GitHub.

---

# 📝 Git Commit History

The project was developed using meaningful incremental commits.

Examples:

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

---


# 📌 Notes for Reviewers

To run this project successfully:

1. Clone the repository.
2. Install Flutter dependencies.
3. Obtain a TMDB API Read Access Token.
4. Pass the token using `--dart-define`.
5. Run the application using Flutter.

Example:

```bash
flutter pub get

flutter run --dart-define="TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN"
```

No API token is required to be added directly to the source code.

---

# 🙏 Attribution

This product uses the TMDB API but is not endorsed or certified by TMDB.

Movie data and images are provided by **The Movie Database (TMDB)**.

---

## Built With

**Flutter • Dart • BLoC • Dio • TMDB API**

Built as part of a Flutter technical assignment.
