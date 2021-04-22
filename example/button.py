from microbit import *

def Model(num):
    return { "num": num }

def num(model):
    return model["num"]

def model():
    model = Model(0)
    return model

def Increment(model):
    return update(["Increment"], model)

def Decrement(model):
    return update(["Decrement"], model)

def update(signal, model):
    if signal[0] == "Increment":
        model = Model(num(model) + 1)
    if signal[0] == "Decrement":
        model = Model(num(model) - 1)
    return model

def view(model):
    while True:
        if button_a.was_pressed():
            model = Increment(model)
        if button_b.was_pressed():
            model = Decrement(model)
        display.show(str(num(model)))
    return model

view(model())