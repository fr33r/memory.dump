## Resources

The REST architecture is built around the concept of a _resource_.

A resource is essentially any real-world object or conceptual entity. In other words, it can be thought of as a noun.

This leaves the door pretty wide open, as it should. However, I often see others struggle with this concept. So let me craft a slightly more specialized definition that builds off of the formal definition:

> A resource is any conceptual entity. A resource for a particular system represents various objects, entities, relationships, etc. that comprise an application's domain.

For example, for a banking application, you could imagine the following as some of the many entities defined in the domain of the application:

- transaction
- withdrawal
- deposit
- account
- activation
- cancellation
- statement
- balance
- currency
- alert
- enrollment

So why add on this small bit?

> ... A resource for a particular system represents various objects, entities, relationships, etc. that comprise an application's domain.

I feel it helps to understand what resources are from the perspective of the domain that the application is in. It certainly **adds** to the actual definition of a _resource_, with the sole purpose of narrowing the collection of all entities in existence to the entities that will be of use in the design of a RESTful system.

There is really only one requirement for resources: that there is _at least_ one URI that identifies that resource.

Lastly, I want to make the distinction that a _resource_ is the idea of that real-object, not any particular _representation_ of that object.

A programming example would be a class in an object-oriented language such as C# or Java. If you create a `Person` class, it certainly isn't a real person, but a **representation** of that person.

This distinction seems minute and worthless, but with the REST architecture, it is a critical one.
