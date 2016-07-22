## Representations

>A machine-readable explanation of the current state of a resource. **-Page 30; RESTful Web APIs**

>A representation can be _any_ machine-readable document containing _any_ information about a resource. **-Page 30; RESTful Web APIs**

Essentially, the basis of the RESTful architecture is that _representations_ of resources are transmitted between various components of the system.

You've undoubtably experienced this uncountable times when using the web.

Take the following example:

You are shopping online at your favorite online store, when you are asked to make an account before proceeding. You are prompted with a form to fill in various information:

- First name
- Last name
- Email
- Age
- Occupation

Once you have filled out the form, you click submit:

At this point in time, you are creating a new resource (an account), with the following representation (in JSON):

```JSON
{
  "firstName" : "Jon",
  "lastName" : "Freer",
  "occupation" : "Programmer",
  "age" : 24,
  "emailAddress" : "freerjm@miamioh.edu"
}
```
 Or perhaps the resource being created was transmitted as `application/x-www-form-urlencoded` format:

 ```
firstName=Jon&lastName=Freer&occupation=Programmer&age=24&emailAddress=freerjm@miamioh.edu
 ```

Once the server receives the request to create a new resource along with a representation, the server chooses to create the new resource and transmits back to you a different representation of the resource:

```HTML
<!DOCTYPE html>
<html>
  <head>
    <title>Account</title>
  </head>
  <body>
    <h3>First Name</h3>
    <p>Jon</p>
    <h3>Last Name</h3>
    <p>Freer</p>
    <h3>Occupation</h3>
    <p>Programmer</p>
    <h3>Age</h3>
    <p>24</p>
    <h3>Email Address</h3>
    <p>freerjm@miamioh.edu</p>
  </body>
</html>
```

As you can see the _representation_ of the new resource created was sent from the server in the format of HTML.

This example demonstrates the defintion of the REST acronym: **RE**presentational **S**tate **T**ransfer.

As the example I showed above demonstrates, it is certainly possible for a resource to have many different representations. So how does a particular component of the system (let's say, your browser) request the specific representation it wants?

There are two approaches:

- Content Negotiation
  - The client specifies the desired representation(s) by setting a value of a particular HTTP header.
- Multiple URIs
  - Remember back to when I said a resource had to have at least one URI to identify it? There can be multiple URIs for a single resource, each defining what kind of representation is desired.
  - However, the server responsible for that resource should designate one of the URIs as the official or "canonical" URI.
