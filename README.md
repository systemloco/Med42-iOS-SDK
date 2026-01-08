# Med42SDK

Closed-source iOS SDK distributed as a binary Swift Package.

---

## Requirements

- iOS 14+
- Xcode 15+
- Swift Package Manager

---

## Installation

### 1. Configure JFrog authentication

The SDK binary is hosted on JFrog Artifactory.  
Swift Package Manager requires credentials to download it.

Create or update `~/.netrc`:

```
machine systemloco.jfrog.io  
login <USERNAME>  
password <ACCESS_TOKEN>  
```
Then secure the file:

chmod 600 ~/.netrc

> Use a JFrog **Access Token** (recommended), not a password.

---

### 2. Add the package

In Xcode:

1. Open your app project
2. **File → Add Packages**
3. Enter the repository URL:  
   https://github.com/systemloco/Med42-iOS-SDK
4. Select **Med42SDK**
5. Add it to your app target

---

## Usage

```swift
import Med42
```

Example:

```swift
Med42.shared.configure(
    apiKey: "<API_KEY>",
    clientId: "<CLIENT_ID>"
)
```

---

## Example App

This repository includes a minimal **example iOS app** demonstrating basic SDK integration.

To try it out:

1. Open the repository in Xcode
2. Select the **Med42SDKExample** scheme
3. Build and run on a simulator or device

The example is intended for reference and local testing only and is not required for SDK integration.

---

## Updating

The SDK is versioned.  
To update, select a newer version in Xcode under **Package Dependencies**.

---

## Troubleshooting

### `No such module 'Med42SDK'`

- Ensure the package product is added to your app target
- Clean the build folder (`Cmd + Shift + K`) and rebuild

### Binary download fails

- Verify `.netrc` credentials
- Confirm access token permissions
- Check that the package URL is correct

---

## Support

For access issues or integration questions, contact support@systemloco.com
