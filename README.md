# Spring Boot "Microservice"

This is a Java / Maven / Spring Boot application for creating a microservice complete with built-in health check, metrics and much more.

## How to Run 

This application is packaged as a war which has Tomcat 7 embedded. No Tomcat or JBoss installation is necessary. You run it using the ```java -jar``` command.

* Once successfully built, you can run the service by one of these two methods:
```
        java -jar -Dspring.profiles.active=test target/spring-boot-rest-example-0.2.0.war
or
        mvn spring-boot:run -Drun.arguments="spring.profiles.active=test"
```

Once the application runs you should see something like this

```
2014-10-04 18:24:58.870  INFO 10190 --- [           main] s.b.c.e.t.TomcatEmbeddedServletContainer : Tomcat started on port(s): 8090/http
2014-10-04 18:24:58.872  INFO 10190 --- [           main] com.khoubyari.example.Application        : Started Application in 6.764 seconds (JVM running for 7.06)
```

## About the Service

The service is just a simple hotel review REST service. It uses an MySQL database to store the data. If your database connection properties work, you can call some REST endpoints defined in ```com.khoubyari.example.api.rest.hotelController``` on **port 8090**. (see below)

More interestingly, you can start calling some of the operational endpoints (see full list below) like ```/metrics``` and ```/health``` (these are available on **port 8091**)

You can use this sample service to understand the conventions and configurations that allow you to create a DB-backed RESTful service. Once you understand and get comfortable with the sample app you can add your own services following the same patterns as the sample service.
 
Here is what this application demonstrates: 

* Full integration with the latest **Spring** Framework: inversion of control, dependency injection, etc.
* Packaging as a single jar with embedded container (tomcat 7): No need to install a container separately on the host just run using the ``java -jar`` command
* Demonstrates how to set up healthcheck, metrics, info, environment, etc. endpoints automatically on a configured port. Inject your own health / metrics info with a few lines of code.
* Writing a RESTful service using annotation: supports both XML and JSON request / response; simply use desired ``Accept`` header in your request
* Exception mapping from application exceptions to the right HTTP response with exception details in the body
* *Spring Data* Integration with JPA/Hibernate with just a few lines of configuration and familiar annotations. 
* Automatic CRUD functionality against the data source using Spring *Repository* pattern
* Demonstrates MockMVC test framework with associated libraries
* All APIs are "self-documented" by Swagger using annotations 

Here are some endpoints you can call:

### Get information about system health, configurations, etc.

```
http://localhost:8091/env
http://localhost:8091/health
http://localhost:8091/info
http://localhost:8091/metrics
```

### Create a hotel resource

```
POST /example/v1/hotels
Accept: application/json
Content-Type: application/json

{
"name" : "Beds R Us",
"description" : "Very basic, small rooms but clean",
"city" : "Santa Ana",
"rating" : 2
}

RESPONSE: HTTP 201 (Created)
Location header: http://localhost:8090/example/v1/hotels/1
```

### Retrieve a paginated list of hotels

```
http://localhost:8090/example/v1/hotels?page=0&size=10

Response: HTTP 200
Content: paginated list 
```

### Update a hotel resource

```
PUT /example/v1/hotels/1
Accept: application/json
Content-Type: application/json

{
"name" : "Beds R Us",
"description" : "Very basic, small rooms but clean",
"city" : "Santa Ana",
"rating" : 3
}

RESPONSE: HTTP 204 (No Content)
```

# About Spring Boot

Spring Boot is an "opinionated" application bootstrapping framework that makes it easy to create new RESTful services (among other types of applications). It provides many of the usual Spring facilities that can be configured easily usually without any XML. In addition to easy set up of Spring Controllers, Spring Data, etc. Spring Boot comes with the Actuator module that gives the application the following endpoints helpful in monitoring and operating the service:

**/metrics** Shows “metrics” information for the current application.

**/health** Shows application health information.

**/info** Displays arbitrary application info.

**/configprops** Displays a collated list of all @ConfigurationProperties.

**/mappings** Displays a collated list of all @RequestMapping paths.

**/beans** Displays a complete list of all the Spring Beans in your application.

**/env** Exposes properties from Spring’s ConfigurableEnvironment.

**/trace** Displays trace information (by default the last few HTTP requests).
