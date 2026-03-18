# 🎯 BucketList

> *"Let's make memories that last forever."*

***
> **⚠️ Under Active Development:** Please note that this application is currently in active development. Features are subject to change, and the data schema may update frequently. Bugs are expected—use at your own discretion.
***

BucketList is a modern iOS application built entirely with SwiftUI that helps users discover, track, and achieve their life goals. 

The app features a seamless, frictionless onboarding experience driven by automatic anonymous authentication. This allows users to dive straight into the app's core features immediately, with the option to securely upgrade and link their account later using Sign in with Apple. 

## 📋 Table of Contents
* [Features](#-features)
* [Tech Stack](#-tech-stack)
* [Architecture Overview](#-architecture-overview)
* [Project Structure](#-project-structure-overview)
* [Getting Started](#-getting-started)
* [Previews & Testing](#-previews--testing)
* [License](#-license)

## ✨ Features

* **Frictionless Onboarding**: Users are instantly authenticated anonymously upon first launch, removing all barriers to entry so they can start adding goals immediately.
* **Apple Authentication**: Seamlessly upgrade anonymous accounts to permanent, secure accounts using Sign in with Apple.
* **Real-Time Data Sync**: Listens to user data changes remotely and automatically caches the current user state locally using the file system, ensuring offline availability.
* **Explore & Discover**: Browse new goals and find inspiration in the dedicated *Explore* tab.
* **Goal Tracking**: Easily add, edit, and manage your personal milestones using the *Add Goal* tab.
* **Beautiful UI/UX**: Built entirely in SwiftUI, featuring staggered, cascading spring animations, and fluid view transitions that make navigating the app a joy.

## 🛠 Tech Stack

* **Platform:** iOS 17.0+
* **Language:** Swift 5.10+
* **UI Framework:** SwiftUI
* **Concurrency:** Modern Swift Concurrency (`async/await`, `Task`, `AsyncStream` for real-time remote listeners)
* **State Management:** Swift's native `@Observable` macro and deep environment injection.
* **Architecture:** Manager/Service Pattern utilizing Dependency Inversion for modularity, easy mocking, and testing.

## 🏗 Architecture Overview

The app's business logic is cleanly separated into specialized managers and services, injected directly into the SwiftUI environment for seamless data flow:

* **`AppView` & `AppState`**: The root of the application. It acts as the orchestrator, listening to the user's login state and coordinating smooth, animated transitions between the `WelcomeView` (onboarding) and the main `TabbarView`.
* **`AuthManager`**: Handles user authentication states. It interfaces with an `AuthService` protocol to process Anonymous and Apple sign-ins. This protocol-oriented approach makes it trivial to swap out the underlying backend provider (e.g., switching from Firebase Auth to Supabase) or inject mock services.
* **`UserManager`**: Responsible for the `UserModel`. It handles streaming remote user updates via a `RemoteUserService` and safely persisting data offline via a `LocalUserService`.

## 🗂 Project Structure Overview
*(A brief look at how the code is organized)*
* **`/App`**: Contains `AppView`, `AppState`, and entry point logic.
* **`/Views`**: SwiftUI views organized by feature (`/Explore`, `/Goals`, `/Onboarding`).
* **`/Managers`**: `AuthManager`, `UserManager`.
* **`/Services`**: Contains protocols and their concrete implementations (`AuthService`, `RemoteUserService`).
* **`/Mocks`**: Mock implementations of services used specifically for SwiftUI Previews and Unit Tests.

## 🚀 Getting Started

### Prerequisites

* Xcode 15.0 or later
* iOS 17.0+ Simulator or physical Device

### Installation

1. Clone the repository to your local machine:
```bash
git clone [https://github.com/k1rank94/BucketList.git](https://github.com/k1rank94/BucketList.git)
