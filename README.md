# Tactical Fenix

Prototype tactical watch face for the Garmin Fenix 7X Pro (Connect IQ / Monkey C).

## Features
- 24-hour digital time
- English `SAT 21 NOV` date
- Battery percentage and icon
- Angular accent lines
- On-watch palette selection for time, date, battery and accents

## GitHub Actions builds
The workflow at `.github/workflows/build.yml` installs Java and the Connect IQ SDK, generates a launcher icon, compiles the watch face and uploads a `.prg` artifact **if compilation succeeds**. This source has not yet been verified against Garmin's compiler or simulator; check the Actions tab for errors.

Without a signing-key secret, the workflow generates a temporary test key each run. **For consistent updates on your watch**, set the repository Actions secret `GARMIN_DEVELOPER_KEY_BASE64` to the Base64 contents of your stable `developer_key.der`. Never commit your private key or paste it into an issue.

On Windows PowerShell, generate the secret text from your downloaded DER file:
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\\path\\to\\developer_key.der"))
```
Add the resulting text at repository Settings → Secrets and variables → Actions → New repository secret.

## Local build
Install the Garmin Connect IQ SDK, device definitions, and Monkey C extension:
```sh
monkeyc -f monkey.jungle -d fenix7xpro -o TacticalFenix.prg -y developer_key.der
```
The CI workflow creates the missing `resources/drawables/icon.png` dynamically; local builds must supply an 80×80 PNG there.

## Status
Uncompiled prototype; font sizing and on-device settings menu require validation on a Fenix 7X Pro.
