# FAQs

### Error: SCRIPT ERROR: AUDIO ENGINE

It is likely that you have a duplicated audio engine, to find the name, in [Maiden](http://norns.local/maiden/), display the REPL console, select the `sc` tab and type `;restart`. This should display something along the lines of 

```
ERROR: duplicate Class found: 'Engine_SimplePassThru' 
```

### How to take a screenshot

In [Maiden](http://norns.local/maiden/), type the following:

```
s_export_png("/home/we/screenshot.png")
```

In SSH, type the following:

```
magick convert $1.png -gamma 1.25 -filter point -resize 400% -gravity center -background black -extent 120% $1-m.png
```
