spring-objective-c-example
==========================

An example application built with <a href ="https://github.com/jasperblues/spring-objective-c">spring-objective-c</a>.

###Features: 

* Returns weather reports from a remote cloud service
* Caches weather reports locally, for later off-line use. 
* Stores (creates, reads, updates deletes) the cities that the user is interested in receiving reports for. 
* Can use metric or imperial units. 

###Running the sample:

* Clone this repository, open the Xcode project in your favorite IDE, and run it. It'll say you need an API key.
Then proceed to step 1 below.
* Get an API key from http://free.worldweatheronline.com. 
* Study the <a href="https://github.com/jasperblues/spring-objective-c-example/blob/master/PocketForecast/Assembly.xml">application assembly</a>, and _configure_ the application with your API key. Run the App in the simulator or on your device. 
* Proceed to the exercises below. 

### Exercises

3. Study the <a href="https://github.com/jasperblues/spring-objective-c-example/blob/master/PocketForecast/ViewControllers.xml">view controllers</a>. 
Notice how the framework allows you to group related components together. 
4. Study the <a href="https://github.com/jasperblues/spring-objective-c-example/tree/master/PocketForecastTests/Integration">test cases</a>.
Imagine that you needed to use one service URL for integration tests and another for production. How would you do it?
5. Imagine that you decided to save the list of cities that the user wants to get reports for to iCloud, instead of locally on the device. Notice
how you'd only need to change one line of code to supply your new implementation in place of the old one. And you'd be able to reuse the existing test cases. 
6. Imagine that you'd like to integrate with other weather data providers, and let the user choose at runtime.  How would you do it? 
7. Try writing the same Application without dependency injection. What would the code look like? 


### The App ('scuse the dev's designs). 

![Weather Report](http://www.appsquick.ly/weather-report.png)
![Add City](http://www.appsquick.ly/add-city.png)
![List Cities](http://www.appsquick.ly/cities-list.png)

