# Fast Food Management System (FFMS)

A comprehensive Flutter Windows application for managing fast food operations.

## Features

- Dashboard with real-time metrics
- Order Management
- Menu and Combo Management
- Delivery Management
- Inventory Management
- Employee Management
- Expense Management
- Reporting and Analytics
- Role-based Authentication

## Prerequisites

- Flutter SDK (latest stable version)
- PostgreSQL 14 or later
- Windows 10 or later

## Setup Instructions

1. Install PostgreSQL and create a database named 'ffms_db'
2. Run the database initialization script from `database/init.sql`
3. Update the database connection settings in `lib/src/config/database.dart`
4. Run `flutter pub get` to install dependencies
5. Run `flutter run -d windows` to start the application

## Default Login

- Username: admin
- Password: admin123

## Project Structure

```
lib/
├── src/
│   ├── app.dart
│   ├── config/
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── services/
│   ├── theme/
│   └── widgets/
└── main.dart
```

## Database Schema

The application uses PostgreSQL with the following main tables:
- users
- menu_items
- orders
- inventory_items
- employees
- expenses

For detailed schema information, refer to `database/init.sql`.