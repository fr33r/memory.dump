### Chapter 11
#### HTTP for APIs

Up to this point in the book, the author has spent a great deal discussing how hypermedia can (and should) be incorporated into web APIs. He took a deep dive into various existing hypermedia media types, demonstrated via various examples and diagrams, and even went on to discuss how to create documentation (called _profiles_) to help bridge the application semantic gap between client and API.

This chapter shifts directions by taking a much closer look at the HTTP 1.1 (RFC2616) protocol itself, and how it can be fully leveraged for web APIs.

##### Don't Ignore HTTP's Semantics

In RFC2616, there are definitions for 41 HTTP response codes and 47 HTTP headers. Don't ignore them; use them.

Choosing to not become familiar with these well known and accepted semantics that are defined in RFC2616, the developer is running the risk of constructing semantics in their API that have already been defined by standards and utilized by everyone else. In the author's words regarding HTTP response codes:

>If you reinvent `404 (Not Found)` or `409 (Conflict)` for your API, you're just creating more work for everybody. - Pg. 238

Also, by not strictly abiding by RFC2616, the developer can cause confusion:

>If a client sends some bad data to your API, you should send the response code `400 (Bad Request)` and an entity-body explaining what the problem is. _Don't_ send `200 (OK)` with an error message. You are lying to the client. - Pg. 238

Although it may seem obvious, I have personally seen these kinds of issues in the workplace. API developers __need__ to read RFC2616 and/or and RFC that comes along to update it.
