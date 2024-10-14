# Exinity App Documentation  

---

## Overview  
**Exinity App** is a stock trading application developed in Flutter for an assessment interview. The app provides users with real-time stock data, popular stocks recommendations, and network connectivity status. It follows a feature-first architecture (Clean Architecture) and uses the Bloc pattern for effective state management, ensuring a clear separation between UI and business logic.

---

## Design Decisions  

### 1. **Architecture**  
The Exinity App follows a **feature-based architecture (Clean Architecture)**, meaning each feature is self-contained. This approach improves scalability and maintainability, allowing for easy updates and management of code.  

### 2. **State Management**  
We use the **Bloc (Business Logic Component)** pattern to manage state, ensuring business logic is separated from UI components. This makes the app more testable, maintainable, and organized.  
- **Cubit**: Manages a single state, suitable for simpler logic.  
- **Bloc**: Manages multiple states and events, providing robust solutions for complex scenarios.

### 3. **UI Design**  
The app’s UI is built with Flutter’s widget system, following **Material Design** principles. This ensures a responsive, consistent, and modern user experience across platforms (Android, iOS, and web).  

---


## Screenshot



![Exinity App Screenshot](https://drive.google.com/file/d/1LYoWjnqZwV0J0odpXSltEeH8oMQCH0cd/view?usp=drive_link)

![Exinity App Screenshot](https://drive.google.com/file/d/1FqDWZ35HBfOXAa-6tQ1eYE3X6E85ISrO/view?usp=drive_link)

![Exinity App Screenshot](https://drive.google.com/file/d/1ugawncr_uCSjY7E9QQxF3WbtX4_7ctCH/view?usp=drive_link)

![Exinity App Screenshot](https://drive.google.com/uc?export=view&id=11RCj-4CHLXRniYH_v4jFATMY9N8MeUd1)

---

## Key Blocs and Cubits  

- **ConnectivityCubit**  
  **File**: `lib/core/bloc/connectivity/connectivity_cubit.dart`  
  **States**: `ConnectivityConnected`, `ConnectivityDisconnected`  
  **Purpose**: Monitors the internet connection and updates the app based on connectivity status.

- **WebsocketBloc**  
  **File**: `lib/core/bloc/websocket/websocket_bloc.dart`  
  **States**: `WebsocketInitial`, `WebsocketConnected`, `WebsocketDisconnected`  
  **Purpose**: Manages real-time WebSocket connections to provide live stock updates.

- **StocksBloc**  
  **File**: `lib/features/stocks/presentation/bloc/stocks/stocks_bloc.dart`  
  **States**: `StocksInitial`, `StocksLoaded`  
  **Purpose**: Manages state for popular and watchlist stocks.


- **SearchBloc**  
  **File**: `lib/features/stocks/presentation/bloc/search/search_bloc.dart`  
  **States**: `SearchInitial`, `SearchLoaded`  
  **Purpose**: Manages search functionality.


- **WatchlistBloc**  
  **File**: `lib/features/stocks/presentation/bloc/watchlist/watchlist_bloc.dart`  
  **States**: `WatchlistInitial`, `WatchlistLoaded`  
  **Purpose**: Manages adding and remove watchlist stocks



---


## APIs

The Exinity App uses the **Finnhub API** to fetch real-time stock data and other financial information. The Finnhub API provides a wide range of financial data, including stock prices, company news, and market trends.

### 1.API Token

To access the Finnhub API, an API token is required. This token is managed securely using the **envied** package, which allows for environment variable management. The token is stored in an environment file and accessed securely within the app.



### 2.API Endpoints Used


#### 1.Symbols Data
Endpoint: **https://finnhub.io/api/v1/stock/symbol?exchange=US&token=s2h5s1r01qpjum5v210cs2h5s1r01qpjum5v21g**
Purpose: Fetches details about all available trading instruments (stocks). Used during app startup to populate the list of available stocks.


#### 2.Stock Quote Data
- Endpoint: **https://finnhub.io/api/v1/stock/symbol?exchange=US&token=cs2h5s1r01qpjum5v210cs2h5s1r01qpjum5v21g**
- Purpose: Retrieves details about a specific stock, including the current price and last close price. Essential for calculating percentage changes     before establishing a WebSocket connection.
- Note:So i must call this api before websocket to be able to calculate change percentage
 
#### 3.WebSocket Stream
- Endpoint: **wss://ws.finnhub.io?token=cs2h5s1r01qpjum5v210cs2h5s1r01qpjum5v21g**
- Purpose: Provides live ticker updates for stocks, enabling real-time price changes. 
- Note: WebSocket functionality is available only during market hours.

---

## Features  

- **Real-Time Stock Data**: Live data on various stocks.  
- **Stocks**: Displays trending and frequently traded stocks.  
- **Connectivity Monitoring**: Updates users on internet connection status.  
- **WebSocket Integration**: Provides live updates via WebSocket connections.  

---

## Third-Party Libraries  

| **Library**                     | **Version** | **Purpose**                               | **Usage**                                      |
|----------------------------------|-------------|------------------------------------------|------------------------------------------------|
| **cupertino_icons**              | ^1.0.8      | iOS-style icons                          | Ensures a consistent look on iOS devices.      |
| **flutter_localizations**        | sdk: flutter| Localization support                     | Enables multilingual support.                  |
| **flutter_bloc**                 | ^8.1.6      | Bloc utilities                           | State management throughout the app.           |
| **intl**                         | ^0.19.0     | Localization tools                       | Displays text based on user language.          |
| **equatable**                    | ^2.0.5      | Simplifies equality checks               | Used to compare Bloc states and events.        |
| **dartz**                        | ^0.10.1     | Functional programming tools             | Enables safer code with `Either` and `Option`. |
| **get_it**                       | ^8.0.0      | Service locator                          | Dependency injection for better testing.       |
| **dio**                          | ^5.7.0      | HTTP client                              | Fetches data from remote servers.              |
| **envied**                       | ^0.5.4+1    | Environment variable management          | Manages sensitive configurations securely.     |
| **shared_preferences**           | ^2.3.2      | Persistent storage                       | Stores user settings across sessions.          |
| **go_router**                    | ^14.3.0     | Declarative routing solution             | Handles smooth navigation across screens.      |
| **internet_connection_checker** | ^1.0.0+1     | Internet connectivity checker            | Detects connectivity changes.                  |
| **connectivity_plus**            | ^6.0.2      | Monitors network status                  | Responds to network state changes.             |
| **flutter_screenutil**           | ^5.9.3      | Responsive design utilities              | Adapts UI to different screen sizes.           |
| **logger**                       | ^2.4.0      | Logging utilities                        | Aids in debugging with logs.                   |
| **web_socket_channel**           | ^3.0.1      | WebSocket support                        | Enables real-time communication.               |
| **collection**                   | ^1.18.0     | Collection utilities                     | Advanced manipulation of lists and maps.       |
| **bloc_concurrency**             | ^0.2.5      | Concurrency utilities                    | Efficiently handles multiple Bloc events.      |
| **google_fonts**                 | ^6.2.1      | Access to Google Fonts                   | Enhances the app’s visual appeal.              |

---

## Setup Instructions  

### Installation  

1. **Clone the Repository**:  
   git clone https://github.com/fadygrgs/exinity_app.git
   cd exinity_app

2. **Install Dependencies**:  
   flutter pub get

3. **Run the App**:  
   flutter run

### Running Tests  

To run widget and unit tests:  
flutter test

---

## Project Structure  

lib/
├── const/
├── core/
│   ├── api/
│   │   ├── dio_client.dart
│   │   ├── dio_interceptor.dart
│   │   └── isolate_parser.dart
│   ├── env/
│   ├── errors/
│   ├── local/
│   │   └── shared_prefernces_helper.dart
│   ├── network/
│   │   └── cubit/
│   │       ├── connectivity_cubit.dart
│   │       └── connectivity_state.dart
│   ├── resources/
│   ├── routing/
│   │       ├── app_router.dart
│   │       └── app_routes.dart
│   ├── services/
│   │   └── websocket/
│   │       ├── web_socket_service.dart
│   │       └── bloc/
|   │           ├── websocket_bloc.dart
|   │           └── websocket_state.dart
│   ├── usecase/
│   │       ├── future_use_case.dart
│   │       └── use_case.dart
│   ├── theme/
│   ├── utilities/
│   └── services/
├── extensions/
├── features/
│   ├── stocks/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   │   ├── search/
│   │   │   │   │   ├── search_bloc.dart
│   │   │   │   │   ├── search_state.dart
│   │   │   │   │   └── search_event.dart
│   │   │   │   ├── stocks/
│   │   │   │   │   ├── stocks_bloc.dart
│   │   │   │   │   ├── stocks_bloc_impl.dart
│   │   │   │   │   ├── stocks_state.dart
│   │   │   │   │   └── stocks_event.dart
│   │   │   │   ├── watchlist/
│   │   │   │   │   ├── watchlist_bloc.dart
│   │   │   │   │   ├── watchlist_state.dart
│   │   │   │   │   └── watchlist_event.dart
│   │   │   ├── widgets/
│   │   │   └── pages/
│   │   │       └── home_screen.dart
│   └── shared/
│       └── domain/
│           └── entities/
│               └── symbol_entity.dart
└── generated/
    └── l10n.dart




## Testing  

- **Widget & Unit Tests**: Located in the `test/` directory.  
- **Dependencies for Testing**:  
  - `flutter_test`: For widget testing.  
  - `mockito`: For mocking dependencies.  

Run tests using: 
flutter test

---

## Localization  

The app supports multiple languages using the **intl package**. Localization files are generated in the `generated/` directory.

---



## Recommendations for Future Improvements

Given more time, the following enhancements could be implemented:
- Enhanced Error Handling: Add more sophisticated fallback mechanisms.
- Caching Strategy: Store frequently accessed data locally to reduce network usage.
- Expanded Data Display: Incorporate additional data points (e.g., historical prices, volume).
- Performance Optimizations: Optimize state updates for better UI responsiveness.

---

This documentation provides a complete overview of the **Exinity App**, including design decisions, setup instructions, key components, testing, and localization. This project is prepared for an **assessment interview**, demonstrating best practices in **Flutter development** with **Bloc state management** and a **feature-based architecture**.
ate updates for better UI responsiveness.