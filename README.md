spring-objective-c-example
==========================

An example application built with spring-objective-c. 

###Features: 

* Returns weather reports from a remote cloud service
* Caches weather reports locally
* Stores (creates, reads, updates deletes) the cities that the user is interested in receiving reports for. 
* Can use metric or old-style units. 

### The Assembly

Just a few lines of XML. These components are used in a few places. You could use a traditional sharedInstance, but
then how would you: 

* Test the classes that use them in isolation. 
* Configure the shared instances for both production and test scenarios. 

```xml

    <description>
        This file encapsulates the core model. To use, please get an API key from: http://www.worldweatheronline.com
    </description>

    <component class="PFWeatherClientBasicImpl" key="weatherClient">
        <description>
            This is component retrieves weather reports from the cloud-service.
        </description>
        <property name="serviceUrl" value="http://free.worldweatheronline.com/feed/weather.ashx"/>
        <property name="apiKey" value="$$YOUR_API_KEY_HERE$$"/>
        <property name="weatherReportDao" ref="weatherReportDao"/>
    </component>

    <component class="PFWeatherReportDaoFileSystemImpl" key="weatherReportDao">
        <description>
            This class is responsible for caching retrieved reports to the device for later usage.
        </description>
    </component>

    <component class="PFCityDaoUserDefaultsImpl" key="cityDao">
        <description>
            This class is responsible for saving and retrieving cities the user wants reports for.
        </description>
    </component>

</assembly>




```

### The App ('scuse the dev's designs). 

![Weather Report](http://www.appsquick.ly/weather-report.png)
![Add City](http://www.appsquick.ly/add-city.png)
![List Cities](http://www.appsquick.ly/cities-list.png)

