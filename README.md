# Class Flow - Training Management System

A comprehensive Flutter application for managing training programs, students, trainers, and activities. Built with modern Flutter architecture and best practices.

## 🚀 Features

- **Student Management**: Add, edit, and track student information
- **Trainer Management**: Manage trainer profiles and assignments
- **Activity Tracking**: Monitor training activities and progress
- **Lead Management**: Track potential students and conversions
- **Clean Architecture**: Built with separation of concerns
- **Cross-Platform**: Runs on Android, iOS, Web, Windows, macOS, and Linux

## 📱 Screenshots

*Screenshots will be added here*

## 🛠️ Tech Stack

- **Framework**: Flutter 3.2.3+
- **State Management**: Flutter Bloc & Provider
- **Architecture**: Clean Architecture with BLoC pattern
- **Database**: SQLite with local storage
- **HTTP Client**: http package for API calls
- **Dependency Injection**: GetIt
- **Local Storage**: SharedPreferences

## 📋 Prerequisites

- Flutter SDK (>=3.2.3)
- Dart SDK (>=3.2.3)
- Android Studio / VS Code
- Git

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/diman83-CF/class_flow.git
cd class_flow
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

```bash
# For development
flutter run

# For specific platforms
flutter run -d chrome    # Web
flutter run -d windows   # Windows
flutter run -d macos     # macOS
flutter run -d linux     # Linux
```

## 📁 Project Structure

```
lib/
├── data/
│   ├── database/        # Database helpers and models
│   ├── mock/           # Mock data for development
│   └── providers/      # Data providers
├── domain/
│   └── entities/       # Business entities
├── presentation/
│   ├── pages/          # UI pages
│   ├── providers/      # State management
│   └── widgets/        # Reusable widgets
└── main.dart          # Application entry point
```

## 🔧 Configuration

### Environment Setup

1. Ensure Flutter is properly installed and configured
2. Run `flutter doctor` to verify your setup
3. Install required dependencies with `flutter pub get`

### Database Setup

The application uses SQLite for local data storage. The database is automatically initialized when the app starts.

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc: ^8.1.3` - State management
- `equatable: ^2.0.5` - Value equality
- `get_it: ^7.6.4` - Dependency injection
- `http: ^1.1.0` - HTTP client
- `shared_preferences: ^2.2.2` - Local storage
- `intl: ^0.18.1` - Internationalization
- `path: ^1.8.3` - Path manipulation
- `provider: ^6.1.1` - State management

### Development Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^2.0.0` - Code linting

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 📱 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- diman83-CF - Initial work

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The open-source community for various packages used in this project

## 📞 Support

If you have any questions or need support, please open an issue on GitHub or contact the development team.

---

**Note**: This is a class management system built with Flutter. Make sure to customize the configuration and features according to your specific requirements.
