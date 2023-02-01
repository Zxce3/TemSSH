# TemSSH

This is a bash script for managing, displaying, and connecting to SSH configurations stored in a configuration file at `~/.config/temshh.conf`. The script provides a user-friendly interface to add, remove, and modify the configurations, as well as a list of available configurations and the ability to connect to the selected configuration.

## Requirements

- Bash
- SSH client

## Usage

1. Download the script and make it executable by running `chmod +x temssh.sh`
2. Run the script by executing `./temssh.sh`
3. Select one of the following options:

- `Configure SSH`: prompts the user to enter a server name, host name, port number, and username, then saves the configuration to the file.
- `Show Configuration`: displays a list of available SSH configurations.
- `Connect to SSH`: shows a list of available servers and prompts the user to select one, then connects to the selected server using the saved configuration.
- `Remove Server`: shows a list of available servers and prompts the user to select one, then removes the selected configuration from the file.
- `Exit`: terminates the script.

## Config file format

The configuration file is a simple bash script that declares an associative array `SSH_CONFIGS` with server names as keys and SSH connection strings as values. The format of the connection string is `<username>@<hostname> -p <port number>`.

## Example Configuration

```perl
declare -A SSH_CONFIGS
SSH_CONFIGS["server1"]="user1@192.168.1.1 -p 22"
SSH_CONFIGS["server2"]="user2@192.168.1.2 -p 22"
SSH_CONFIGS["server3"]="user3@192.168.1.3 -p 2222"
```

## License

This program is licensed under the [GNU General Public License version 2](LICENSE).
