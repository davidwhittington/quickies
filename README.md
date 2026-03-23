# quickies

A collection of quick scripts, small apps, and reference docs. Things that are useful but too small to deserve their own repo.

## Status

Active — growing as needed.

## Structure

```
quickies/
├── scripts/    Quick single-purpose scripts (bash, python, etc.)
├── apps/       More elaborate tools and mini-applications
└── docs/       Documentation, references, and notes
```

## Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `export_apple_contacts.applescript` | Export Apple Contacts to CSV (first name, last name, phone, email) | `osascript scripts/export_apple_contacts.applescript` |
| `fortigate-bbedit/` | BBEdit codeless language module for FortiGate/FortiOS config files (syntax highlighting, keywords, function nav) | `cp scripts/fortigate-bbedit/FortiGate.plist ~/Library/Application\ Support/BBEdit/Language\ Modules/` |

## Apps

| App | Description | How to run |
|-----|-------------|------------|
| _(none yet)_ | | |

## How to use

Browse by directory. Each script or app has a comment header explaining what it does and how to run it. Everything added here is also listed in the tables above.

## License

MIT
