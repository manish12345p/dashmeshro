<div align="center">
  <img src="assets/logo.jpg" width="150" height="150" alt="Dashmesh Mechanix Logo">
  <h1>Dashmesh Mechanix</h1>
  <p><strong>A Modern, CRM App for RO & Water Purifier Field Service</strong></p>
</div>

<br>

**Dashmesh Mechanix** is a full-featured Flutter application built to streamline operations for RO (Reverse Osmosis) sales and service businesses. It seamlessly connects daily technician visits, customer history tracking, AMC (Annual Maintenance Contract) lifecycles, and financial management (EMI & Installments) into a single, intuitive mobile interface.

---

## ✨ Core Features

### 🔐 Intelligent Role-Based Access Control (RBAC)
The app dynamically adapts its interface based on the active role (Admin vs. Technician).
*   **Technician Mode (Default):** Focused purely on field service. Technicians can view the customer directory, log new daily visits, check filter statuses, and consume AMC visits. Financial data and EMI collection features are hidden to prevent unauthorized access.
*   **Admin Mode:** Unlocks the complete financial suite. Admins can view pending EMIs, collect partial or full payments, and manage the complete business dashboard. 
    *   *Secret Unlock:* The Admin mode is secured by a hidden gesture (tapping the "Dashmesh Mechanix" title 7 times on the Home Screen) and a secure password.

### 👥 Comprehensive Customer Directory
*   **Unified Profiles:** Every customer has a dedicated profile tracking their Name, Phone, Address, RO Type (Commercial, Domestic, Industrial), and Installation Date.
*   **Service History:** A chronological timeline of every visit, showing what services were performed, filter changes, remarks, and AMC consumption.
*   **Smart Search:** Real-time search by customer name or phone number, with paginated list views to handle large databases efficiently.

### 📅 Visit & Service Entry
*   **AMC Tracking:** When an AMC is sold, the app tracks the total number of visits allowed. Each subsequent service logs the visit and decrements the remaining AMC balance. The app automatically blocks further AMC visits when the balance hits zero.
*   **Filter Lifecycle Management:** Technicians can quickly update the installation dates for various filters (Sediment, Carbon, RO Membrane, UV, UF) during a visit.
*   **Quick Logging:** Streamlined forms to identify the customer, select service types (Installation, Complaint, Regular Service, AMC), log remarks, and submit to the cloud instantly.

### 💰 EMI & Installment Management (Admin Only)
*   **Pending Collections:** A dedicated tab showing all pending and overdue installments, calculating the total pending amount and the number of clients pending for the current month.
*   **Partial Payments:** Supports recording partial payments for an EMI, maintaining the remaining balance automatically in Firestore.
*   **Financial Dashboard:** The home screen provides a quick overview of "Today's Summary" (sales, collections) and "Work Done" (installations, complaints resolved).

---

## 🏗️ Technical Architecture

Dashmesh Mechanix is built for scale using **Clean Architecture** principles and a **Modular Package Structure**. This ensures that different features are isolated, testable, and independently maintainable.

### 📦 Project Structure

The project is divided into distinct local packages located in the `packages/` directory:

1.  **`core`**: The backbone of the app. Houses Dependency Injection (`get_it`), Firebase configuration, base entities, global state (like `RoleCubit`), and shared utilities.
2.  **`core_ui`**: The centralized design system. Defines the global `AppTheme`, color palettes, typography, and contains all shared generic widgets (AppBars, custom TextFields, buttons) to ensure UI consistency.
3.  **`router`**: Manages deep linking and application routing using `go_router`. It encapsulates the `ShellRoute` which wraps the app in the stunning `crystal_navigation_bar`.
4.  **`home_page`**: The dashboard module containing the high-level business metrics and daily work summaries.
5.  **`customer_directory`**: Manages the customer database, UI lists, and the detailed profile view containing the chronological service history.
6.  **`emi_page`**: The financial module handling pending EMIs, payment logging, and installment data layers.
7.  **`visit_entry`**: The wizard-like form module that allows technicians to log new service visits and update filter statuses.
8.  **`history_page`**: The unified service history log showing all completed and pending services chronologically across the entire database.
9.  **`calendar`**: A dedicated calendar view for scheduling and tracking daily appointments and service reminders.

### ⚙️ Tech Stack & State Management
*   **Frontend Framework:** Flutter (Dart)
*   **State Management:** BLoC / Cubit (`flutter_bloc`). Used extensively across all packages to separate UI from business logic.
*   **Database:** Firebase Cloud Firestore (NoSQL). Handles real-time syncing of customers, visits, and EMIs.
*   **Dependency Injection:** `get_it` for decoupling implementations from interfaces.
*   **Responsive UI:** The layout uses flex layouts (`Expanded`, `Wrap`, `Flexible`, `SingleChildScrollView`) throughout the app to ensure *zero* `RenderFlex` overflow errors, regardless of device size or system font-scaling preferences.

---

## 🛠️ Setup & Installation Instructions

To run this project locally, follow these steps:

### 1. Prerequisites
*   Flutter SDK (^3.10.8 or higher)
*   Dart SDK
*   Android Studio / Xcode (for emulation/building)

### 2. Clone the Repository
```bash
git clone https://github.com/manish12345p/dashmeshro.git
cd dashmeshro
```

### 3. Fetch Dependencies
Because the app relies on a multi-package architecture, you need to run `flutter pub get` in the root directory and inside each local package:
```bash
flutter pub get
cd packages/core && flutter pub get && cd ../..
cd packages/core_ui && flutter pub get && cd ../..
cd packages/router && flutter pub get && cd ../..
# ... repeat for all packages
```

### 4. Firebase Setup
The app requires a Firebase backend. You must configure your own Firebase project:
1. Create a project in the Firebase Console.
2. Enable **Firestore Database**.
3. Register your Android and iOS applications.
4. Download the `google-services.json` file and place it in `android/app/`.
5. Download the `GoogleService-Info.plist` file and place it in `ios/Runner/`.

### 5. Environment Variables
Create a `.env` file in the root directory (this file is gitignored to protect secrets). Add any necessary configuration variables required by the `core` package (if applicable).

### 6. Run the App
```bash
flutter run
```

---

<p align="center">
  <i>Designed & Developed to empower field technicians and business owners alike.</i>
</p>
