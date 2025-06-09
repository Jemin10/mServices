# 🛠 mServices App (Demo)

A role-based service provider app built using **Flutter**, featuring two types of users: **Customer** and **Service Provider**. This app demonstrates login/signup, dynamic home screens, profile management, and order tracking—all styled with a modern blue-themed UI.

---

## ✨ Features

### 🔐 Authentication
- Email-based login and sign-up using Firebase
- Role selection during signup (Customer or Service Provider)

### 👤 Customer Side
- Search functionality
- Category vise filters
- Top service providers list
- Service Provider detail screen
- Customer profile screen

### 🛠 Service Provider Side
- Enter complete profile details upon login
- View and manage all received orders
- Profile management screen

---

## 📱 Screens Implemented

- Login / Signup + Role Selection
- Customer Home
- Service Provider Detail
- Profile Screen (for both roles)
- Order Management Screen (Service Provider)

---

## 🧰 Tech Stack

- **Flutter SDK**: 3.27.2
- **State Management**: GetX / Provider (as per usage)
- **Firebase Authentication**
- **Firebase Firestore** (for user and order data)

---

## 🗓 Time Log Sheet

| Date       | Task Description                                     | Hours Spent  |
|------------|------------------------------------------------------|--------------|
| 2025-06-07 | Project setup, auth UI (Login/Signup), role logic    | 4 hrs        |
| 2025-06-07 | Customer home UI with search, categories, top SPs    | 3 hrs        |
| 2025-06-07 | SP detail screen, Firebase integration               | 3.5 hrs      |
| 2025-06-07 | Profile pages for both roles                         | 2 hrs        |
| 2025-06-09 | Order model + tracking UI (SP side)                  | 2 hrs        |
| 2025-06-09 | Dummy data creation, testing, bug fixes              | 2 hrs        |
| 2025-06-09 | Final polish, README, JSON generation, screenshots   | 2 hrs        |
| **Total**  |                                                      | **18.5 hrs** |

---

## 📁 Sample Data

- `service_providers.json`: 50 sample service providers
- `orders_data.json`: 15 sample orders with varied statuses

---

## 📌 Note

This is a demo app for evaluation purposes and does not include full production-grade validations or security practices.

