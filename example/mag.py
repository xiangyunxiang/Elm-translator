from microbit import *

def Model(on, heading):
    return { "on": on, "heading": heading }

def on(model):
    return model["on"]

def heading(model):
    return model["heading"]

def model():
    model = Model(False, 0)
    return model

def Open(model):
    return update(["Open"], model)

def Close(model):
    return update(["Close"], model)

def Change(num, model):
    return update(["Change", num], model)

def update(msg, model):
    if msg[0] == "Open":
        model = Model(True, heading(model))
    if msg[0] == "Close":
        model = Model(False, heading(model))
    if msg[0] == "Change":
        model = Model(on(model), msg[1])
    return model

def view(model):
    while True:
        if button_a.was_pressed():
            model = Close(model)
        if button_b.was_pressed():
            model = Open(model)
        if compass.heading():
            model = Change(compass.heading(), model)
        viewCompass(model)
    return model

def viewCompass(model):
    if on(model):
        display.show(str(heading(model)))
    else:
        display.clear()
    return model

view(model())