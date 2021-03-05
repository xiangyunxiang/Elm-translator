let model = {
    "open" : false,
    "heading" : 0,
}

basic.forever(function on_forever() {
    input.onButtonPressed(Button.A, function onPressButton_A() {
        
        model["open"] = false
    })
    input.onButtonPressed(Button.B, function onPressButton_B() {
        
        model["open"] = true
    })
    model["heading"] = input.compassHeading()
    function viewCompass() {
        
        if (model["open"] == true) {
            basic.showNumber(model["heading"])
        } else {
            basic.clearScreen()
        }
        
    }
    
    viewCompass()
})
