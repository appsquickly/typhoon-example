spring-objective-c-example
==========================

An example application built with <a href ="https://github.com/jasperblues/spring-objective-c">spring-objective-c</a>.

###Features: 

* Returns weather reports from a remote cloud service
* Caches weather reports locally, for later off-line use. 
* Stores (creates, reads, updates deletes) the cities that the user is interested in receiving reports for. 
* Can use metric or old-style units. 

### Exercises

1. Get an API key from http://free.worldweatheronline.com. 
2. Study the <a href="https://github.com/jasperblues/spring-objective-c-example/blob/master/PocketForecast/Assembly.xml">application assembly</a>, and _configure_ the application with your API key. Run the App in the simulator or on your device. 
3. Study the <a href="https://github.com/jasperblues/spring-objective-c-example/blob/master/PocketForecast/ViewControllers.xml">view controllers</a>. 
Notice how the framework allows you to group related components together. 
4. Study the <a href="https://github.com/jasperblues/spring-objective-c-example/tree/master/PocketForecastTests/Integration">test cases</a>.
Imagine that you needed to use one service URL for integration tests and another for production. How would you do it? 


### The App ('scuse the dev's designs). 

![Weather Report](http://www.appsquick.ly/weather-report.png)
![Add City](http://www.appsquick.ly/add-city.png)
![List Cities](http://www.appsquick.ly/cities-list.png)

