#MODEL
model = {'num' : 0}

#VIEW
def on_forever():
    
    #UPDATE
    def onPressButton_A():
        global model
        model['num'] = model['num'] + 1
    input.on_button_pressed(Button.A, onPressButton_A)
    
    #UPDATE
    def onPressButton_B():
        global model
        model['num'] = model['num'] - 1
    input.on_button_pressed(Button.B, onPressButton_B)
    
    basic.show_number(model['num'])
    
basic.forever(on_forever)
