# Services

Even though Domain-Driven design is heavily reliant on model-driven design, it sometimes is more accurate to portray a concept or operation as an action as opposed to an object. Identifying these actions or operations is necessary and occurs naturally, but Evans warns us to hold true to model-driven design first, before considering labeling a concept as an action:

> The more common mistake is to give up too easily on fitting the behavior into an appropriate object, gradually slipping toward procedural programming. **- Pg. 104**

Why call them _services_? The name truly emphasizes the purpose of satisfying a need of a _client_. A service has a defined responsibility that it offers and is obligated to fulfill.

Services can be appropriately placed in the `Application Layer`, `Domain Layer`, or `Infrastructure Layer`, depending on the responsibilities and context of the service.

### Application Services

Services in the `Application Layer` are responsible for exposing operations to clients that exercise the domain layer objects. These services are not to have any domain knowledge embedded in them, and instead are to orchestrate and coordinate communication with and between domain objects. _Application_ services are essentially responsible for decoupling clients from the `entities` and `value objects` living in the `Domain Layer`.

### Domain Services

A service placed in the `Domain Layer` represents a behavior, action, or operation that occurs naturally in the domain itself, that can't be accurately worked into the behavior of an `entity` or `value object`. Evans explains:

> Some concepts from the domain aren't natural to model as objects. Forcing the required domain functionality to be the responsibility of an `entity` or `value` either distorts the definition of a model-based object or adds meaningless artificial objects. **- Pg. 105**

It is important that the operation the service represents should be present in the `ubiquitous language` or be introduced into it if not already identified. The objects that the domain service is interfacing with should be present in the domain model itself.

There are three characteristics that describe a well defined _domain_ service:

1. The operation relates to a domain concept that is not a natural part of an `entity` or `value object`.
2. The interface is defined in terms of other elements of the domain model.
3. The operation is stateless.

### Infrastructure Services

Majority of the needs for services will be infrastructure-related. Services in the layers above the `Infrastructure Layer` will collaborate with _infrastructure_ services. These services provide a technical operation that can be utilized by higher layers such as the `Application Layer` or `Domain Layer`.

An example of an _infrastructure_ service would be a service that is responsible for issuing emails. Evans provides an example of a banking application:

> For example,  a bank might have an application that sends an email to a customer when an account balance falls below a specific threshold. The interface that encapsulates the email system, and perhaps alternate means of notification, is a service in the infrastructure layer. **- Pg. 106**

### Example

Briefly touched on in some sections above, Evans provides a great example to demonstrate uses of _application_ services, _domain_ services, and _infrastructure_ services in the form of a banking application.

This banking application has a feature that allows the user to transfer funds from one account to another. In the event that the funds of an account falls below a particular threshold, an email is sent to notify the account owner. Below is Evans' depiction of how the services are partitioned amongst the various layers:

`Application Layer`

- Funds Transfer Application Service
  + Digests input (such as an XML request).
  + Sends message to domain service for fulfillment.
  + Listens for confirmation.
  + Decides to send notification using infrastructure service.

`Domain Layer`

- Funds Transfer Domain Service
  + Interacts with necessary Account and Ledger domain objects, making appropriate debits and credits.
  + Supplies confirmation of result (transfer allowed or not, and so on).

`Infrastructure Layer`

- Send Notification Service
  + Sends emails, letters, and other communications as directed by the application.

Examining this, it is important to notice that the application service (Funds Transfer Application Service) is responsible for ordering the notification. Notification sending is a feature of the application itself, not the domain. The technical capability of sending a notification is exposed as an infrastructure service (Send Notification Service), and the application service is responsible for determining _when_ or _if_ that notification should be sent. The application service is not concerned with _how_ that notification is sent; that is the responsibility of the infrastructure service.

Another observation that is important to discuss, is the existence of the domain service (Funds Transfer Domain Service). Evans justifies the usage of a domain service for funds transfers:

> A feature that can transfer funds from one account to another is a domain service because it embeds significant business rules (crediting and debiting the appropriate accounts, for example) and because a "funds transfer" is a meaningful banking term. In this case, the service does not do too much on its own; it would ask the two Account objects to do most of the work. But to put the "transfer" operation on the Account object would be awkward, because the operation involves two accounts and some global rules. **- Pg. 107**
