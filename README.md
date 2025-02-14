### Summary: Include screen shots or a video of your app highlighting its features

https://github.com/user-attachments/assets/70b59b26-3b1b-476f-b9bc-f86019e33012



### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

    I chose to prioritize image downloading/caching and memory management as these are the most impactful areas when it comes to UX. If the app does not load quickly or crash then users are likely to close/delete the app after the first use. People just want things to work when expected. The UI can always be updated and polished as needed.



### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
    
    It's hard to say how long this took as I was in and out of it a bit, but a good estimation would be about 6 hours. That does not include the creation of my more intuitive custom UI. (More below on that) 



### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

    There were a couple trade-offs I made: 
        1. I opted to use UIImage in the image cache instead of converting to Data just for the brevity of the project as I knew I would already be behind because of being away for a week starting the day after I recieved your email. Usually converting UIImage to Data to store in NSCache saves even more memory.
        2. I did not use AsyncImage as this helper view complicates the use of a custom cache. So I opted to create a crude version myself. 
        3. I used a single alert/error message for brevity as well. I also prefer not to barade the user with error alerts unless totally nessaccery. I feel it makes for a smoother UX.



### Weakest Part of the Project: What do you think is the weakest part of your project?

    For my experience thus far I would have to say that the unit testing is the weakest part of my project. Although i feel like it does what it needs. I'm sure there are some edge cases missed. However I've only done minimal unit testing before and it was with XCText and not the new Swift Testing interface/macros. So this part was a bit of a learning curve.



### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

    I chose the MVVM achitecture as this is what I'm comfortable with and to show you how I like to structure my apps.

    I also chose to use a UI that I previously created, modeled off of one of my favorites, just to show what I'm capable of. So I integrated that UI into this project as best I could without totally tweaking a bunch of things. It was made with iOS 18 so theres a couple of small things that won't work. i.e. scroll clipping, deeper navigation, card loading view, etc. Moreover, I've left the original ContentView.swift that I used to get the app working before integration of my custom favorite. I have put the files specific for this project in a separate folder than my custom UI for your ease of viewing the crux.

    The use of URLSession configuration documentations suggests automatic caching so I explicitly used the ephemeral configuration. This will help the app to not store dupicate caches and also show you my attention to detail and documentation.

    The AsyncImage documentation also suggests automatic caching of images however, in some reasearch I found this to be untrue, although there is some debate to this.

    I would also like to add that I love that your using async/await. Combine/publishers is a pain and a bit outdates IMO. Async/await makes things much easier and makes the code look cleaner as well. 


