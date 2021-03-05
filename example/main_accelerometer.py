'''model = { "acc" : 0}

def on_forever():
    model["acc"] = input.acceleration(Dimension.X)
    
    def viewAcceleration():
        global model
        if model["acc"] < -700:
            basic.show_leds("""#####\n.....\n#....\n.....\n#####""")
        elif model["acc"] >= -700 and model["acc"] < -300:
            basic.show_leds("""#####\n.....\n.#...\n.....\n#####""")
        elif model["acc"] >= -300 and model["acc"] < 300:
            basic.show_leds("""#####\n.....\n..#..\n.....\n#####""")
        elif model["acc"] >= 300 and model["acc"] < 700:
            basic.show_leds("""#####\n.....\n...#.\n.....\n#####""")
        else:
            basic.show_leds("""#####\n.....\n....#\n.....\n#####""")
    viewAcceleration()
basic.forever(on_forever)'''

model = { "acc" : 0}

def on_forever():
    model["acc"] = input.acceleration(Dimension.X)
    
    def viewAcceleration():
        global model
        if model["acc"] < -700:
            basic.clear_screen()
            led.plot(0, 2)
        elif model["acc"] >= -700 and model["acc"] < -300:
            basic.clear_screen()
            led.plot(1, 1)
            led.plot(1, 2)
            led.plot(1, 3)
        elif model["acc"] >= -300 and model["acc"] < 300:
            basic.clear_screen()
            led.plot(2, 0)
            led.plot(2, 1)
            led.plot(2, 2)
            led.plot(2, 3)
            led.plot(2, 4)
        elif model["acc"] >= 300 and model["acc"] < 700:
            basic.clear_screen()
            led.plot(3, 1)
            led.plot(3, 2)
            led.plot(3, 3)
        else:
            basic.clear_screen()
            led.plot(4, 2)
    viewAcceleration()
basic.forever(on_forever)