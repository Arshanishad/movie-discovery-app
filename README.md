# 🎬 Movie Discovery App

A Flutter movie discovery application built as part of a technical assignment.

The application uses the **TMDB API** to allow users to discover popular, trending, now-playing, top-rated, and upcoming movies. It also provides movie search, pagination, cached images, loading states, error handling, retry functionality, username/profile selection, and bottom navigation.

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
* 👤 Username / Profile Selection
* 🧭 Bottom Navigation
* 🏠 Home
* 🔍 Search
* 📅 Coming Soon
* ⬇️ Downloads
* ☰ Menu
* 📱 Responsive UI
* 🏗️ Clean Architecture
* 🔄 BLoC State Management

---

# 🧭 Application Flow

The application follows a simple onboarding and navigation flow.

```text
Splash Screen
      ↓
Username / Profile Selection
      ↓
Select Username
      ↓
Main Application
      ↓
┌─────────┬─────────┬─────────────┬───────────┬─────────┐
│  Home   │ Search  │ Coming Soon │ Downloads │  Menu   │
└─────────┴─────────┴─────────────┴───────────┴─────────┘
```

### 1. Splash Screen

When the application starts, a splash screen is displayed before navigating to the username/profile selection screen.

### 2. Username / Profile Selection

After the splash screen, the user is taken to the username/profile selection screen.

The user can select a username from the available profile options.

After selecting a username, the application navigates to the main application interface.

### 3. Main Application

The main application provides bottom navigation to access the available sections.

| Screen         | Description                                                   |
| -------------- | ------------------------------------------------------------- |
| 🏠 Home        | Displays popular, trending, now-playing, and top-rated movies |
| 🔍 Search      | Allows users to search for movies                             |
| 📅 Coming Soon | Displays upcoming movies                                      |
| ⬇️ Downloads   | Provides access to downloaded movie content                   |
| ☰ Menu         | Provides additional application options                       |

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
* Navigation

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
    └── comming_soon/
        ├── data/
        ├── domain/
        └── presentation/
```

> **Note:** Make sure the folder names in this structure match the actual project structure. If the actual folder is named `coming_soon`, use that name instead of `comming_soon`.

---

# 🌐 API

This application uses the **TMDB API** to retrieve movie information.

### Base URL

```text
https://api.themoviedb.org/3
```

### Endpoints Used

| Endpoint             | Purpose                      |
| -------------------- | ---------------------------- |
| `/movie/popular`     | Fetch popular movies         |
| `/trending/all/week` | Fetch weekly trending movies |
| `/movie/now_playing` | Fetch now-playing movies     |
| `/movie/top_rated`   | Fetch top-rated movies       |
| `/movie/upcoming`    | Fetch upcoming movies        |
| `/search/movie`      | Search for movies            |

The application consumes movie data from the API rather than using hard-coded movie lists.

---

# 🔐 TMDB API Configuration

A **TMDB API Read Access Token** is required to run the application.

The token is provided using Dart's `--dart-define` mechanism and is not hardcoded in the source code.

The application expects the token through:

```text
TMDB_TOKEN
```

For example, the application can read it using:

```dart
static const String tmdbToken =
    String.fromEnvironment('TMDB_TOKEN');
```

The `ApiClient` attaches the token to API requests using:

```text
Authorization: Bearer <TMDB_READ_ACCESS_TOKEN>
```

The application uses the TMDB **Read Access Token**, not the TMDB API Key.

## Step 1 — Create a TMDB Account

Create or sign in to a TMDB account.

Go to your TMDB account settings and open the **API** section.

Create an API credential and use the:

```text
API Read Access Token
```

## Step 2 — Run the Application

Pass your token using `--dart-define`:

```bash
flutter run --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

No token needs to be added directly to the source code.

## Step 3 — Build the Release APK

Pass the token when building the release APK:

```bash
flutter build apk --release --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

> ⚠️ **Security note:** Using `--dart-define` keeps the token out of the source repository, but values supplied to a distributed application can still potentially be extracted from the compiled APK. This approach is suitable for an assignment/demo application. For a production application, API credentials should preferably be protected behind a backend/proxy service.

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

Provide the TMDB Read Access Token using `--dart-define`:

```bash
flutter run --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

The token does not need to be added to the source code.

---

# 📱 Running on a Physical Android Device

Connect an Android phone with **USB Debugging** enabled.

Verify that Flutter detects the device:

```bash
flutter devices
```

Then run:

```bash
flutter run --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

Flutter will build, install, and launch the application on the connected device.

---

# 📦 Build Release APK

Before building, make sure the TMDB token is provided through `--dart-define`.

Run:

```bash
flutter clean
flutter pub get
flutter build apk --release --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

The generated APK will be located at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

The APK can then be installed on an Android device for testing.

### Release APK Testing

Before submitting the APK, install the **exact release APK** on a physical device and verify the complete application flow.

Test:

* Splash screen
* Username/profile selection
* Username selection and navigation
* Home screen
* Popular movies
* Trending movies
* Now Playing movies
* Top Rated movies
* Search
* Coming Soon
* Downloads
* Menu
* Bottom navigation
* Movie pagination
* Retry after API failure
* Empty states
* Loading states
* Cached images
* Closing and reopening the application

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
* Loading indicators for additional results

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

This prevents blank screens and provides feedback during network operations.

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

The TMDB token is provided through `--dart-define` and added to requests using the HTTP `Authorization` header:

```text
Authorization: Bearer <TMDB_READ_ACCESS_TOKEN>
```

An error interceptor logs relevant request/error information during development, which helps diagnose API and networking issues.

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

A clean project should ideally report:

```text
No issues found!
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

The TMDB token is **not stored directly in the source code**.

It is supplied using:

```bash
--dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

Do not commit the actual token to GitHub.

Do not place the real token in:

* Source files
* README files
* Screenshots
* Commit messages
* Public documentation

> **Important:** `--dart-define` keeps the token out of the source repository, but it does not make the token completely secret inside a distributed APK. A determined user may potentially extract compiled application data.

For a production application, protected API credentials should preferably be handled by a secure backend/proxy.

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
4. Provide the token using `--dart-define`.
5. Run the application.

Example:

```bash
flutter pub get
flutter analyze
flutter test
flutter run --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

To build the release APK:

```bash
flutter build apk --release --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
```

The TMDB Read Access Token is intentionally not included in the repository.

---

# 🙏 Attribution

This product uses the TMDB API but is not endorsed or certified by TMDB.

Movie data and images are provided by **The Movie Database (TMDB)**.

---

## Built With

**Flutter • Dart • BLoC • Dio • TMDB API**

Built as part of a Flutter technical assignment.
