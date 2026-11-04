# Shop Keeping

A Flutter shop-inventory app built for the HNG 13 Mobile Stack Assignment. It demonstrates local product catalogue management with SQLite through [`sqflite`](https://pub.dev/packages/sqflite).

## What the app does

- Add products with a name, available quantity, price, and optional photo.
- Browse the saved catalogue in a product grid.
- Edit product details and remove products.
- Search the loaded catalogue by product name or price.
- Choose an image from the gallery or take one with the camera.

## Why sqflite fits this lightweight project

`sqflite` gives this Flutter app a straightforward way to use SQLite, a compact relational database stored on the device. For a small, single-user inventory catalogue, that is a practical alternative to setting up a remote database and backend service:

- **Local and offline:** product records are stored on the device, so the catalogue can be used without a network connection.
- **Simple CRUD:** SQLite tables and parameterized queries map naturally to the app's create, read, update, and delete operations.
- **Structured data:** product names, quantities, prices, and optional image data are kept together in a `products` table, with an auto-incrementing ID for each record.
- **Lightweight setup:** the app can persist and retrieve its data without requiring accounts, a server, or a more complex data layer.
- **Familiar SQL foundation:** SQLite is widely used in mobile apps, making this a useful example of local persistence and relational data handling in Flutter.

The database is created on first use as `product_catalogue.db` in the app's documents directory. A `DatabaseHelper` singleton opens it and provides methods to insert, fetch, update, and delete products. The `Product` model converts between Dart objects and the maps used by SQLite. Product images are optional and currently stored as Base64 text in the database.

This setup is intentionally scoped to a lightweight local app: data belongs to the device installation and is not automatically shared across devices or backed up to a server. For a larger inventory, consider image files instead of Base64 database fields, indexed/database-side search, migrations as the schema evolves, and a backend if users need synchronization or shared access.

## Getting started

### Requirements

- Flutter SDK and Dart SDK compatible with the versions specified in `pubspec.yaml`.
- A supported mobile target and its platform toolchain (Android Studio/Android SDK for Android, or Xcode for iOS).

### Run locally

```bash
git clone https://github.com/MikeTheExpert/shopKeeper.git
cd shopKeeper
flutter pub get
flutter run
```

The app depends on `sqflite` for SQLite access, `path_provider` and `path` for the database location, and `image_picker` for gallery and camera selection. Check each plugin's current platform support and setup instructions if building for a target other than Android or iOS.

## Project structure

- `lib/models/product_model.dart` — product data model and SQLite map conversion.
- `lib/models/db_helper_class.dart` — database initialization, table creation, and CRUD methods.
- `lib/pages/home_page.dart` — product catalogue, search, and delete flow.
- `lib/pages/upload_product_page.dart` — add a product and optionally select a photo.
- `lib/pages/update_product_page.dart` — edit an existing product.

## Demo links

- Video walkthrough: https://drive.google.com/file/d/1fxCwhf0zIMtaqmbpZLmvX3LsEpDsfSMG/view?usp=drive_link
- Appetize preview: https://appetize.io/app/b_dp5yileb24fl7l6t6w3f7zqc6a
- Repository: https://github.com/MikeTheExpert/shopKeeper.git
