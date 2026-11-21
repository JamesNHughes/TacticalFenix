# Tactical Fenix
Custom tactical watch face for Garmin Fenix 7X Pro.

Features: 24-hour time, English DAY DD MON date, battery icon/percentage, angular accent lines, and four independent colour settings.

**Status: uncompiled prototype.** Source has not been tested with Garmin's SDK. The GitHub Actions workflow is a scaffold and intentionally fails until an SDK installation method is validated; it does not yet produce a PRG. A Garmin developer signing key must be supplied securely.

Build locally with Garmin Connect IQ SDK and Monkey C VS Code extension. Example:
```
monkeyc -f monkey.jungle -d fenix7xpro -o TacticalFenix.prg -y developer_key.der
```
Never commit your developer signing key. The `GARMIN_DEVELOPER_KEY_BASE64` secret is reserved for the eventual automated build.
