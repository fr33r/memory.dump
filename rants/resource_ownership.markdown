## Resource Ownership

>Garbage in, garbage out.

Ironically, in my career as an API engineer, I have faced several challenges when it comes time for me to write a RESTFul API that integrates with another RESTful API. The RESTful API I need to interact with could be a source system API, an API written by a third-party, etc. Of the many obstacles I have encountered, the most troubling has been the absence of **resource ownership**.

What do I mean?

Every RESTful API revolves around the concept of _resources_ and _representations_. A resource is a conceptual entity, while a representation is how that resource is presented or demonstrated. When designing a RESTful API, the API *must* own its resources. Here is my definition of ownership:

- Responsible for defining the resources themselves.
- Responsibly for defining, creating, maintaining, and evolving representations of the resources.
- Responsible for what operations can be performed on the resources.
- Responsible for ensuring that all resources are in a valid state.

A quick glance through the [HTTP 1.1](https://tools.ietf.org/html/rfc2616) specification and Roy Fielding's dissertation will reveal the definition of an _origin server_:

> The server on which a given resource resides or is to be created.

A RESTful API is essentially the _origin server_ as defined above in the HTTP specification. A server application such as Microsoft IIS, Apache Tomcat, etc. receives incoming requests and provides the request information to the RESTful API implementation. The RESTful API then processes the request, generates a response, and provides this response to the server application, which then is responsible for writing the bits onto the wire to the requesting client.

Many times, I have integrated with source system or third-party RESTful API's that assume no responsibility for ensuring the integrity of their resource states. They simply accept the desired state that I requested when creating or updating a resource, and perform no additional validation.

How could a designer/creator of a RESTful API expect its clients to provide valid data? How does a client know what "valid" means?

It's up to the API to enforce resource validity, **not** its clients. The RESTful API is ultimately responsible for the resources it has defined. A client has no obligation to ensure the validity of the resources. A designer/creator of a RESTful API cannot even expect to know who or what it's clients will be regardless if the API is only hosted within the enterprise firewall.

It shouldn't even take long for one to see how delegating resource ownership crashes and burns (implying it even gets off of the ground):

Suppose you have two teams:

- Team A
- Team B

Team A and Team B both interact with a RESTful API.

```
Team A  ----------------->  API <-----------------  Team B
```

Team A decides to create a new resource based on their idea of what is a valid state of the resource.

Team B decides they want to see a list of all resources created. However, they start experiencing issues due to what they consider _invalid_ resource state.

Essentially, Team A and Team B have different definitions of validity. One could easily see how this would happen. Team A and B likely have different requirements for their application. Perhaps they have different audiences. Either way, its clear that the issue is that these two teams shouldn't even be deciding validity in the first place.

You may be wondering what some real-world data examples of this could be. The best examples are simple ones:

- Email formats.
- Phone formats.
- Human name formats.
- ...etc.

Team B includes the country dialing code for phone numbers when creating or updating resources to allow for clients from all over the world make use of them. Team A could care less, so they do not provide dialing codes. Team B is then left to sift through the garbage, while the designer/creator of the API turns a blind eye.

Okay, so how does a RESTful API enforce validity? Luckily, this is incredibly easy using HTTP. The answer lies with these HTTP response codes:

- `400 (Bad Request)`.
- `403 (Forbidden)`.
- `409 (Conflict)`.

Below are the official definitions of these HTTP response codes:

`400 (Bad Request)`

> The request could not be understood by the server due to malformed
   syntax. The client SHOULD NOT repeat the request without
   modifications.

`403 (Forbidden)`

> The server understood the request, but is refusing to fulfill it.
   Authorization will not help and the request SHOULD NOT be repeated.
   If the request method was not HEAD and the server wishes to make
   public why the request has not been fulfilled, it SHOULD describe the
   reason for the refusal in the entity.  If the server does not wish to
   make this information available to the client, the status code 404
   (Not Found) can be used instead.

`409 (Conflict)`

> The request could not be completed due to a conflict with the current
   state of the resource. This code is only allowed in situations where
   it is expected that the user might be able to resolve the conflict
   and resubmit the request. The response body SHOULD include enough
   information for the user to recognize the source of the conflict.
   Ideally, the response entity would include enough information for the
   user or user agent to fix the problem; however, that might not be
   possible and is not required.

>Conflicts are most likely to occur in response to a PUT request. For
   example, if versioning were being used and the entity being PUT
   included changes to a resource which conflict with those made by an
   earlier (third-party) request, the server might use the 409 response
   to indicate that it can't complete the request. In this case, the
   response entity would likely contain a list of the differences
   between the two versions in a format defined by the response
   Content-Type.

Upon receiving a request from a client that is invalid based on the criteria explained by the HTTP specification for these three response codes, an API constructs a response indicating why the request is invalid so that the client can take corrective action.

### Conclusion

A RESTful API that exposes access to resources, owns those resources. The API is responsible for their definition, their lifespan, their representation(s), as well as their validity. RESTful API's built on top of the HTTP application protocol have several means of indicating to clients that the resource state they are attempting to transfer is invalid.
