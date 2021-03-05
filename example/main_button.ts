// MODEL
let model = {
    "num" : 0,
}

// VIEW
basic.forever(function on_forever() {
    // UPDATE
    input.onButtonPressed(Button.A, function onPressButton_A() {
        
        model["num"] = model["num"] + 1
    })
    // UPDATE
    input.onButtonPressed(Button.B, function onPressButton_B() {
        
        model["num"] = model["num"] - 1
    })
    basic.showNumber(model["num"])
})
