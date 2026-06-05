# Dashmesh Mechanix

A comprehensive Flutter-based mobile application designed for RO (Reverse Osmosis) and water purifier service management. Dashmesh Mechanix streamlines technician workflows, customer tracking, EMI/installment collections, and daily visit entries.

## 🚀 Features

*   **Role-Based Access Control (RBAC):** Distinct workflows for Admins and Technicians. Admins have access to financial data (EMIs, collections), while Technicians can focus on daily service visits and customer management.
*   **Customer Directory:** A searchable and filterable database of all customers. Tracks customer details, device types (Commercial, Domestic, Industrial), installation dates, and full service history.
*   **Service & Visit Entry:** Technicians can seamlessly record new visits, log remarks, update filter replacement schedules, and track AMC (Annual Maintenance Contract) balances.
*   **EMI & Installment Management:** Track pending payments, generate payment schedules, and record partial or full payments. Includes a dedicated view for "Pending this Month."
*   **Interactive Dashboard:** A home screen summarizing daily activities, new sales, collected amounts, pending installations, and upcoming AMC visits.
*   **Responsive UI:** Carefully designed UI that gracefully adapts to various screen sizes and accessibility text-scaling settings without `RenderFlex` overflows.

## 🏗️ Architecture

This project is built using a **Clean Architecture** approach combined with a modular package structure.

### Package Structure

The codebase is divided into independent local packages to ensure separation of concerns and maintainability:

*   **`core`**: Contains foundational elements like Dependency Injection (`get_it`), shared utilities, network clients, and common domain models.
*   **`core_ui`**: The centralized design system. Contains the application's theme, color palettes, typography, and highly reusable widgets (buttons, text fields, cards).
*   **`router`**: Handles application navigation using `go_router`. Manages the shell route with the persistent bottom navigation bar.
*   **`home_page`**: The dashboard module. Handles data aggregation for daily summaries and expense tracking.
*   **`customer_directory`**: Manages the complete list of customers and detailed customer profiles (including service history).
*   **`emi_page`**: The module dedicated to financial tracking, pending installments, and payment collection.
*   **`visit_entry`**: Handles the form and workflow for recording a technician's service visit to a customer.

### State Management

The app uses the **BLoC (Business Logic Component)** pattern (`flutter_bloc`) across all packages for predictable state management, ensuring UI components remain reactive to changes in the data layer.

## 🛠️ Technology Stack

*   **Framework:** [Flutter](https://flutter.dev/) (Dart)
*   **Backend / Database:** [Firebase Firestore](https://firebase.google.com/docs/firestore)
*   **State Management:** `flutter_bloc`
*   **Navigation:** `go_router`
*   **Dependency Injection:** `get_it`

## ⚙️ Setup & Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/manish12345p/dashmeshro.git
    cd dashmeshro
    ```

2.  **Install Dependencies**
    Ensure you run `flutter pub get` in the root directory, as well as inside every local package:
    ```bash
    flutter pub get
    ```
    *(Note: Using a tool like `melos` is recommended for managing multi-package workspaces).*

3.  **Firebase Configuration**
    This project relies on Firebase. Ensure you have your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) placed in their respective platform directories.

4.  **Run the App**
    ```bash
    flutter run
    ```

## 📱 Screenshots & UI

The app features a modern, clean aesthetic using a customized `crystal_navigation_bar` and beautiful gradient cards. Extensive care has been taken to ensure all layout components are flexible (`Expanded`, `Flexible`, `SingleChildScrollView`, `Wrap`) to prevent UI breakage on different devices.

---
*Built for efficient field service and customer management.*
