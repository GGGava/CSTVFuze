# CSTVFuze


## Usage
Before running this project go to `"Edit Scheme" -> "Arguments" -> "Environment Variables"` and add a new key `PANDA_API_KEY`, then add your Panda Score API Key as the value.
Note that the environment variable will only be available when running the project through XCode. All network requests **will fail** if the app is opened without XCode. If you need to run the app without XCode, go to file `CSTVFuze/Matches/Data/Networking/Endpoints.swift` and hardcode your API Key in `line 41`.

No additional steps are required. No dependencies were added to this project.

## Details

This app was implemented in Swift and SwiftUI, with a non-strict MVVM architecture, and using the Repository pattern. 

### View Models and Repository
View Models are used in the main views of the app where interaction with repositories is required. The View Models depend on the repository interfaces, allowing them to work with different repository implementations. For this project, the repositories were implemented to interact with the Panda Score API.

### Views
Not all views contain a View Model. Some views do access Model structures, but only to retrieve the attributes needed for rendering. Views do not fetch or modify data and have no direct access to any repositories. This approach slightly relaxes a strict MVVM architecture for the sake of simplicity.

Regarding code organization, view components that are shared across multiple views are kept in the Components folder. Components used by a single view, but extracted into their own struct to improve code readability, are kept within their parent view's namespace, under an extension of the parent view. This approach helps avoid clutter when navigating files and makes it easier to edit the view, as you can use a single Preview. The only exception is MatchCardView, which is used only by MatchListView but is complex enough to require its own file and Preview.


### Model
All Model components were implemented mostly based on the Panda Score API. The biggest contributors for this decision were simplicity and avoiding over-engineering. An alternative approach could have been to decouple the Model from the Panda Score API by decoding the network requests into a "PandaScoreModel" and adapting it into a separate "Model" object, or even creating a fully abstract Model. While this could simplify the current structure slightly, it would introduce additional boilerplate and complexity. Therefore, the simpler solution was preferred.

### Third-party Code
No third-party libraries were added to this project, but two code blocks were taken from the internet:

- The file `CSTVFuze/DependencyInjection/InjectedValues.swift` provides a Dependency Injection helper method, eliminating the need to add an external library to the project. This method was chosen for its simplicity and readability. [Code Source](https://www.avanderlee.com/swift/dependency-injection/)
- The file `CSTVFuze/Matches/Components/CachedAsyncLogoView.swift` is used to cache image URLs for teams and players. The native AsyncImage does not support caching, which means each time an image is rendered, it must be fetched from the server, negatively affecting UX. By using a cached component, the responsiveness of both screens was significantly improved. [Code Source, adapted](https://medium.com/@jakir/enable-image-cache-in-asyncimage-swiftui-db4b9c34603f)

### Tests
Unit tests have been added for all View Models, Repositories, and components in the Network layer.

