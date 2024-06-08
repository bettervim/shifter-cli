# Shifter CLI

Shifter CLI is an attempt to create a CLI tool that configures the tmux UI. This project leverages ReScript and various npm packages to provide a customizable and user-friendly interface for tmux configuration.

## Installation

To install the necessary dependencies, navigate to the project directory and run:

```sh
npm install
```

## Running ReScript

To compile the ReScript code, use the following npm script:

```sh
npm run rs:dev
```

This script will compile the `.res` files in the `src` directory and generate corresponding JavaScript files.

## Running the CLI

To run the Shifter CLI, use the following command:

```sh
npm run dev
```

This command will execute the main entry point of the CLI and provide you with optio

## Project Structure

- `src/`
  - `Main.res`: The main entry point of the CLI.
  - `bindings/`: Contains bindings for various npm packages used in the project.
  - `commands/`: Contains the implementation of various CLI commands related to tmux customization.
  - `components/`: Contains reusable components used in the CLI interface.
  - `shared/`: Contains shared utilities and helper functions used across the project.

## Contribution

If you would like to contribute to this project, please fork the repository, create a new branch, and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
