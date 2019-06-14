# Tutorial

This is a crash-course tutorial to get started with Norns development.

## Connection

You need to get the [Norns](https://monome.org/norns/) online and **accessible to your WIFI network**.

- Add your router details to the device, in `WIFI > ADD`. 
- Once the device is online, the `IP` field will display the _DEVICE_IP_, example `192.168.128.109`.
- **To edit code(IDE)**, open [Maiden](http://norns.local/maiden/) by going `http://norns.local/` in your browser.
- **To transfer files(SFTP)**, open your [SFTP client](https://cyberduck.io/download/) and connect to the _DEVICE_IP_, username `we` and password `sleep`.
- **To install new projects(SSH)**, open a [new terminal window](https://www.youtube.com/watch?v=IGmfU6QU5dI), type `ssh we@192.168.128.109`, password `sleep`.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/wifi.png?raw=true' width='450'/>

You are now connected to the device, via the IDE, FTP and SSH. 

## Setup

In your **terminal window**, while being connected via **SSH**.

- Move into the folder where scripts are typically held with `cd dust/code`.
- Install this tutorial on your device with `git clone https://github.com/neauoire/tutorial.git`
- Move into the tutorial folder with `cd tutorial`.

You are now ready to use this tutorial. 

## Play

In your ..

## Creating a new project

To **create a new project**, I recommend that you first create a [new repository](https://github.com/new) instead of a simply creating a new folder to the device. This will allow you to share your project with others

