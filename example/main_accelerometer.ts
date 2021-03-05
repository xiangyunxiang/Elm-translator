/** model = { "acc" : 0}

def on_forever():
    model["acc"] = input.acceleration(Dimension.X)
    
    def viewAcceleration():
        global model
        if model["acc"] < -700:
            basic.show_leds("""#####
.....
#....
.....
#####""")
        elif model["acc"] >= -700 and model["acc"] < -300:
            basic.show_leds("""#####
.....
.#...
.....
#####""")
        elif model["acc"] >= -300 and model["acc"] < 300:
            basic.show_leds("""#####
.....
..#..
.....
#####""")
        elif model["acc"] >= 300 and model["acc"] < 700:
            basic.show_leds("""#####
.....
...#.
.....
#####""")
        else:
            basic.show_leds("""#####
.....
....#
.....
#####""")
    viewAcceleration()
basic.forever(on_forever)
 */
let model = {
    "acc" : 0,
}

basic.forever(function on_forever() {
    model["acc"] = input.acceleration(Dimension.X)
    function viewAcceleration() {
        
        if (model["acc"] < -700) {
            basic.clearScreen()
            led.plot(0, 2)
        } else if (model["acc"] >= -700 && model["acc"] < -300) {
            basic.clearScreen()
            led.plot(1, 1)
            led.plot(1, 2)
            led.plot(1, 3)
        } else if (model["acc"] >= -300 && model["acc"] < 300) {
            basic.clearScreen()
            led.plot(2, 0)
            led.plot(2, 1)
            led.plot(2, 2)
            led.plot(2, 3)
            led.plot(2, 4)
        } else if (model["acc"] >= 300 && model["acc"] < 700) {
            basic.clearScreen()
            led.plot(3, 1)
            led.plot(3, 2)
            led.plot(3, 3)
        } else {
            basic.clearScreen()
            led.plot(4, 2)
        }
        
    }
    
    viewAcceleration()
})
