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

| Technology            | Purpose                |
| ---------------------- | ---------------------- |
| Flutter                | Application framework  |
| Dart                    | Programming language   |
| BLoC                    | State management       |
| Dio                     | HTTP client             |
| TMDB API                | Movie data              |
| Cached Network Image    | Image caching           |
| Shimmer                 | Loading placeholders    |
| Logger                  | Debug/error logging     |

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
│   ├── network/
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

> **Note:** Update the `core/network/` path above if `api_client.dart` actually lives in a different folder in your project (e.g. `core/api/`). This tree must match your real file structure, or reviewers following the import paths will get errors.

---

# 🌐 API

This application uses the **TMDB API** to retrieve movie information.

### Base URL

```text
https://api.themoviedb.org/3
```

### Endpoints Used

| Endpoint                | Purpose                              |
| ------------------------ | ------------------------------------- |
| `/movie/popular`         | Fetch popular movies                  |
| `/trending/all/week`     | Fetch weekly trending (all media types)|
| `/movie/now_playing`     | Fetch now-playing movies              |
| `/movie/top_rated`       | Fetch top-rated movies                |
| `/movie/upcoming`        | Fetch upcoming movies                 |
| `/search/movie`          | Search for movies                     |

The application consumes movie data from the API rather than using hard-coded movie lists.

---

# 🔐 TMDB API Configuration

A **TMDB API Read Access Token** is required to run the application.

The token is stored directly in `lib/core/constants/api_constants.dart`:

```dart
class ApiConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String tmdbToken = "YOUR_TMDB_READ_ACCESS_TOKEN";
  ...
}
```

It is read by `ApiClient` and attached to every request as:

```text
Authorization: Bearer <tmdbToken>
```

No `--dart-define` flag is required to run or build the app — the token is compiled in directly.

## Step 1 — Create a TMDB Account

Create/sign in to a TMDB account.

Go to your TMDB account settings and open the **API** section.

Create an API credential and use the:

```text
API Read Access Token
```

The application uses the TMDB **Read Access Token**, not the API Key.

## Step 2 — Add Your Token

Open `lib/core/constants/api_constants.dart` and replace the placeholder:

```dart
static const String tmdbToken = "PASTE_YOUR_TOKEN_HERE";
```

> ⚠️ **Security note:** Because the token is hardcoded, it will be compiled
> into the release APK and can potentially be extracted by decompiling the
> app (e.g. with `jadx`). This is acceptable for assignment/demo purposes,
> but is **not recommended for a production app** with real users — a
> production app should proxy TMDB requests through your own backend so
> the token never ships inside the client.

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

Make sure you've added your token to `lib/core/constants/api_constants.dart`
(see [TMDB API Configuration](#-tmdb-api-configuration) above), then run:

```bash
flutter run
```

No `--dart-define` flag is needed — the token is read directly from
`ApiConstants.tmdbToken`.

> Do not commit your real token to a public GitHub repository. If this
> project is public, keep `api_constants.dart` in `.gitignore` and commit
> a placeholder version instead (see Security section below).

---

# 📱 Running on a Physical Android Device

Connect an Android phone with **USB Debugging** enabled.

Verify that Flutter detects the device:

```bash
flutter devices
```

Then run:

```bash
flutter run
```

Flutter will build, install, and launch the application on the connected device.

---

# 📦 Build Release APK

Make sure your token is set in `lib/core/constants/api_constants.dart`
before building.

To create a release APK:

```bash
flutter build apk --release
```

The generated APK will be located at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

The APK can then be installed on an Android device for testing.

> **Note:** This project includes a custom `network_security_config.xml`
> (referenced from `AndroidManifest.xml` via `android:networkSecurityConfig`)
> to ensure HTTPS API calls to TMDB succeed reliably in release builds
> across different Android devices and network configurations.

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

The TMDB token (from `ApiConstants.tmdbToken`) is added to every request
using the HTTP `Authorization` header:

```text
Authorization: Bearer <TMDB_READ_ACCESS_TOKEN>
```

An `onError` interceptor also logs the failure type (timeout, bad
response, etc.) and the request URL, which is useful when diagnosing
release-build networking issues.

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

The TMDB token lives in `lib/core/constants/api_constants.dart`.

To avoid committing a real token to a public repository:

1. Add `lib/core/constants/api_constants.dart` to `.gitignore`.
2. Commit a placeholder version instead — e.g. `api_constants.dart.example` —
   with `tmdbToken` set to `"PASTE_YOUR_TOKEN_HERE"`.
3. Anyone cloning the repo copies the example file, fills in their own
   token, and builds normally.

> **Important:** Since the token is compiled directly into the app, it
> will be present inside the built APK/AAB and can potentially be
> extracted by decompiling the app. This is acceptable for an assignment
> or demo build. For a production app handling real user traffic, TMDB
> requests should be proxied through your own backend so the token never
> ships inside the client binary.

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
4. Add the token to `lib/core/constants/api_constants.dart`
   (`tmdbToken` field).
5. Run the application using Flutter.

Example:

```bash
flutter pub get
flutter run
```

If you were given the token separately (e.g. by email, for grading
purposes), paste it directly into `api_constants.dart` before running —
no `--dart-define` flag is required.

---

# 🙏 Attribution

This product uses the TMDB API but is not endorsed or certified by TMDB.

Movie data and images are provided by **The Movie Database (TMDB)**.

---

## Built With

**Flutter • Dart • BLoC • Dio • TMDB API**

Built as part of a Flutter technical assignment.
