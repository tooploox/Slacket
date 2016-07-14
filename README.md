## In order to build follow these steps:

1) Install `swiftenv`. [https://github.com/kylef/swiftenv](https://github.com/kylef/swiftenv)
Make sure you have performed both installation steps.

1) Clone the repo recursively `git clone -b development --recursive https://github.com/jtomanik/Slacket.git`

2) Make sure you have the correct version (`DEVELOPMENT-SNAPSHOT-2016-05-31-a`) of swift installed. If not, in terminal run:

```
swiftenv install DEVELOPMENT-SNAPSHOT-2016-05-31-a
```

3) Run `make` command.

4) To run the app execute `.build/debug/Slacket`

### Generating Xcode project (Tested on Xcode 7.3.1)

1) After running `make` command, run `swift package generate-xcodeproj`

2) In project settings, find targets for `Kitura`, `KituraNet`, `Slacket` and set `Library Search Paths` for each one of them to:

```
$(SRCROOT)/.build/debug
```

### Running

You will be able to run the application without slack & pocket token, but for proper execution you will need to add two environment variables with their values. Write a .sh script:

```
export SLACK_TOKEN=(YOUR TOKEN HERE)
export POCKET_CONSUMER_KEY=(YOUR KEY HERE)
```

Run it using `source`:

```
source ./slacket_setenv.sh
```

### Testing

You will find test scripts in `Tests` folder, which will be pretty much everything you can do with Slacket locally :)

### Useful commands

* `make clean` to clean build folder
* `make refetch` to clean and refetch dependencies
* Remove and add `Sources/Slacket` group to properly generate subgroups
