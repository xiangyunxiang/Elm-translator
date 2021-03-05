model = {'open':False, 'heading':0}

def on_forever():
    def onPressButton_A():
        global model
        model['open'] = False
    input.on_button_pressed(Button.A, onPressButton_A)
    
    def onPressButton_B():
        global model
        model['open'] = True
    input.on_button_pressed(Button.B, onPressButton_B)
    
    model['heading'] = input.compass_heading()
    
    def viewCompass():
        global model
        if model['open'] == True:
            basic.show_number(model['heading'])
        else:
            basic.clear_screen()
    viewCompass()

basic.forever(on_forever)
