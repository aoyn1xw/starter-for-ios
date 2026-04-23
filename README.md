# iOS Starter Kit with Appwrite

Kickstart your iOS development with this ready-to-use starter project integrated with [Appwrite](https://appwrite.io). 

This guide will help you quickly set up, customize, and build your iOS app.

---

## 🚀 Getting Started

### Clone the Project
Clone this repository to your local machine using Git or directly from `Xcode`:

```bash
git clone https://github.com/appwrite/starter-for-ios
```

Alternatively, open the repository URL in `Xcode` to clone it directly.

---

## 🛠️ Development Guide

1. **Configure Appwrite**  
Navigate to `Sources/Config.plist` and update the values to match your Appwrite project credentials.  

2. **Customize as Needed**  
Modify the starter kit to suit your app's requirements. Adjust UI, features, or backend integrations as per your needs.  

3. **Run the App**  
Select a target device (simulator or connected physical iOS device) in `Xcode`, and click **Run** to start the app.  

---

## 📦 Building for Production

To create a production build of your app:

1. Open **Products** > **Schemes** in the menu bar.
2. Choose **Edit Scheme** or **New Scheme** to define your build settings.
   - For a new scheme, fill in the required information.
3. Go to **Run** > **Build Configuration** and select **Release**.
4. Build and deploy your app in release mode.

### GitHub Actions IPA build

This repository includes a CI workflow at `.github/workflows/build-ipa.yml` that builds an iOS archive and publishes an `.ipa` as a workflow artifact (`AppwriteStarterKit-ipa`) on every push to `main`, pull request, or manual dispatch.

### OTA install from GitHub Releases

If you want the app to install through `itms-services`, add the signed release workflow at `.github/workflows/release-ota.yml`. It builds a signed `.ipa`, generates a matching `.plist` manifest, and uploads both files to the same GitHub Release.

Add these repository secrets before running the release workflow:

- `IOS_CERT_P12_BASE64`
- `IOS_CERT_P12_PASSWORD`
- `IOS_PROVISIONING_PROFILE_BASE64`

Store the `.p12` and `.mobileprovision` contents as base64-encoded values in those secrets, and set the password secret to your certificate password.

The workflow uses the release tag to build a direct asset URL like:

`https://github.com/OWNER/REPO/releases/download/v1.0/AppwriteStarterKit.ipa`

The manifest URL then becomes:

`itms-services://?action=download-manifest&url=https://github.com/OWNER/REPO/releases/download/v1.0/AppwriteStarterKit.plist`

If you want to host the manifest in a separate dedicated repository, copy the same workflow there and point the manifest link at that repo's release asset URL.

---

## 💡 Additional Notes

- This starter project is designed to streamline your iOS development with Appwrite. 
- Refer to the [Appwrite Documentation](https://appwrite.io/docs) for detailed integration guidance.

