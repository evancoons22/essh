# Easy SSH (essh)

Easy SSH (essh) is a Bash script that simplifies ssh connections. 
It provides an interactive interface to select servers and users from a configuration file.

## Prerequisites

Ensure you have the following installed:
- Bash (4.0 or later)
- jq (command-line JSON processor)
- fzf (command-line fuzzy finder)
- SSH client

## Installation

1. Clone the repository or download the `essh.sh` script and `servers.json` configuration file.

2. go into directory.
    ```
    cd essh
    ```

2. Make the script executable:
   ```
   chmod +x essh.sh
   ```

3. Create a symbolic link to the script in your local bin directory:
   ```
   ln -s "$(pwd)/essh.sh" ~/.local/bin/essh
   ```

   If this folder does not exist: 
   ``` 
   mkdir ~/.local/bin/essh
   ```

   Make sure `~/.local/bin` is in your PATH. If it's not, add the following line to your `~/.bashrc` or `~/.bash_profile` or `~/.zshrc` file:
   ```
   export PATH="$HOME/.local/bin:$PATH"
   ```

## MacOS compatibility
Bash version 4.0 or later is required, which mac does not have by default. The easiest way to address this is to install bash and edit the script. 
   1. Install: 
      ```
      brew install bash
      ```
   2. Change the first line of `essh.sh`.
      For apple chips:
      ``` 
      #!/opt/homebrew/bin/bash 
      ``` 

      For intel chips:
      ``` 
      #!/usr/local/bin/bash
      ``` 

## Configuration

1. Edit the `servers.json` file to add your server details:
   ```json
   {
     "servers": [
       {
         "name": "server1",
         "address": "192.168.1.10",
         "users": ["admin", "user1"]
       },
       {
         "name": "server2",
         "address": "192.168.1.11",
         "users": ["root", "user2"]
       },
       {
         "name": "server3",
         "address": "192.168.1.12",
         "users": ["user3", "user4"]
       }
     ]
   }
   ```

2. Ensure the `servers.json` file is in the same directory as the `essh.sh` script.

## Usage

1. Open a terminal and run:
   ```
   essh
   ```

2. Use the interactive interface to select a server and a user:
   - Navigate through the options using Ctrl-j (down) and Ctrl-k (up)
   - Press Enter to make a selection

3. The script will then initiate an SSH connection to the selected server with the chosen user.

## Troubleshooting

- If you encounter a "Command not found" error, make sure the symbolic link is correctly set up and the directory is in your PATH.
- If the script can't find the configuration file, ensure `servers.json` is in the same directory as the script.

