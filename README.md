# iMove Challenge Flutter App

A Flutter application built with clean architecture patterns, featuring resilient API handling and modern state management.

## Architecture Overview

This project follows **Clean Architecture** principles with the following layers:

### Core Architecture Components
- **Repository Pattern**: Abstraction layer for data access
- **Dependency Injection**: Using GetIt for service locator pattern
- **Resilience Pattern**: Retry mechanisms and error handling
- **BLoC Pattern**: State management with flutter_bloc
- **Result Pattern**: Type-safe error handling with result_dart

### Key Design Decisions

#### 1. **Layered Repository Architecture**
```
IRidesRepository (Abstract)
    ↓
PreResilienceRidesRepository (Decorator)
    ↓
RidesRepository (Concrete)
    ↓
API Client
```

#### 2. **Resilience Executor**
Implements retry logic and circuit breaker patterns for robust API communication using `dio_smart_retry`.

#### 3. **Dependency Injection Strategy**
- **GetIt Extensions**: Modular DI registration with extension methods
- **Lazy Singleton**: Memory-efficient service instantiation

#### 4. **State Management**
- **flutter_bloc**: Reactive state management
- **Equatable**: Value equality for state objects
- **Result Dart**: Functional error handling

#### 5. **Navigation**
- **go_router**: Declarative routing with type safety

#### 6. **Security & Storage**
- **flutter_secure_storage**: Encrypted local storage
- **Refresh Token Pipeline**: Automatic token refresh mechanism

## Features

- Clean Architecture implementation
- Resilient API handling with retry mechanisms
- Type-safe navigation with go_router
- Secure token management
- Responsive UI with flutter_screenutil
- Comprehensive logging

## Tech Stack

| Category | Package | Purpose |
|----------|---------|---------|
| **State Management** | flutter_bloc | BLoC pattern implementation |
| **Dependency Injection** | get_it, injectable | Service locator and DI |
| **Networking** | dio, dio_smart_retry | HTTP client with retry logic |
| **Error Handling** | result_dart | Functional error handling |
| **Navigation** | go_router | Declarative routing |
| **Storage** | flutter_secure_storage | Encrypted local storage |
| **UI** | flutter_screenutil, pinput | Responsive UI and PIN input |
| **Utilities** | equatable, logger, collection | Helper utilities |

##  Getting Started

### Prerequisites

- Flutter 3.35.4
- Dart 3.9.2
- Cursor
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/aslanidis007/imove-challenge.git
cd imove-challenge
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

### Build Commands

**Debug Build:**
```bash
flutter run --debug
```


### Environment Setup
Create environment-specific configuration files for different build flavors.

### API Configuration
Configure base URLs and API endpoints in your environment files.

## Testing

1. **Client_test**
    - API clients and network functionality
2. **constants_test**
    - Application constants and configuration
3. **jwt_parser_test**
    - JWT token parsing and validation
4. **router_test**
    - Navigation and routing logic
5. **utils_test**
    - String extensions - build url logic


```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Development Guidelines

### Code Style
- Follow Dart/Flutter style guide
- Use meaningful variable and function names
- Implement proper error handling
- Write unit tests for business logic

### Architecture Principles
- Keep dependencies pointing inward
- Use dependency injection for testability
- Implement proper separation of concerns
- Follow SOLID principles