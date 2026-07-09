# Bypass Chrome Gemini (Glic) Geo-Restriction

[עברית (Hebrew)](README.he.md)

A step-by-step guide to force-enable the new built-in Gemini AI features (Glic Side Panel) in Google Chrome for unsupported regions (like Israel), without requiring an active VPN connection.

⚠️ **Disclaimer:** 
The author has not run or manually tested any of the automation scripts included in this Gist. All scripts and implementation steps were fully generated using AI. Use them at your own risk.

---

## Prerequisites
* **Google Chrome** (v149+ recommended, desktop versions for Windows, macOS, or Linux).
* A text editor (Notepad, VS Code, TextEdit) or terminal access.

## Step 1: Change Browser Language
The built-in AI features currently require your primary browser language to be set to US English.

1. Navigate to: `chrome://settings/languages`
2. Under **Preferred languages**, click **Add languages** and add **English (United States)** if it is not already present.
3. Click the three vertical dots next to *English (United States)* and check the box for **Display Google Chrome in this language**.
4. Click the **Relaunch** button.

---

## Step 2: Enable Glic Flags
1. Navigate to: `chrome://flags`
2. In the top search bar, type `Glic`.
3. Change the following flags from **Default** to **Enabled**:
   * `#glic` (Main engine)
   * `#glic-horizontal-tab-toolbar-button` (Adds the Gemini icon to your top toolbar)
4. Click **Relaunch** at the bottom of the page, then **fully close Chrome** (ensure no zombie chrome.exe tasks remain in your background processes).

---

## Step 3: Modify `Local State` Configuration
Chrome evaluates your geographical eligibility on initialization. You can manually override this parameters block locally.

### Option A: Manual Configuration (Recommended)
1. Ensure Chrome is completely closed.
2. Open your operating system's file explorer and find the `Local State` file (note: this file has no extension):
   * **Windows:** Press `Win + R`, paste `%LOCALAPPDATA%\Google\Chrome\User Data` and press Enter.
   * **macOS:** Press `Cmd + Shift + G` in Finder, paste `~/Library/Application Support/Google/Chrome/` and press Enter.
3. Open the `Local State` file using a standard text editor.
4. Search for your regional country code (`"IL"`) and replace **all 3 instances** with `"US"`.
   * Pay close attention to updating fields like `"variations_country"` and `"variations_permanent_consistency_country"`.
5. Save and close the file.

### Option B: Automated Script Execution
* **Windows Users:** Review and run the attached `patch-local-state.ps1` PowerShell script.
* **macOS / Linux Users:** Review and run the attached `launch-chrome-override.sh` bash script.

Launch Chrome. The native Gemini star icon will now display prominently on your upper horizontal toolbar.

> **Note on Persistence:** Chrome may overwrite this local state config file during browser version upgrades or profile cloud sync cycles. If the feature unexpectedly vanishes, re-run Option A or Option B.