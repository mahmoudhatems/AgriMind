# AgriMind: Your Smart Farming Companion

---

## 🚀 Overview

AgriMind is a cutting-edge **smart farming system** engineered to revolutionize agricultural practices through the seamless integration of **Internet of Things (IoT)** and **Artificial Intelligence (AI)**. Our comprehensive solution empowers farmers to **monitor and manage their farm operations remotely in real time**, fostering enhanced sustainability and productivity in agriculture.

The system is built around a robust multi-zone architecture, where distributed ESP32-based microcontrollers manage distinct farm environments, including greenhouses, warehouses, barns, residential areas, parking facilities, and advanced hydroponics setups. The AgriMind mobile application serves as the central, intuitive user interface, meticulously translating complex streams of sensor data and sophisticated AI insights into actionable information, thereby bringing the transformative power of Agriculture 4.0 directly to the farmer's fingertips.

---

## ✨ Key Features

* **Real-time Farm Monitoring:** Gain instantaneous insights into critical environmental parameters such as temperature, humidity, pH levels, soil moisture, gas concentrations, and motion detection across diverse farm zones.
* **Remote Actuator Control:** Directly manage and automate farm equipment, including fans, water pumps, security alarms, and access gates, all controllable from your mobile device.
* **AI-Powered Predictive & Analytical Insights:** Leverage custom Convolutional Neural Network (CNN) models for advanced agricultural intelligence:
    * **Animal Health and Behavior Monitoring:** Receive data-driven insights into livestock well-being, aiding in early detection of anomalies.
    * **Automated Fruit Freshness Classification:** Optimize post-harvest management, reduce spoilage, and enhance produce quality control.
* **Smart & Proactive Notifications:** Receive immediate, threshold-based alerts for critical events (e.g., dangerously high temperatures, critically low water levels, detected flames) pushed directly to your mobile device.
* **Historical Data Visualization:** Analyze long-term trends and patterns with interactive and clear graphical representations, including a specialized Total Dissolved Solids (TDS) chart crucial for hydroponic nutrient management.
* **Robust Connectivity Management:** Resilient firmware ensures continuous system operation even amidst network fluctuations, with intelligent mechanisms for seamlessly switching between pre-configured Wi-Fi networks.
* **User-Friendly Mobile Application:** An intuitively designed Flutter-based mobile application ensures a seamless, accessible, and engaging experience for monitoring and control, regardless of technical expertise.

---

## 💡 Architecture & Design Philosophy

AgriMind's mobile application is architected for **superior robustness, high scalability, and ease of maintainability**, strictly adhering to the principles of **Clean Architecture** and the **Repository Pattern**. This meticulously layered design ensures a clear **separation of concerns**, rendering the codebase highly organized, extensively testable, and exceptionally **flexible for future updates and expansions**.

The application is logically segmented into distinct, decoupled layers:

1.  **Presentation Layer (UI/Widgets/Blocs/Cubits):** This outermost layer is solely responsible for rendering the user interface and managing all user interactions.
2.  **Domain Layer (Entities/Use Cases/Repositories Interfaces):** This is the immutable core of the application, housing the fundamental business logic and rules, completely independent of any framework or external database.
3.  **Data Layer (Models/Repository Implementations/Data Sources):** This layer is dedicated to retrieving and persisting data from various external sources (e.g., Firebase Realtime Database).

This stringent separation, enforced through **dependency inversion**, bestows profound advantages:

* **Maintainability:** Changes within a single layer (e.g., migrating from Firebase to an alternative cloud provider) can be isolated, significantly reducing impact and risk.
* **Testability:** Each layer can be unit-tested in complete isolation without the need for external dependencies.
* **Scalability:** The modular nature makes integrating new features, sensor types, or farm zones a straightforward process.
* **Future-Proofing:** The inherent decoupling protects the application from rapid technological obsolescence.

The **Repository Pattern** serves as a vital intermediary, presenting a clean and consistent API for data access. This allows UI components to function without needing granular knowledge of data origin or retrieval mechanisms. This architectural clarity is further enhanced by **`get_it` for Dependency Injection**.

---

## 🛠️ Technologies Used

### Mobile Application (Flutter)

* **Framework:** Flutter (Cross-platform UI development)
* **Language:** Dart
* **State Management:** Bloc
* **Dependency Injection:** `get_it`
* **Navigation:** `go_router`
* **UI/UX:** `flutter_screenutil` (Responsive design), `google_nav_bar`, `lottie` (Animations), `animated_text_kit` (Text effects), `escape_parent_padding`
* **Data Visualization:** `fl_chart` (Charts), `syncfusion_flutter_gauges` (Radial gauges)
* **Notifications:** `flutter_local_notifications`
* **Permissions:** `permission_handler`
* **Local Storage:** `shared_preferences`

### Backend & Cloud Services

* **Cloud Platform:** Google Firebase
    * **Realtime Database:** For real-time, bidirectional data synchronization of sensor readings and actuator commands.
    * **Authentication:** For secure user login and registration (supporting Email/Password, Google Sign-In, Facebook Login).

### Hardware

* **Microcontroller:** ESP32 (Used as the core controller for each farm zone)
* **Sensors:** DHT22 (Temperature, Humidity), pH sensor, Soil Moisture sensor, PIR (Motion) sensor, Gas sensor, Flame sensor, Light sensor, TDS sensor.
* **Actuators:** Ventilation fans, water pumps, security alarms, gate mechanisms.

---

## 🚀 Getting Started

To set up and run the AgriMind project, follow these steps:

### Prerequisites

* [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (Version 3.x.x or higher recommended)
* [Firebase CLI](https://firebase.google.com/docs/cli) installed and configured
* Node.js and npm/yarn (for Firebase CLI)
* A Google account to set up a Firebase project

### 1. Firebase Project Setup

1.  **Create a New Firebase Project:**
    * Go to the [Firebase Console](https://console.firebase.google.com/).
    * Click "Add project" and follow the on-screen instructions. Note your **Project ID**.

2.  **Enable Firebase Features:**
    * In your Firebase project, navigate to **Build > Authentication**.
    * Go to the "Sign-in method" tab and enable: **Email/Password**, **Google**, and **Facebook** (follow Firebase's instructions for setting up OAuth consent screen, adding app fingerprints/Bundle IDs, and Facebook Developer App configuration).
    * Navigate to **Build > Realtime Database**.
    * Click "Create database" and choose a location. Start in **test mode** for initial development (understand security implications for production).

3.  **Update Firebase Options in Flutter:**
    * Open your terminal in the `agrimind_mobile_app` root directory.
    * Run: `flutterfire configure`
    * Select your Firebase project and desired platforms (Android, iOS). This will automatically generate the `lib/firebase_options.dart` file.
    * **Important:** Ensure your `android/app/src/main/AndroidManifest.xml` includes the necessary Facebook metadata and activity declarations as outlined in the FlutterFire/Facebook SDK documentation, replacing placeholders with your actual Facebook App ID and Client Token.

### 2. Running the Mobile Application

1.  **Clone the Repository:**
    ```bash
    git clone 
    cd AgriMind/agrimind_mobile_app
    ```
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Generate Launcher Icons (Optional, but recommended):**
    ```bash
    flutter pub run flutter_launcher_icons:main
    ```
4.  **Run the Application:**
    * Connect an Android or iOS device, or start an emulator/simulator.
    * Run:
        ```bash
        flutter run
        ```

### 3. Hardware (ESP32) Setup

* The mobile application relies on data pushed from ESP32 microcontrollers deployed across your farm zones.
* You will need to flash your ESP32 devices with the appropriate firmware that collects sensor data and publishes it to your configured Firebase Realtime Database.
* Ensure the Firebase data paths defined in your ESP32 firmware precisely match the paths the mobile application expects to read from and write to (e.g., `/hydroponics`, `/greenhouse`, `/warehouse`, `/barn`, `/home`, `/parking`, `/system`).

---

## 🚀 Usage Examples

This section guides you through typical user interactions and showcases the core functionalities of the AgriMind mobile application.

### 1. Onboarding and Authentication

* **Initial Launch:** Upon first opening the app, you'll be greeted by the **Splash Screen**, followed by the **Onboarding Carousel**.
    **(Note: Insert a screenshot of the Splash Screen here. It should prominently feature the AgriMind logo and the animated "Welcome to AgriMind" text.)**
    **(Note: Insert a screenshot of the Onboarding Carousel here, showing one of the introductory slides.)**

* **User Registration:** If you don't have an account, tap "Get Started" on the onboarding screen, then select "Register". You can sign up using Email/Password, or conveniently via Google or Facebook.
    **(Note: Insert a screenshot of the Registration Screen here, showing the input fields and social login options.)**

* **User Login:** Existing users can log in using their credentials or social accounts.
    **(Note: Insert a screenshot of the Login Screen here, highlighting the input fields and social login options.)**
    * **Login Flow:** Input your Email and Password, then tap "Login".
        * **Success:** You'll be seamlessly navigated to the **Home Dashboard**.
        * **Failure:** A `SnackBar` notification will appear at the bottom of the screen with an error message (e.g., "Wrong password or email").
        **(Note: Describe the user flow for a successful login, emphasizing the transition to the home screen. Also, describe the feedback for a failed login, showing the `SnackBar`.)**

### 2. Navigating the Farm Zones

Once logged in, the **Home Dashboard** provides a comprehensive overview. Use the **Bottom Navigation Bar** to effortlessly switch between different farm zones. The **Custom App Bar** at the top will reflect the current zone.

**(Note: Insert a screenshot of the Home Dashboard here. This should show the `StatusCard`, `SensorGrid`, and `ParkingSection`. The bottom navigation bar and custom app bar should also be visible.)**
**(Note: Insert a screenshot here that clearly displays both the bottom navigation bar (`GNav`) and the custom app bar at the top of a main screen (e.g., Home or Greenhouse).)**

### 3. Monitoring a Zone (e.g., Greenhouse)

1.  Tap the "Greenhouse" icon on the bottom navigation bar.
2.  The **Greenhouse Screen** will load, displaying real-time sensor data through interactive `GaugeSensorCard`s (Temperature, Humidity, Soil Moisture, Gas, Light).
3.  You can observe the current environmental conditions and receive proactive alerts for any deviations.
    **(Note: Insert a screenshot of the Greenhouse screen here. This should clearly show the environmental sensor gauges and the current readings.)**

### 4. Controlling Devices (e.g., Hydroponics Pump)

1.  Navigate to the "Hydroponics" section using the bottom navigation bar.
2.  On the **Hydroponics Page**, you'll see various sensors and the `TDSCard` displaying TDS levels. Below the sensor data, find the `HydroDeviceControls`.
3.  Locate the "Water Pump" `SwitchTile`. If the water level is low (you might receive a notification!), you can manually toggle this switch.
4.  Observe the pump status change in the UI almost instantly, reflecting the command sent to the ESP32.
    **(Note: Insert a screenshot of the Hydroponics page here. Highlight the Water Pump `SwitchTile` and its state change. You can also point to the TDS graph.)**
    * **User Flow:**
        1.  User opens Hydroponics tab.
        2.  Notices a "Low Water Level" notification (or sees the value directly on screen).
        3.  Locates the Water Pump toggle.
        4.  Taps the toggle to turn ON the pump.
        5.  The pump status visually updates to "ON", and potentially the water level starts rising after a short delay (reflecting new sensor data).

### 5. Receiving Smart Notifications

AgriMind proactively alerts you to critical events. For example:

* If the **warehouse temperature exceeds a threshold**, you'll receive a local notification on your device: "🌡️ High Temperature! Warehouse temperature is too high: XX°C."
* If **motion is detected in the barn** outside operating hours, you might get: "👀 Motion Alert! Motion detected in the barn zone."

These notifications are triggered by the relevant Cubits (`WarehouseBarnCubit`, `GreenhouseCubit`) based on real-time data from Firebase and your configured thresholds.

---

## 🔒 Permissions & Security

* **Notifications:** The app requests `android.permission.POST_NOTIFICATIONS` on Android 13+ at startup. You can manage notification preferences in the Settings screen.
* **Firebase Security Rules:** For production deployment, ensure your Firebase Realtime Database security rules are properly configured to prevent unauthorized data access and manipulation. Refer to Firebase documentation for secure rule setup.

---

## 🤝 Contribution

Feel free to contribute to the AgriMind project! Fork the repository, make your changes, and submit a pull request.

---

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

---

**© 2024 AgriMind Team. All rights reserved.**