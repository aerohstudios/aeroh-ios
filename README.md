# Aeroh iOS App

## Development Setup

1. Get the [aeroh-cloud](https://github.com/aerohstudios/aeroh-cloud) rails application up and running at http://localhost:3000
2. Create a new Doorkeeper Application by accessing [http://localhost:3000/oauth/applications](http://localhost:3000/oauth/applications). This will provide you with `client_id` and `client_secret`. Make sure you are an admin user.
3. Update `AerohLink/Constant/AppConstants.swift` with relevant values.
4. Copy `AerohLink/Constant/EnvConstants.swift.template` to `AerohLink/Constant/EnvConstants.swift`, and update it with relavant values.
5. This project uses [SwiftLint](https://github.com/realm/SwiftLint) in the build pipeline to ensure that the swift code complies with a consistent coding standard. Install `swiftlint` using `brew install swiftlint`, as that's a dependency for building this project.
