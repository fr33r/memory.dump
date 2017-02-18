## CORS

When I was developing a RESTful API for http://emma.jonfreer.com/, I ran into an issue during my deployment. I had decided to host my API on http://freer.ddns.net on a server at home, while I hosted the front-end on http://emma.jonfreer.com. Up to this point, I had never heard of the [same origin policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) or [cross-origin resource sharing]() so once I deployed my front-end to http://emma.jonfreer.com and my RESTful API to http://freer.ddns.net, I found that I was unable to successfully complete AJAX requests from the front-end to the API.

### Same Origin Policy

I was unable to perform these AJAX requests because of something called the [same origin policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy). This policy restricts how a resource from one origin can interact with another resource from a different origin. The main reason for this policy's existence is for security purposes. It was devised in order to prevent a malicious script from one resource on an origin to acquire or interact with sensitive data of another resource on another origin.

When it came time to deploy my application, I was encountering issues because my front-end (written entirely in HTML5, CSS3, and JavaScript) was performing AJAX HTTP requests using `XMLHttpRequest` to interact with resources exposed by my RESTful API on a different "origin". An origin can be defined as the following:

> Two pages have the same origin if the protocol, port (if one is specified), and host are the same for both pages. **- MDN**

However, not all cross-origin HTTP requests are bad. In fact, in the modern day web, these kinds of requests are everywhere. It is common to see a web page resource perform HTTP requests to other origins for retrieving image resources using the `<img>` HTML tag, for example. In order make these cross-origin HTTP requests possible a mechanism called *cross-origin resource sharing* was created to allow safe cross domain resource access.

### Cross-Origin Resource Sharing

CORS stands for **C** ross **O** rigin **R** esource **S** haring and is the standard for safely making cross-origin HTTP requests. The standard is implemented using a series of HTTP headers when exchanging HTTP requests. These HTTP requests can be grouped into "simple" requests and "non-simple" requests known as preflight requests.

#### "Simple" Requests

In order for an HTTP request following CORS to be considered as a "simple" request, it has to satisfy these conditions:

- The HTTP method of the request is `GET`, `HEAD`, or `POST`.
- If the `Content-Type` header is present, it can only have the following media types as a value:
  - `application/x-www-form-urlencoded`
  - `multipart/form-data`
  - `text/plain`
- The HTTP headers in the request are either [CORS safelisted request headers](https://fetch.spec.whatwg.org/#cors-safelisted-request-header) or HTTP headers normally set automatically by the browser (referred to as [forbidden headers](https://fetch.spec.whatwg.org/#forbidden-header-name) in the CORS specification).

Below is a real example of what a "simple" CORS request/response looks like between http://emma.jonfreer.com and http://freer.ddns.net:8080:

```
GET /api/wedding/guests/?inviteCode=pa12345 HTTP/1.1
Host: freer.ddns.net:8080
Connection: keep-alive
Accept: application/json
Origin: http://emma.jonfreer.com    <---
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36
Referer: http://emma.jonfreer.com/
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8
```

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Access-Control-Allow-Origin: http://emma.jonfreer.com   <---
Access-Control-Allow-Credentials: true
Content-Type: application/json
Content-Length: 451
Date: Thu, 16 Feb 2017 03:32:29 GMT

{
  ...
}

```

As the arrows (`<---`) indicate, the headers to focus on for this example are `Origin` in the request, and `Access-Control-Allow-Origin` in the response.

##### Origin

The [`Origin`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Origin) HTTP header in a CORS request is used to indicate the origin that the HTTP request is coming from.

##### Access-Control-Allow-Origin

The [`Access-Control-Allow-Origin`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) HTTP header in a CORS response is used by the server to communicate what origin(s) the requested resource is allowed to be requested from. In this specific example, the server responded with the following:

```
...
Access-Control-Allow-Origin: http://emma.jonfreer.com
...
```

The key thing to notice is that the value of the `Access-Control-Allow-Origin` header from the server in the CORS response matches the value specified for the `Origin` header in the CORS request. This shows that the server is granting access to the requested resource (`/api/wedding/guests/`) to `http://emma.jonfreer.com`.

The value of the `Access-Control-Allow-Origin` HTTP header in a CORS response *must* match the origin specified in the `Origin` HTTP header in a CORS request (as demonstrated by this example) in order for the request to succeed.

A wildcard value (`*`) is a valid value for the `Access-Control-Allow-Origin` HTTP header in a CORS response. When this wildcard is specified, it means the server is indicating that all origins can access the resource being requested. **Please use this wildcard sparingly as it essentially bypasses the security provided by CORS for the resource being requested. It should only be used when the resource does not contain sensitive data and extensive analysis proves that it cannot be utilized maliciously.**

#### Preflight Requests

If any of the conditions specified for "simple" requests fails, a preflight request will be performed instead. A preflight request involves sending an HTTP request with a method of `OPTION` to the receiving origin with the goal of ensuring the desired cross-origin request is safe to send. Upon "approval" of this first request, the desired request is subsequently performed.

Here is an example of a preflight request between http://emma.jonfreer.com and http://freer.ddns.net:

`Preflight Request:`
```
OPTIONS /api/wedding/guests/235/ HTTP/1.1
Host: freer.ddns.net:8080
Connection: keep-alive
Access-Control-Request-Method: PUT  <---
Origin: http://emma.jonfreer.com  <---
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36
Access-Control-Request-Headers: content-type  <---
Accept: */*
Referer: http://emma.jonfreer.com/editGuest.html
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8
```

`Response to Preflight Request:`

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Access-Control-Allow-Origin: http://emma.jonfreer.com <---
Access-Control-Allow-Credentials: true
Access-Control-Max-Age: 1800  <---
Access-Control-Allow-Methods: PUT <---
Access-Control-Allow-Headers: origin,x-requested-with,access-control-request-headers,content-type,access-control-request-method,accept  <---
Content-Length: 0
Date: Thu, 16 Feb 2017 04:14:32 GMT
```

As you can see in the preflight request, there are three CORS-related HTTP headers: `Origin`, `Access-Control-Request-Method`, and `Access-Control-Request-Headers`. As discussed earlier for "simple" requests, the `Origin` HTTP header simply specifies the origin that the CORS request is originating from.

##### Access-Control-Request-Method

The [`Access-Control-Request-Method`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Request-Method) HTTP header in a CORS preflight request is used to indicate to the server the HTTP method that will be used for the "real" (desired) request.

##### Access-Control-Request-Headers

The [`Access-Control-Request-Headers`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Request-Headers) HTTP header in a CORS preflight request communicates to the server what HTTP headers may be used for the "real" (desired) request.

The `Origin`, `Access-Control-Request-Method`, and `Access-Control-Request-Method` HTTP headers sent in the CORS preflight request provides the server the opportunity to decide whether or not to allow a cross-origin request with the specified HTTP method and specified HTTP headers in the `Access-Control-Request-Method` and `Access-Control-Request-Headers` headers, respectively.

In response to the preflight request, the server responds with an HTTP status of `200 OK` as well a few CORS-specific headers to pay attention to: `Access-Control-Allow-Origin`, `Access-Control-Max-Age`, `Access-Control-Allow-Methods`, `Access-Control-Allow-Headers`. Again, as a recap to the explanation found for "simple" requests, the `Access-Control-Allow-Origin` HTTP header indicates which origins have access to the resource being requested.

##### Access-Control-Max-Age

The [`Access-Control-Max-Age`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Max-Age) header indicates how long the outcome of a preflight request can be cached. More specifically, the value of this HTTP header communicates how many seconds the values of the `Access-Control-Allow-Methods` and `Access-Control-Allow-Headers` headers can be cached.

##### Access-Control-Allow-Methods

The [`Access-Control-Allow-Methods`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Methods) dictates which HTTP methods can be utilized when making requests to the target resource of the preflight request. In order for subsequent CORS requests to succeed, the value specified in the `Access-Control-Request-Method` header in the preflight request must be listed as one of the HTTP methods in the `Access-Control-Allow-Methods` header found in the response to the preflight request.

##### Access-Control-Allow-Headers

The [`Access-Control-Allow-Headers`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Headers) is present in the response to a preflight request to indicate what HTTP headers will be available in the `Access-Control-Expose-Headers` HTTP header found in the response to the subsequent CORS request. It is important to note that the ["simple" headers](https://developer.mozilla.org/en-US/docs/Glossary/simple_header) (CORS safelisted headers) do not need to be listed within the
`Access-Control-Allow-Headers` header.

`Subsequent CORS Request:`
```
PUT /api/wedding/guests/235/ HTTP/1.1
Host: freer.ddns.net:8080
Connection: keep-alive
Content-Length: 227
Accept: application/json
Origin: http://emma.jonfreer.com
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36
Content-Type: application/json
Referer: http://emma.jonfreer.com/editGuest.html
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8

{
  ...
}
```

`Response to Subsequent CORS Request:`

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Access-Control-Allow-Origin: http://emma.jonfreer.com
Access-Control-Allow-Credentials: true
Content-Type: application/json
Content-Length: 227
Date: Thu, 16 Feb 2017 04:14:32 GMT
```

Since the server (origin of `http://freer.ddns.net`) acknowledged that a `PUT` request to the resource `api/wedding/guests/235/` with a `Content-Type` HTTP header from an origin of `http://emma.jonfreer.com` was allowed (indicated by the values provided in the `Access-Control-Allow-Origin`, `Access-Control-Allow-Headers`, and `Access-Control-Allow-Methods` HTTP headers in the response to the preflight request), the subsequent CORS request was made and completed successfully.

### Configuring Tomcat 8 (Linux Ubuntu LTS)

If you are hosting a single RESTful API, or want to enforce the same CORS policy for all of the applications hosted within the same instance of Apache Tomcat 8, you can configure Tomcat to carry out the various server responsibilities discussed in previous sections of this memory dump.

#### CORS Filter

Apache Tomcat 8 (along with other versions as well; this is just the version that my RESTful API is currently hosted with) can be configured to make use of a filter provided with the container called the [CORS Filter](https://tomcat.apache.org/tomcat-8.0-doc/config/filter.html#CORS_Filter). If you are utilizing Linux Ubuntu LTS, you can make the necessary changes in the `web.xml` file found in the `/var/lib/tomcat8/conf/` directory. Below is the configuration I am using to serve as an example:

```xml
<filter>
  <filter-name>CorsFilter</filter-name>
  <filter-class>org.apache.catalina.filters.CorsFilter</filter-class>
  <init-param>
    <param-name>cors.allowed.origins</param-name>
    <param-value>http://emma.jonfreer.com, http://www.jonfreer.com, http://wedding.jonfreer.com</param-value>
  </init-param>
  <init-param>
    <param-name>cors.allowed.methods</param-name>
    <param-value>GET, POST, HEAD, OPTIONS, PUT, DELETE</param-value>
  </init-param>
  <init-param>
    <param-name>cors.exposed.headers</param-name>
    <param-value>Date, ETag</param-value>
  </init-param>
</filter>
<filter-mapping>
  <filter-name>CorsFilter</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>
```
