# Simple Chat Application

A simple chat application built with Flutter and Firebase that allows users to send text and image messages.

## Features

- User authentication using Firebase Authentication
- Real-time messaging using Firebase Firestore
- Support for sending text messages
- Support for sending image messages
- User profile management

## Screenshots

<div style="display:flex;justify-content:center;">
    <img src="/assets/docs/1.jpeg" alt="Screenshot 1" width="200" />
    <img src="/assets/docs/2.jpeg" alt="Screenshot 2" width="200" />
    <img src="/assets/docs/3.jpeg" alt="Screenshot 3" width="200" />
    <img src="/assets/docs/4.jpeg" alt="Screenshot 4" width="200" />
</div>
## Getting Started

These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK: Follow the official Flutter installation guide for your operating system: [Flutter - Get Started](https://flutter.dev/docs/get-started)
- Firebase project: Create a new project in the Firebase console: [Firebase Console](https://console.firebase.google.com)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/simple-chat-app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd simple-chat-app
   ```

3. Install the dependencies:

   ```bash
   flutter pub get
   ```

4. Configure Firebase:

   - Create a new Firebase project in the Firebase console.
   - Enable Firebase Authentication and Firestore in your project.
   - Download the `google-services.json` file for Android or `GoogleService-Info.plist` file for iOS from the Firebase console.
   - Place the downloaded file in the appropriate location within your Flutter project.

5. Run the app:

   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please follow these guidelines:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Submit a pull request

Please make sure to follow the [Code of Conduct](CODE_OF_CONDUCT.md) and [Contributing Guidelines](CONTRIBUTING.md) when contributing.

## License

This project is licensed under the [MIT License](LICENSE).
