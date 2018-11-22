
# MATOMO updater

GPLv3 - see https://www.gnu.org/licenses/gpl-3.0.en.html

Use it on your own risk. If you like it then spread it :-)

---

## Description

This is a shell script I use at my web hoster to update the Matomo installation.
After a backup of the config it updates all matomo file and starts 
*console core:update* for database migrations.

The special thing is:

* my install directory is *[webroot]/piwik/* ... and not /matomo/
* At my hoster I have a few binaries. I must use unzip ... so extracting the zip


## Requirements

(1) You need an existing installation of Matomo.

(2) The script uses the following binaries that must exist in the PATH
* wget
* unzip
* rsync
* php


## Installation

* put the 2 bash files into a directory on your hoster
* copy the *inc-matomo-cfg.bash.dist* to *inc-matomo-cfg.bash* (without .dist)
* in the *inc-matomo-cfg.bash* set your webroot and target directory of matomo
* *chmod 0755 matomo-updater.bash*

## Usage

Run *./matomo-updater.bash* to start the update.
If a command  would fail, then it stops.

After an upgrade go to the Matomo web backend and verify the installation 
and remove unneeded files.