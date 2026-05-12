# Phonebook App

## Where to start
- Open `Phonebook.xcodeproj` in XCode 26 to build and run
- To run implemented unit tests, see class `CachingUserRepositoryTests`

## Architecture Overview
**Phonebook** implements lightweight version of tried and true enterprise-tested architecture and SOLID object oriented programming principles.

The key patterns: MVVM, protocol-oriented programming, separation of concerns, repository pattern.

MVVM + Repository

**View** - renders ViewModel state, user intent
**ViewModel** - owns view state (i.e. State enum), coordinates loading
**Repository** - composes `APIClient` + `CachingUserRepository` for CRUD on `User`
**APIClient** - `APIClient` protocol, `HTTPAPIClient` uses `URLSession` async API to fetch the S3 phonebok resource
**Cache** - `UserCache` protocol, `FileUserCache` persists JSON to `Caches/` directory on device for offline loading

### Decisionmaking process
I considered several approaches from my years of experience working in both greenfield iOS apps and legacy codebases serving tens of millions of users.

First, I weighed heavily that architectures like MVVM, dependency injection, and protocol-oriented programming are well-known to most mobile developers in 2026, which was a strong consideration for a maintainable codebase.

Second, I thought about SOLID design principles (e.g. separation of concerns between `APIUser` and `User`, dependency inversion where classes don't depend on class concretion), and Service/Repository pattern to hold abstractions for data fetching + persistence concerns (repo) and business logic (service). These patterns are mockable, testable, predictable, and tested at scale. 

Finally, I came up with an architecture that was appropriate for the scope of this problem (i.e. an afternoon), taking care not to create an abstraction (e.g. `UserService`, decided against incorporating into codebase) where the benefits outweigh the costs.

The final solution contains protocols at every boundary, mockable for tests and swappable in prod, just like I'd do for a codebase with the possibility of geting larger and more complex (engineering complexity, new team members, etc).

The repository hides the first cache, then poll S3 logic from the view layer.

All the wiring for dependencies happens in `AppDepedencies`, simple, discoverable. Too small + too little time for a DI framework like Swinject.


## Discussion items
### Where I'd go from here: larger app
### Where I'd go from here: testing
### Pagination
### Authentication
### Pagination
### Tradeoffs I made in this 4-6 hours

*Codable + FileManager vs Core Data*
*No pagination vs page / cursor pagination *
*No "coordinator" layer vs [COORDINATOR framework]*
*Simple dependency injection vs Swinject*
*UIKit vs SwiftUI*
*No service layer*