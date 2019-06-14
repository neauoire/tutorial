# Tutorial

This is a crash-course tutorial to get started with Norns development.

## Connection

You need to get the [Norns](https://monome.org/norns/) online and **accessible to your WIFI network**.

- Add your router details to the device, in `WIFI > ADD`. 
- Once the device is online, the `IP` field will display the _DEVICE_IP_, example `192.168.128.109`.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/0_wifi.png?raw=true' width='450'/>

- **To edit code(IDE)**, open [Maiden](http://norns.local/maiden/) by going `http://norns.local/` in your browser.
- **To transfer files(SFTP)**, open your [SFTP client](https://cyberduck.io/download/) and connect to the _DEVICE_IP_, username `we` and password `sleep`.
- **To install new projects(SSH)**, open a [new terminal window](https://www.youtube.com/watch?v=IGmfU6QU5dI), type `ssh we@192.168.128.109`, password `sleep`.

You are now connected to the device, via the IDE, FTP and SSH. 

## Setup

In your **terminal window**, while being connected via **SSH**.

- **Move into the code folder** where scripts are typically held with `cd dust/code`.
- **Install this tutorial** on your device with `git clone https://github.com/neauoire/tutorial.git`
- **Move into the tutorial folder** with `cd tutorial`.

You are now ready to use this tutorial. 

## Play

In [Maiden](http://norns.local/maiden/), reload the window to make sure the tutorial files are visible, and look at the [first example file](1_blank.md) of this tutorial.

- **Navigate to the first example** with `code > tutorial > 1_blank.lua`.
- **Send it to the device** by clicking on the play button to the top right of the Maiden window.
- **Look at the blank screen**, there is nothing to see.
- **Look at the logs**, at the bottom of the browser window in the console, it should display `init` and `redraw`.

You have run your first Norns script, from Github, via Maiden.

## Interface

In [Maiden](http://norns.local/maiden/), look at the [second example file](2_interface.md) of this tutorial.

- **Navigate to the second example** with `code > tutorial > 2_interface.lua`.
- **Send it to the device** by clicking on the play button to the top right of the Maiden window.
- **Look at the screen**, notice the basic lines being drawn.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/2_interface.png?raw=true' width='450'/>

The interface is draw by a combination of methods from the [screen object](https://monome.github.io/norns/doc/modules/screen.html). The screen always must be cleared, and updated between changes. 

```
screen.clear()
screen.move(10,10)
screen.line(30,30)
screen.update()
```

## Interaction

In [Maiden](http://norns.local/maiden/), look at the [third example file](3_interaction.md) of this tutorial.

- **Navigate to the second example** with `code > tutorial > 3_interface.lua`.
- **Send it to the device** by clicking on the play button to the top right of the Maiden window.
- **Move the crosshair** by turning the two knobs to the right of the device.
- **Look at the screen**, notice the crosshair moving.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/3_interaction.png?raw=true' width='450'/>

The interactions are triggering the `key(id,state)` and `enc(id,delta)` functions, remember to `redraw` the interface after an interaction. The key state is a value of either `1`(key_down), or `0`(key_ip). The knobs delta is a value of either `-1`(counter_clockwise), or `1`(clockwise).

```
function key(id,state)
  print('key',id,state)
end

function enc(id,delta)
  print('enc',id,delta)
end
```

## Creating a new project

To **create a new project**, I recommend that you first create a [new repository](https://github.com/new) instead of a simply creating a new folder to the device. This will allow you to share your project with others

