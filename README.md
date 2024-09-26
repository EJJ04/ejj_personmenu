# ejj_personmenu

A personal menu resource for FiveM that provides players with access to their money data and society account details.

## Installation

1. **Download the Resource**:
   Clone or download the repository to your `resources` directory.

   ```bash
   git clone https://github.com/EJJ04/ejj_personmenu
   ```

2. **Add to server.cfg**: Ensure the resource is started by adding it to your `server.cfg`:

   ```
   start ejj_personmenu
   ```

3. **Locale Files**: Update or add locale files for your desired languages in the `locales` directory (e.g., `en.json`, `da.json`).

## Features

- Access to player's cash, bank balance, and black money.
- Society account details for bosses.
- Customizable notification positions.

## Usage

Once installed, players can access their personal menu to view their cash, bank balance, black money, and society account details. The menu is accessible via the radial menu.

## Configuration

You can customize the menu options and notification settings by editing the `Config.lua` file. 

### Menu Options

- **cash**: Title and icon for cash display.
- **bank**: Title and icon for bank display, set as read-only.
- **black_money**: Title and icon for black money display, set as read-only.
- **societyAccount**: Title and icon for society account, accessible to bosses only.

### Notification Settings

You can set the position for notifications using the following options:
- `top`
- `top-right`
- `top-left`
- `bottom`
- `bottom-right`
- `bottom-left`
- `center-right`
- `center-left`

## Locale Support

The resource includes support for multiple languages. You can find and edit locale files in the `locales` directory. The default locale files are:
- `en.json` for English
- `da.json` for Danish

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit issues or pull requests. Contributions are welcome!