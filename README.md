# Tutorial

This is a crash-course tutorial to get started with the sound computer [Norns](https://monome.org/norns/), follow the discussion [here](https://llllllll.co/t/norns-tutorial/23241). If you would like to contribute, visit the [repository](https://github.com/neauoire/tutorial).

## Connection

You need to get the device online and **accessible to your WIFI network**.

- Add your router details to the device, in `WIFI > ADD`. 
- Once the device is online, the `IP` field will display the _Norns's IP_, example `192.168.128.109`.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/0_wifi.png?raw=true' width='450'/>

- **To edit code(IDE)**, open [Maiden](http://norns.local/maiden/) by going `http://norns.local/` in your browser.
- **To transfer files(SFTP)**, open your [SFTP client](https://cyberduck.io/download/) and connect to the _Norns's IP_, with username `we` and password `sleep`.
- **To install new projects(SSH)**, open a new [terminal window](https://www.youtube.com/watch?v=IGmfU6QU5dI), type `ssh we@norns.local`, with password `sleep`.

You are now connected to the device, via the IDE, FTP and SSH. 

## Setup

In your **terminal window**, while being connected via **SSH**.

- **Move into the code folder** where scripts are typically held with `cd dust/code`.
- **Install this tutorial** on your device with `git clone https://github.com/neauoire/tutorial.git`
- **Move into the tutorial folder** with `cd tutorial`.

You are now ready to use this tutorial. 

## Basics

In [Maiden](http://norns.local/maiden/), reload the window to make sure the tutorial files are visible, and look at the [first example file](https://github.com/neauoire/tutorial/blob/master/1_blank.lua) of this tutorial.

- **Navigate to the first example** with `code > tutorial > 1_blank.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Look at the blank screen**, there is nothing to see.
- **Look at the logs**, at the bottom of the browser window in the console, it should display `init` and `redraw`.
- This example is not interactive.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/1_basics.png?raw=true' width='450'/>

You have run your first Norns script, from Github, via Maiden. The basic functions are as follow

```
function init() # On launch
function key(id,state) # On key press
function enc(id,delta) # On knob turn
function cleanup() # On Quit
```

## Interface

In [Maiden](http://norns.local/maiden/), look at the [second example file](https://github.com/neauoire/tutorial/blob/master/2_interface.lua) of this tutorial.

- **Navigate to the second example** with `code > tutorial > 2_interface.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Look at the screen**, notice the basic lines being drawn.
- This example is not interactive.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/2_interface.png?raw=true' width='450'/>

The interface is draw by a combination of methods from the [screen object](https://monome.github.io/norns/doc/modules/screen.html). The screen always must be cleared, and updated between changes. 

```
screen.clear()
screen.move(10,10)
screen.line(30,30)
screen.update()
```

## Interaction

In [Maiden](http://norns.local/maiden/), look at the [third example file](https://github.com/neauoire/tutorial/blob/master/3_interaction.lua) of this tutorial.

- **Navigate to the third example** with `code > tutorial > 3_interface.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Move the crosshair** by turning the two knobs to the right of the device.
- **Look at the screen**, notice the crosshair moving.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/3_interaction.png?raw=true' width='450'/>

The interactions are triggering the `key(id,state)` and `enc(id,delta)` functions, remember to `redraw` the interface after an interaction. The key state is a value of either `1`(key_down), or `0`(key_up). The knobs delta is a value of either `-1`(counter_clockwise), or `1`(clockwise).

```
function key(id,state)
  print('key',id,state)
end

function enc(id,delta)
  print('enc',id,delta)
end
```

## Animation

In [Maiden](http://norns.local/maiden/), look at the [fourth example file](https://github.com/neauoire/tutorial/blob/master/4_animation.lua) of this tutorial.

- **Navigate to the fourth example** with `code > tutorial > 4_animation.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Change the animation modulation** by turning the two knobs to the right of the device.
- **Look at the screen**, notice the screen being updated automatically.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/4_animation.png?raw=true' width='450'/>

The animation loop uses the [metro object](https://monome.github.io/norns/doc/modules/metro.html), the `1.0/15` time parameter sets the reload to the rate of `15fps`.

```
re = metro.init()
re.time = 1.0 / 15
re.event = function()
  redraw()
end
re:start()
```

## Output

In [Maiden](http://norns.local/maiden/), look at the [fifth example file](https://github.com/neauoire/tutorial/blob/master/5_output.lua) of this tutorial.

- **Navigate to the fifth example** with `code > tutorial > 5_output.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Change the rate of notes** by turning the left knob, to the right of the device.
- **Change the frequency of these notes** by turning the right knob, to the right of the device.
- **Listen to the generated sound** by connecting a pair of headphones to the leftmost 1/4" input.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/5_output.png?raw=true' width='450'/>

To send messages from Norns to Supercollider, use the `addCommand` method in your supercollider synth.

```
this.addCommand("amp", "f", { arg msg;
  amp = msg[1];
});
```

## Input

In [Maiden](http://norns.local/maiden/), look at the [sixth example file](https://github.com/neauoire/tutorial/blob/master/6_input.lua) of this tutorial.

- **Navigate to the sixth example** with `code > tutorial > 6_input.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Send audio to the device** by connecting a sound source in the fourth 1/4" input.
- **Change the amplitude of the outgoing sound** by turning the one of the two knobs, to the right of the device.
- **Listen to the modified sound** by connecting a pair of headphones to the leftmost 1/4" input.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/6_input.png?raw=true' width='450'/>

To receive the audio signal, you need to start polling with `poll.set("amp_in_l")`, and bind a callback function to `p_amp_in.callback`.

```
p_amp_in = poll.set("amp_in_l")
p_amp_in.time = refresh_rate
p_amp_in.callback = function(val) 
  print(val)
end
p_amp_in:start()
```

### Available polls

- `amp_in_l` / `amp_in_r`
- `amp_out_l` / `amp_out_r`
- `cpu_avg` / `cpu_peak`
- `pitch_in_l` / `pitch_in_r`
- `tape_play_pos` / `tape_rec_dur`

## Midi

In [Maiden](http://norns.local/maiden/), look at the [seventh example file](https://github.com/neauoire/tutorial/blob/master/7_midi.lua) of this tutorial. 

- **Navigate to the seventh example** with `code > tutorial > 7_midi.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Send midi to the device** by connecting a midi instrument via usb and pressing a key.
- **Listen to the resulting note** by connecting a pair of headphones to the leftmost 1/4" input.

You can control which device is sending midi, by selecting it in `SYSTEM > MIDI`, this example will receive midi from the first device, and send midi to the second device.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/7_midi.png?raw=true' width='450'/>

To receive the midi signal, you need to connect to the midi interface with `midi_signal = midi.connect()`, and give it a method to get the event, like `midi_signal.event = on_midi_event`.

```
midi_signal = midi.connect()
midi_signal.event = on_midi_event

function on_midi_event(data)
  msg = midi.to_msg(data)
  tab.print(msg)
end
```

## OSC

In [Maiden](http://norns.local/maiden/), look at the [eight example file](https://github.com/neauoire/tutorial/blob/master/8_osc.lua) of this tutorial.

- **Navigate to the eight example** with `code > tutorial > 8_osc.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Send osc to the device** by addressing `norns.local` at port `10111`.
- **Look at the incoming data**.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/8_osc.png?raw=true' width='450'/>

To receive the osc signal, you need to connect to the osc interface with `osc.event = on_osc_event`, and give it a method to get the event, like `on_osc_event(path, args, from)`, the `from` parameter is an array including the `ip` and `port`.

## Grid

In [Maiden](http://norns.local/maiden/), look at the [ninth example file](https://github.com/neauoire/tutorial/blob/master/9_grid.lua) of this tutorial.

- **Connect a Monome grid device**, and select it in `SYSTEM > GRID`.
- **Navigate to the ninth example** with `code > tutorial > 9_grid.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Touch a button on the grid** and watch it light up on the Norns.
- **Move the light across the monome** by turning the knobs on the Norns.
- **Change the brightness** by pressing the buttons on the Norns.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/9_grid.png?raw=true' width='450'/>

To communicate with the grid, you need to connect to the grid with `g = grid.connect()`, and give it a method to get the key event, like `g.key = on_grid_key`. The `led(x,y,brightness)` method allows you to toggle LEDs.

```
g:all(0)
g:led(1,2,15)
g:refresh()
```

## Include

In [Maiden](http://norns.local/maiden/), look at the [tenth example file](https://github.com/neauoire/tutorial/blob/master/A_include.lua) of this tutorial.

- **Navigate to the tenth example** with `code > tutorial > A_include.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Rotate the knobs** to change the position values of the included file.
- **Press the key** to select a different view.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/A_include.png?raw=true' width='450'/>

Including files with `local view = include('lib/view')`, will first look in the directory of the current script. This allows using relative paths to use libraries local to the script. The returned value of the included script will be available in your main script file.

```
-- lib/target.lua
return {
  value = 5
}

-- main script
local target = include('lib/target')
print(target.value)
```

In lua, you can create a new object and methods like the following snippet, notice how the `self` parameter is omitted when using the colon character.

```
obj = { c = 4 }

obj.add = function(self,a,b) 
  return a + b 
end

obj:add(2,3) -- 9
```

## Parameters

In [Maiden](http://norns.local/maiden/), look at the [eleventh example file](https://github.com/neauoire/tutorial/blob/master/B_parameters.lua) of this tutorial.

- **Navigate to the tenth example** with `code > tutorial > B_parameters.lua`.
- **Run the script** by clicking on the play button to the top right of the Maiden window.
- **Press the leftmost key**, rotate the leftmost knobs to the right, to see and modify the available parameters.

<img src='https://raw.githubusercontent.com/neauoire/tutorial/master/B_parameters.png?raw=true' width='450'/>

New parameters can be added with `params:add`, and read with `params:get`.

```
-- Add
params:add{type = "number", id = "number", name = "Number", min = 1, max = 48, default = 4}
params:add{type = "option", id = "option", name = "Option", options = {'yes','no'}, default = 1}

-- Read
print(params:get("number"))
```

## Useful Links

- [Help Thread](https://llllllll.co/t/norns-help/14016), support community.
- [Scripting Thread](https://llllllll.co/t/norns-scripting/14120), libraries community.
- [Development Thread](https://llllllll.co/t/norns-development/14073), tools community.
- [Supercollider Thread](https://llllllll.co/t/norns-crone-supercollider/14616), engine community.
- [Ideas Thread](https://llllllll.co/t/norns-ideas/17625), community suggestion.
- [Sketches Thread](https://llllllll.co/t/norns-ideas/17625), snippets community.
- [API docs](https://monome.github.io/norns/doc/index.html), documentation.
- [Repository](https://github.com/monome/norns), source files.

I hope you enjoyed these simple examples, **good luck**!
