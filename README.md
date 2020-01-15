# docker-vscode-hack-osx

Work-Around and Discussion for this [issue](https://github.com/microsoft/vscode-remote-release/issues/24).

## Preamble

This repository was made to provide files and instructions for implementing the work-around for
VSCode Remote-SSH installation on OSX. Currently, an [issue](https://github.com/microsoft/vscode-remote-release/issues/24)
exists tracking an official solution.

Please keep all questions regarding this work-around here in this repository so that the official
issue is not clogged like a forum thread.

Please create an Issue here to ask your question.  Please check Closed Issues before asking your question.

## Instructions

### Remote Host

1. Install [Docker](https://hub.docker.com/?overlay=onboarding).
1. Open a **Terminal**

```bash
git clone https://github.com/jccurtis/docker-vscode-hack-osx.git vscode-server
cd vscode-server
# Setup envars for this container
source config/<fill-in-your-config>.sh
make build
make run
```

See `make help` for more options.

### Local Host

Within VSCode:

1. Click Remote Explorer
1. Click Settings
1. Edit .ssh/vscode.config

```bash
# vscode.config
Host vscode-server
    HostName <fill-in>
    User <fill-in>
    Port <fill-in>
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
```

## Caveats

### Backdoor

Do not be decieved, this is a *BACKDOOR* into your system.  This has not been vetted by a security team, nor
is intended to anything more than a "work-around".

* The directory you expose to docker is available for anyone who can figure out or crack your container's password.
* This exposes a default linux container which can run binaries on your remote machine as root.  You have been warned.

### Catalina Permissions

In the `docker run` statement above, I am mapping my home directory to `/opt` on the Remote Host.  This may or
may not be what you want, depending on your development environment.   If you map to `/opt`, upon first connection,
**Docker** will attempt to enumerate all directories and prompt you for access.  If you have mapped to your
home directory, Docker may prompt for additional permissions ("Documents", "Desktop", "Downloads", etc) on the
remote.

```bash
"Docker" would like to access files in your Documents folder.
                           [ Don't Allow ]         [ OK ]
```

If you click `[ Don't Allow ]`, you will not be able to remotely see files in that folder.
