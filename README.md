# Minishell

Minishell is a simplified Unix shell written in C as part of the 1337/42 School curriculum.  
It supports basic command execution, built-ins, pipes, redirections, and environment variable expansion.  
The goal is to understand how a shell works under the hood and implement core Unix principles from scratch.

## Features

- Execute simple and piped commands
- Built-in commands: `cd`, `echo`, `pwd`, `env`, `exit`, `export`, `unset`
- Input/output redirection: `>`, `>>`, `<`
- Quoting support (`'single'` and `"double"`)
- Environment variable parsing (`$VAR`)
- Signal handling (e.g., `Ctrl+C`, `Ctrl+\`)
- Exit codes and error handling

## Build Instructions

### Install Dependencies

1. Linux

```bash
sudo apt update
sudo apt install build-essential libreadline-dev
```

2. MacOs

```bash
brew install readline
```

### Build

```bash

# Clone the repository
git clone https://github.com/AmineMaila/mini-shell.git
cd mini-shell

# Build the project
make
```

## Usage

```bash
./minishell
```

## Liciense

This project is licensed under the MIT License - see the [LICENSE](https://github.com/AmineMaila/mini-shell/blob/master/LICENSE) file for details

## 🧑‍💻 Contributors

[nazouz](github.com/xezzuz)

