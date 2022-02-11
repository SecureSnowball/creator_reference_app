# test_app

Folder Structure
- lib/config: Contains constants or variable loaded from .env file.
- lib/exceptions: Exceptions like validation exception with error data for easy handling in UI.
- lib/interfaces: Request, response and state (very less chances) interfaces and json serialization support.
- lib/models: Models contains structure of a model and methods for json serialization.
- lib/pages: Pages are displayed in UI like login, register, etc.
- lib/services: Services are responsible for dealing with API, business logic is in services.
- lib/state: State is used for storing data in memory.

- test: Unit test, manually written for testing complex widgets.
- integration_test: Full app test for testing app as a single entity.

#### Notes
- Auth stuff is always kept in auth folder.
- Only `store` and `config` folder names are singular, everything else is plural.
- Integration test can be time confusing for large apps so ensure you have a sensible pipeline for testing stability.
- You can avoid writing `interfaces` if your *backend is a mess*. Most backends with good architecture would work better with interfaces and exceptions for more stability and predictions.
- auth service, http service and sharePreferences services are not related to any resource.

#### TOOD
- `dashboard` and `homepage` views needs implementation since they are app specific

#### How everything works
- Provider is used state management.
- All static routes are registered as named routess.
- View uses provider for data and service for API calls.
- Only services deal with `Map` to ensure everything else is type safe and uses interfaces or models.
- Everything that can generate `Map` have a `toJson` method.
- Everything that can be generated from json have a static `fromJson` method.