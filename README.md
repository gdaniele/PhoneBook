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
For a larger app, i'd try to modularize different abstractions via SPM packages for faster builds, better boundaries between abstractions, and potentailly code sharing down the line.

I'd implenent a coordinator pattern for navigation so the view layer doesn't have components that are coupled to other view components.

I'd implement SwiftData or CoreData for querying the data model (assuming it gets more complex than S3-hosted JSON).

### Where I'd go from here: testing
I wrote tests for `CachingUserRepository` while doing TDD as one of the first classes implemented.

I'd write more tests for:
- `UserListVieController`, specifically testing the state machine
- `HTTPAPIClient`, with a stub protocol, to test how this component responds to the (oh so many) potential HTTP status codes

### Pagination
- Switch to offset based pagination (versus cursor, which is best for algorithmic feeds e.g.)
- ViewModel accumulates pages, triggers the next fetch based on UIKit callbacks when the scrolling is in the bottom 1/4 pagefuls (or some similar hueristic)
- Potentially we'd cache one page at a time

### Authentication
- Store token in Keychain securely
- Implement Authorization: Bearer HTTP authentication on server and client
- On HTTP Unauthorized callbacks, reauthenticate visually to user

## Resilience
- Retry w/ exponential backoff for .timedOut and .networkConnectionLost URLErrors
- Don't error on HTTP request failure if there's data in cache
- E-Tags to efficiently check for updates without firing network controller on device (battery!)

### Tradeoffs I made in this 4-6 hours

*Codable + FileManager vs Core Data* - Overkill, no need to query data. JSON contact list is fine to store on disk.

*No pagination vs page / cursor pagination * - Overkill, there's 100 static elements here
*No "coordinator" layer* - We're coupling some view logic (e.g. concrete `UserDetailViewController` to `UserListViewController`), but there are literally only 2 screen in this 4-hour app :)

*Simple dependency injection vs Swinject* - Similar to above, if we build this out, we'd want to use a DI framework at some point when the depedencies get complicated or are dependent on business logic. 

*No service layer* - Overkill, there's no busines logic between the view layer and the CRUD layer at this point.