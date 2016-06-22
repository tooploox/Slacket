## In order to build follow these steps:

Tested on Xcode 7.3.1

1) Make sure you have `swiftenv` installed. [https://github.com/kylef/swiftenv](https://github.com/kylef/swiftenv)

2) make sure you have correct version (`DEVELOPMENT-SNAPSHOT-2016-05-31-a`) of swift installed.
If not in terminal runn following command:

```
swiftenv install DEVELOPMENT-SNAPSHOT-2016-05-31-a
```

3) Run `make` command.

4) to run app execute `.build/debug/Slacket`

### Generating Xcode project
After running `make` command, run `swift package generate-xcodeproj`

### Usefull commands
* `make clean` to clean build folder
* `make refetch` to clean and refetch dependencies