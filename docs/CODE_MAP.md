# Code map

[Back to the overview](../README.md) · [Setup notes](SETUP.md)

## Flutter interface

| Location | Purpose |
| --- | --- |
| [`lib/main.dart`](../lib/main.dart) | Application entry point, routes, and right-to-left layout |
| [`lib/Home/`](../lib/Home/) | Home screen and product cards |
| [`lib/Category/`](../lib/Category/) | Categories and category product listings |
| [`lib/Product details/`](../lib/Product%20details/) | Product detail, technical specifications, and favorites views |
| [`lib/Cart/`](../lib/Cart/) | Cart presentation |
| [`lib/Login_and_SIgn up/`](../lib/Login_and_SIgn%20up/) | Login and sign-up screens |
| [`lib/Account/`](../lib/Account/) | Profile and account-field editing |
| [`lib/Offer and Supreme/`](../lib/Offer%20and%20Supreme/) | Offer and subscription-related views |
| [`lib/Address/`](../lib/Address/) | Address interface |
| [`lib/Payment/`](../lib/Payment/) | Payment-related interface; an operational payment gateway is not established by these screens |
| [`lib/Product.dart`](../lib/Product.dart) | Product model |
| [`lib/FakeData.dart`](../lib/FakeData.dart) | Local sample data |

## Networking and Java source

The Dart clients include [`clientSocket.dart`](../lib/clientSocket.dart), [`ProductClientSocket.dart`](../lib/ProductClientSocket.dart), and [`mixClientSocket.dart`](../lib/mixClientSocket.dart). These use raw socket communication rather than a browser HTTP API.

The [`lib/Server/`](../lib/Server/) directory contains several server iterations:

| Source | Role in the code |
| --- | --- |
| [`MainServer.java`](../lib/Server/MainServer.java) | Combined listeners and handler dispatch |
| [`server.java`](../lib/Server/server.java) | Separate account-server implementation |
| [`ProductServer.java`](../lib/Server/ProductServer.java) | Product service variant |
| [`CartServer.java`](../lib/Server/CartServer.java) | Cart service variant |
| [`ProductSpecsServer.java`](../lib/Server/ProductSpecsServer.java) | Product-specification service variant |
| [`FavoriteProductsServer.java`](../lib/Server/FavoriteProductsServer.java) | Favorites service variant |
| [`ProductDatabaseManager.java`](../lib/Server/ProductDatabaseManager.java) | SQL product queries and updates using prepared statements |
| [`MainDataBaseManager.java`](../lib/Server/MainDataBaseManager.java) | Combined database-manager implementation |
| [`DataBaseManager.java`](../lib/Server/DataBaseManager.java) | File-backed account-data implementation |

These are not all independent services intended to run together. Some share ports, and the combined-server sources have unresolved naming issues. See [setup notes](SETUP.md).

## Supporting files

- [`pubspec.yaml`](../pubspec.yaml) and [`pubspec.lock`](../pubspec.lock) define the Flutter dependencies.
- [`assets/`](../assets/) contains product images and interface assets; these are not screenshots proving a running application.
- [`test/widget_test.dart`](../test/widget_test.dart) is the starter counter test and needs to be adapted to the current application.
- The platform folders contain Flutter platform scaffolding. Runtime support still needs verification.
- [`myapplication/`](../myapplication/) is an additional Android module, not a reproducible build configuration for the Java socket backend.
