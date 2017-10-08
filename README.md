# Safe2Home

This is the mobile app for assignment 2 of COMP90018 Mobile Computing Systems Programming. 
    
Travelling alone happens a lot. Especially for students, women or senior. sometimes we may have no choice but to go back home alone after a long overtime work. We may choose to take a taxi, catch a bus or take a walk, but either way we appreciate some extra protections. If we sense any unsecurity, how can we understand the current situation accurately? What should we do to as a response? **Safe2Home** lets you confirm your current location and understand the remaining journey time, provides direct access to your dear family or friends and records any suspicious sound nearby. 

## Getting Started

### Prerequisites

Since we slightly changed the contents of pod "EZAudio", please use the given pods instead of doing "pod install" to avoid any potential errors. 
     
The testing username is "q" with password "q". Please double click the login button if the navigation is not working, we apologize for the inconvenience.

### Major Features

* Choose an emergency contact to share your real-time location or get your call immediately
* Visualize an accurate location using Goole Map
* Get a timer to track the journey time
* Record audio if user feels unsafe
* Add more time to the timer
* Get your own contact list
    
*Tab "Journey" let you set and start journey.     

*Tab "Receiver" let you see your friend's current location when he/she needs your help.  

*Tab "Me" let you check your own information.

## Built With

* [Alamofire](https://github.com/Alamofire/Alamofire) - Used to handle networking
* [GoogleMaps](https://github.com/googlemaps/) - Used to handle map and relevant information
* [GooglePlaces](https://github.com/qpowell/google_places) - Used to handle map and place a picker
* [EZAudio](https://github.com/syedhali/EZAudio) - Used to handle audio recording
* [TPCircularBuffer](https://github.com/michaeltyson/TPCircularBuffer) - Used to handle audio recording


## Authors

* **Zhu Gong**
* **Lai Wei**
* **Siming Gu**


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
