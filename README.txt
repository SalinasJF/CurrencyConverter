Jorge Salinas
I Was able to do most except things said in the project except saving the state upon close and open. 
New currency will be added at the top, then click button to add to the pickerViews. 
In the code I used two pickerViews and to determine which is which I have one of them a tag of 1 and 
the other had the default tag of 0. I also used a single semaphore to wait on the closure before continuing. 
Also there is no guard against inputting in an invalid currency and a number needs to be inputted 
before converting or else it will crash. 