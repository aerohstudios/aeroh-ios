# Aeroh iOS App

## Development Setup

1. Get the [aeroh-cloud](https://github.com/aerohstudios/aeroh-cloud) rails application up and running at http://localhost:3000
2. Create a new Doorkeeper Application by accessing [http://localhost:3000/oauth/applications](http://localhost:3000/oauth/applications). This will provide you with `client_id` and `client_secret`. Make sure you are an admin user.
3. Update `Aeroh Link/Constant/AppConstants.swift` with relevant values.
4. Copy `Aeroh Link/Constant/EnvConstants.swift.template` to `Aeroh Link/Constant/EnvConstants.swift`, and update it with relavant values. 

