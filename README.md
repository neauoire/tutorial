# Tutorial

This is a crash-course tutorial to get started with Norns development.

## Connection

You need to get the Norns **online and accessible to the network**.

- Add your router details to the device, in `WIFI > ADD`. 
- Once the device is online, the `IP` field will display the _DEVICE_IP_, example `192.168.128.109`.
- **IDE**, open [Maiden](http://norns.local/maiden/) — to edit code.
- **FTP**, open your [SFTP client](https://cyberduck.io/download/), connect to the _DEVICE_IP_, username `we` and password `sleep` — to transfer files.
- **SSH**, Open a [new terminal window](https://www.youtube.com/watch?v=IGmfU6QU5dI), type `ssh we@192.168.128.109`, password `sleep` — to install new projects.

Well, done. You are now connected to the device. 

## Setup

In your **terminal window**, while being connected via **SSH**, type `cd dust/code` to move into the folder where scripts are typically held, and then `git clone https://github.com/neauoire/tutorial.git` to install this tutorial on your device, and then `cd tutorial` to move into the tutorial folder. 

## Play

In your ..

## Creating a new project

To **create a new project**, I recommend that you first create a [new repository](https://github.com/new) instead of a simply creating a new folder to the device. This will allow you to share your project with others

