# Setup and implementation notes

[Back to the overview](../README.md) · [Code map](CODE_MAP.md)

These notes come from source inspection. The application was not executed during the documentation review. The repository needs configuration and source corrections before a clean end-to-end run can be claimed.

## 1. Check the Flutter environment

The manifest declares Dart SDK `^3.5.3`. Use a compatible Flutter SDK and inspect the environment and dependencies:

```sh
flutter --version
flutter doctor
flutter pub get
flutter analyze
flutter test
```

These are diagnostic steps, not a statement that the current source passes them. In particular:

- Some imports use `CategoryListProduct.dart`, while the checked-in filename is `CategoryListproduct.dart`. The case must agree for case-sensitive environments.
- `test/widget_test.dart` still expects the starter counter application; it does not validate the shopping application's current screens.
- Socket initialization and the use of sample data need to be reviewed together when choosing the intended runtime flow.

The networking source uses `dart:io` raw TCP sockets. A `web/` folder does not make that client work in a browser. Select and validate an appropriate desktop or mobile target first; browser support would require a suitable networking approach.

After resolving the source and backend configuration, inspect targets with `flutter devices` and launch with `flutter run -d <device-id>`. No target has been certified by this documentation review.

## 2. Establish one backend build

The Java sources require a JDK. Sources also reference Gson, and MySQL access requires an appropriate JDBC driver such as MySQL Connector/J. The repository does not currently provide a dedicated backend dependency manifest with pinned versions and a reproducible build. The Android Gradle files are not a replacement for that backend setup.

Before writing a definitive server launch command, resolve these source issues:

- `MainClientHandler.java` declares `MainClientHandler` but has a constructor named `UnifiedClientHandler`.
- Combined-handler code refers to `DatabaseManager`, while the checked-in alternatives include `DataBaseManager` and `MainDataBaseManager`. The intended class and API must be reconciled.
- Select one server iteration and its matching client protocol; do not compile or start every experimental variant as if it were one finished application.

### Ports found in the source

| Server variant | Port(s) |
| --- | --- |
| `MainServer` | 8080 and 12345 |
| Separate account server | 8080 |
| `ProductServer` | 12345 |
| `CartServer` | 12345 |
| `ProductSpecsServer` | 12345 |
| `FavoriteProductsServer` | 12346 |

Several variants bind the same ports. They cannot all listen on the same host at the same time with those settings. Align the Dart client's host, port, request format, and response format with the chosen server.

## 3. Make data and configuration reproducible

No database schema or seed-data script is supplied. Derive and document the schema required by the selected SQL managers, then add synthetic sample data. Keep the file-backed account variant distinct from the MySQL-backed code when documenting the chosen flow.

Machine-specific network addresses, file paths, and database settings need portable configuration. Use local configuration for credentials rather than publishing real account values. Replace embedded account examples with synthetic data, and review password handling before using real accounts.

## 4. Validate before adding a demo

A useful first verified demo should record:

1. Flutter/Dart, Java, dependency, and database versions.
2. The selected server entry point, reproducible build steps, and schema initialization.
3. Successful account, product-listing, and cart flows, including error handling.
4. Tests for the actual application in place of the starter counter test.
5. Real screenshots and a short walkthrough from the tested target.

Until then, describe the repository as coursework implementation source. The documentation does not establish a live website, a production service, or completed payment integration.
