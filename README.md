# bupper

![bupper badge](https://badge.fury.io/py/bupper.png)

![travis badge](https://travis-ci.org/michaelpb/bupper.png?branch=master)

Simple backup application which allows per-directory backup control by simply
including a `_BACKUP_THIS` file.

## How it works

Bupper is very simple: it will recurse through a given directory, looking for a
special file indicating that it should be backedup (`_BACKUP_THIS`), and then
it will put that directory into a `.tar.gz` archive, named after the directory
and the current time, and `scp` it to a given location.

This has few moving parts and works well for a simple household-backup
solution, where "whitelisting" a few important directories in your home for
backup via transfer to a local network host makes the most sense.

## Installation

Assuming Python's `pip` is installed (for Debian-based systems, this can be
installed with `sudo apt-get install python-pip`), bupper can be installed
directly from PyPI:

```
pip install bupper
```

Python versions 3.3+ (and 2.6+) are supported and tested against.

## Quick start

1. Think about how you will configure bupper. The main thing you will want to
configure is the `--remote` flag, which should be remote host and path, or some sort
of external storage, that would allow an SSH login:
```
bupper \
    --source '/home/'\
    --remote 'backupuser@remote.host:/var/backups/bupper/'
```

2. **Note:** that 'source' does not actually back EVERYTHING up in that
directory. Instead, it will recursively look for directories that contain a
certain filename (`_BACKUP_THIS`).


3. Setup `bupper` with your chosen configuration to run on
[cron](https://askubuntu.com/questions/2368/how-do-i-set-up-a-cron-job) at a
regular time (such as daily).


4. (Optional) Add cron jobs that clean up old backups -- this is up to you how
you want to do this.

# Full usage

```
usage: bupper [-h] [-d DATE_FORMAT] [-v] [-s SOURCE] [-l LOCAL] [-r REMOTE]

Simple backup script, no diffing or anything fancy.

optional arguments:
  -h, --help            show this help message and exit
  -d DATE_FORMAT, --date-format DATE_FORMAT
                        date format in strftime
  -v, --verbose         increase output verbosity
  -s SOURCE, --source SOURCE
                        source directory to scan for bupper configs
  -l LOCAL, --local LOCAL
                        local storage of backups
  -r REMOTE, --remote REMOTE
                        remote storage of backups
```

# Contributing

New features, tests, and bug fixes are welcome!
