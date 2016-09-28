## Chapter 11
### HTTP for APIs

Up to this point in the book, the author has spent a great deal discussing how hypermedia can (and should) be incorporated into web APIs. He took a deep dive into various existing hypermedia media types, demonstrated via various examples and diagrams, and even went on to discuss how to create documentation (called _profiles_) to help bridge the application semantic gap between client and API.

This chapter shifts directions by taking a much closer look at the HTTP 1.1 (RFC2616) protocol itself, and how it can be fully leveraged for web APIs.

#### Don't Ignore HTTP's Semantics

In RFC2616, there are definitions for 41 HTTP response codes and 47 HTTP headers. Don't ignore them; use them.

Choosing to not become familiar with these well known and accepted semantics that are defined in RFC2616, the developer is running the risk of constructing semantics in their API that have already been defined by standards and utilized by everyone else. In the author's words regarding HTTP response codes:

>If you reinvent `404 (Not Found)` or `409 (Conflict)` for your API, you're just creating more work for everybody. - Pg. 238

Also, by not strictly abiding by RFC2616, the developer can cause confusion:

>If a client sends some bad data to your API, you should send the response code `400 (Bad Request)` and an entity-body explaining what the problem is. _Don't_ send `200 (OK)` with an error message. You are lying to the client. - Pg. 238

Although it may seem obvious, I have personally seen these kinds of issues in the workplace. API developers __need__ to read RFC2616 and/or any RFC that comes along to update it.

#### Content Negotiation

Resources can have many representations. Some of these resources may be in different languages. Some of them may be represented by different media types (such as `application/json` or `application/xml`).

 Clients usually only understand a single media type, so the client needs to be able to specify to the web API which media type it needs. The client would utilize the `Accept` HTTP header:

`Accept: application/json`

Clients may or may not support various languages (especially if the client is used among many different countries and cultures). In order to receive data from the web API in the correct language, the client would utilize the `Accept-Language` HTTP header:

`Accept-Language: en-us`

These are not all of the `Accept-*` HTTP headers that can be used, but the two above are the most common. If any of the `Accept-*` HTTP headers cannot be satisfied, the web API should return an HTTP status code of `406 (Not Acceptable)`.

##### Topics Not Covered in Summary
- Negotiating Profiles
- Hypermedia Menus
- Canonical URLs

#### Performance

As with any application, performance warrants considerable attention. Fortunately, RFC2616 has many tools for API developers to leverage to improve the performance of the communication between client and API.

##### Caching

It is common that clients will be calling into our API when they don't necessarily have to. What I mean is, the state of the resource has not changed since they last requested it. This is where _caching_ can significantly improve a client's performance.

There are several ways to utilize caching using HTTP, but one of the simplest is by utilizing the `Cache-Control` HTTP header. The `Cache-Control` HTTP header has several values it can have, usually taking on the form of key/value pairs known as _directives_. Some common examples are:

`Cache-Control: max-age=3600`

`Cache-Control: no-cache`

The `max-age` directive is simply indicating to the client how long it should wait until making that same request again. In the example above, the client should wait `3600` seconds, or one hour before making that request again.

The `no-cache` directive tells clients to never cache the response it receives from the request. This directive should be reserved for resource representations that are very _volatile_. In the words of the authors:

> This indicates that the resource state is so volatile that the representation probably becomes obsolete in the time it took to send it. - Pg. 242

One important point is that the directive applies to the __entire__ response, not just the entity-body of the response. This means the client can cache the response code, the HTTP headers in the response, the entity-body in the response, etc.

##### Conditional Requests

We saw with the use of the `Cache-Control` HTTP header that a RESTful web API can communicate to a client how long to wait before sending another request. In other words, with the use of this header, the API is stating the "life-span" of the representation that it is sending along. Once that life-span expires, the client knows to consult the API once again to get an updated representation.

However, there are times when determining how long a response can be cached for becomes increasingly difficult. An example of this is for a collection resource. Any change to any of the resources in the collection, including nested resource representations of a single item in the collection, would make all cached versions of the collection invalid.

Unfortunately, there isn't much of an alternative to `Cache-Control` to prevent the client from making the request all-together, but there are ways to eliminate the need to generate a response to the client if resource state has not changed. This technique is referred to as _conditional requests_.

One way conditional requests can be achieved is by using the `Last-Modified` HTTP header in responses. The value of this HTTP header is the date and time of when the resource being requests was, well, last modified. Clients can then stored this value and use it in subsequent requests for a representation of the resource by using the `If-Modified-Since` HTTP header. When this subsequent request is made, the API can check to see if resource state has changed, and if not, return `304 (Not Modified)` without an entity-body.

Obviously, this method requires that not only the web API keep track of dates and times that resources were last updated, but also requires the clients to keep track of them as well. It also, proves to be difficult when dealing with collections as well.

Another way conditional requests can be achieved is by using the `ETag` HTTP header. Short for entity tag, the `ETag` HTTP header is can be used in a response to provide a string value that must change when the resource representation changes. Essentially, this string value can be thought of as a hash code of sorts.

Upon subsequent requests for the resources representation, the client provides the ETag it has stored from the previous request by utilizing the `If-None-Match` HTTP header. The RESTful web API then only serves the entity-body in the response if the ETag provided in the `If-None-Match` HTTP header does not match the current ETag for the resource.

##### Compression

In many areas of computing, data compression provides great benefit by minimizing storage and bandwidth consumption. HTTP is no exception.

Compression can be communicated by a client to a web API by utilizing the `Accept-Encoding` HTTP header. The value of this header is comprised of the compression algorithms that the client desires. One common algorithm is known as `gzip`:

`Accept-Encoding: gzip`

The web API then uses the requested compression algorithm to compress the resource representation before serving it. The response includes the `Content-Encoding` HTTP header to indicate that it's entity-body is compressed. Below would be in response to the example above:

`Content-Encoding: gzip`

##### Topics Not Covered in Summary
- LBYL Requests
- Partial GET
- Pipelining

#### Extensions to HTTP

Majority (but not all!) of RESTful Web API's have been implemented to make use of the HTTP protocol. Over time, there have been some extensions made to the HTTP protocol to help benefit RESTful Web APIs specifically.

##### HTTP PATCH Verb

The HTTP verb of `PATCH` was defined in `RFC5789` to eliminate the potential performance problem when using the `PUT` HTTP verb. With `PUT` the client must provide **the entire** resource representation in a request, representing the desired state of that resource. With `PATCH`, a client can simply send the changes they wish to make to the resource.

Although this is an optimization, there is a downside when using the `PATCH` HTTP verb. The client and RESTful Web API must agree on a new media type of patch documents. However, there are already existing RFCs for these media types for both `JSON` (`RFC6902`) and `XML` (`RFC5261`).

##### Topics Not Covered in Summary
- OAuth
- LINK and UNLINK HTTP Verbs
- WebDAV
- HTTP 2.0
