# quantum-shooter

Simple shooter game writtern in [Lua](https://www.lua.org/) and
[LÖVE](love2d.org/)  framework with Einstein-Podolsky-Rosen bullets/pairs.

## How to run?

Just type

`love .`

in the main directory. 

## What is Einstein-Podolsky-Rosen pair?

More about [EPR paradox](https://en.wikipedia.org/wiki/EPR_paradox) and [Bell
states](https://en.wikipedia.org/wiki/Bell_state). Also recommended [Orginal
paper by Einstein, Podolsky and Rosen](https://doi.org/10.1103/PhysRev.47.777),
which is free to read.

## Description

The game is build around the simple shooting game, with a sligth extension of a
player having an ability to use EPR pairs to propagate bullets. Basic controls
inclide

* `SPACE` - shoot a standard bullet
* `X` - shoot a quantum bullet (a quant)
* `M` - measure quantum bullets (quants) to get classical bullets

A player can choose to shoot with classical bullets, which direcly hit the
enemies, or quantum bullets. Quantum bullets have to be *measures* and can
result in the appearance of two classical bullet or none of them. It up to you
if you decide to play with classical bullets or with quantum. 

Additionally, the plateyer can
* `R` restart the game after getting hit by the enemy
* `ESC` - quit the game.

## Screenshots

![Screenshot 1](/img/screen1.png)
![Screenshot 2](/img/screen2.png)

## Limitation

This project is a byproduct of reading Lua tutorials. There is only one level
and a player has only one live. Game parameters can be changed in `conf.lua`.

There is only one quantum state used. Also, all quantum bullets have to mea
measured at the same time.

## Requirements

In order to run the game you need to install [LÖVE](love2d.org/) framework. The
game was tested under Ubuntu 20.04.3 LTS with LÖVE 11.3.

## Credits

The game is based on the tutorial [Your First Love2d Game in 200 Lines](http://osmstudios.com/tutorials/your-first-love2d-game-in-200-lines-part-1-of-3)

Graphics used in the game was provided by: [chabull](https://opengameart.org/content/aircrafts) and [Rawdanitsu](https://opengameart.org/content/lasers-and-beams) at [OpenGameArt](https://opengameart.org)

Roboto fonts are availble at https://fonts.google.com/specimen/Roboto

