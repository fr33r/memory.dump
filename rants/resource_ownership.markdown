## Resource Ownership

>Garbage in, garbage out.

It's incredible to me how much time and effort I have spent in my career as a software engineer disputing with other engineers what their software is responsible for.

In particular, I have been hit with these challenges when discussing RESTful API architectures. Many of those that I work with have a difficult time understanding what it means to have a RESTful API and what all responsibilities come along with it.

In particular I have been truly baffled by the lack of **resource ownership**.

What do I mean?

Every RESTful API revolves around the concept of _resources_ and _representations_. A resource is a conceptual entity, while a representation is how that resource is presented or demonstrated. When designing a RESTful API, the API *must* own its resources. Here is my definition of ownership:

- Responsible for defining the resources themselves.
- Responsibly for defining, creating, maintaining, and evolving representations of the resources.
- Responsible for ensuring that all resources are in a valid state.

Today, I literally had to attempt to explain to another team why they should validate  the desired resource states being provided for resource creation and alteration (`POST` and `PUT`). As it stands, they feel that their clients should be responsible for sending them valid data.

Immediately what I think of is the [Robustness Principle](https://en.wikipedia.org/wiki/Robustness_principle):

> Be conservative in what you do, be liberal in what you accept from others.

The further explanation on Wikipedia is on point:

>In other words, code that sends commands or data to other machines (or to other programs on the same machine) should conform completely to the specifications, but code that receives input should accept non-conformant input as long as the meaning is clear.

In the case of RESTful API's built on top of HTTP, the specification that **must** be conformed to is the [HTTP specification](https://tools.ietf.org/html/rfc2616).

How could a designer/creator of a RESTful API expect its clients to provide valid data? How does a client know what "valid" means?

It's up to the API to enforce resource validity, **not** its clients. A designer/creator of a RESTful API cannot even expect to know who or what it's clients will be regardless if the API is only hosted within the enterprise firewall.

It shouldn't even take long for one to see how delegating resource ownership crashes and burns (implying it even gets off of the ground):

Suppose you have two teams:

- Team A
- Team B

Team A and Team B both interact with a RESTful API.

Team A -----------------> API <----------------- Team B

Team A decides to create a new resource based on their idea of what is a valid state of the resource.

Team B decides they want to see a list of all resources created. However, they start experiencing issues due to what they consider _invalid_ resource state.

Essentially, Team A and Team B have different definitions of validity. One could easily see how this would happen. Team A and B likely have different requirements for their application. Perhaps they have different audiences. Either way, its clear that the issue is that these two teams shouldn't even be deciding validity in the first place.

You may be wondering what some real-world data examples of this could be. The best examples are simple ones:

- Email formats.
- Phone formats.
- Human name formats.
- ...etc.

Team B includes the country dialing code when creating or updating resources to allow for clients from all over the world make use of them. Team A could care less, so they do not provide dialing codes. Team B is then left to sift through the garbage, while the designer/creator of the API turns a blind eye.

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

### Conclusion

A RESTful API that exposes access to resources, owns those resources. The API is responsible for their definition, the lifespan, their representation, as well as their validity. RESTful API's built on top of the HTTP application protocol have several means of indicating to clients that the resource state they are attempting to transfer is invalid.
