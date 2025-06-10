# Student Management App

A Flutter application designed to streamline student management tasks, including authentication, splash screen, persistent data handling, and full CRUD (Create, Read, Update, Delete) operations for students.

## Features

- Student login interface.
- Splash screen with branding.
- Persistent data storage using `shared_preferences`.
- Modern Material Design UI.
- Custom app theming (Green primary color).
- Asset management for logos and images.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.6.0 or higher recommended)
- Dart SDK (compatible with Flutter 3.6.0+)
- Android Studio, VS Code, or any Flutter-compatible IDE

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/divyeshlathiya/Student-Management-App.git
cd Student-Management-App
```

2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
   
## Directory Structure

- `lib/main.dart`: Entry point of the application, sets up the main theme and navigation.
- `lib/student_login.dart`: Contains the student login UI and logic.
- `assets/`: Contains images and branding assets (e.g., logo.jpg).

## Configuration

The app uses the following dependencies:

- `flutter`
- `cupertino_icons`
- `shared_preferences`
- `flutter_native_splash` (for splash screen customization)

#### Example `pubspec.yaml` snippet:

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
