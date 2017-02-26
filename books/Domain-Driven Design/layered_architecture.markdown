# Layered Architecture

The first building block that Eric Evans brings to light in Part II of his book _Domain-Driven Design_ is the **layered architecture**. A layered architecture is not specific to _domain-driven design_, but Evans describes why it is needed:

> When the domain-related code is diffused through such a large amount of other code, it becomes extremely difficult to see and to reason about. Superficial changes to the UI can actually change business logic. To change a business rule may require meticulous tracing of UI code, database code, or other program elements. Implementing coherent, model-driven objects become impractical. Automated testing is awkward. With all the technologies and logic involved in each activity, a program must be kept very simple or it becomes impossible to understand. **- Pg. 69**

There are various benefits reaped when utilizing a layered architecture in a software system:

- Allows concentration on different parts of the software's design and implementation in isolation.
- It encourages high cohesion of the design and implementation within each layer.
- The pattern enforces separation of concerns, meaning that each layer carries out a different task (or concern).
- Isolating aspects of the system into layers makes the system easier and less expensive to maintain.
- Each layer can evolve and adapt at different rates, which reflects the actual realities faced in software development.
- Aids with the development of distributed systems, since layers can be more easily placed on different servers or clients.

There have been many strategies on how to separate a software system. However, through experience and convention, the industry has converged on the use of layered architectures. This convergence has produced several standard layers:

### User Interface (Presentation Layer)

> Responsible for showing information to the user and interpreting the user's commands. The external actor might sometimes be another computer system rather than a human user. **- Pg. 70**

### Application Layer

> Defines the jobs the software is supposed to do and directs the expressive domain objects to work out problems. The tasks this layer is responsible for are meaningful to the business or necessary for interaction with the application layers of other systems. **- Pg. 70**

### Domain Layer (Model Layer)

> Responsible for representing concepts of the business, information about the business situation, and business rules. State that reflects the business situation is controlled and used here, even though the technical details of storing it are delegated to the infrastructure. _This layer is the heart of business software._ **- Pg. 70**

### Infrastructure Layer

>Provides generic technical capabilities that support the higher layers: message sending for the application, persistence for the domain drawing widgets for the UI, and so on. The infrastructure layer may also support the pattern of interactions between the four layers through an architectural framework. **- Pg. 70**

It is essential to understand that in a layered architecture, elements of each layer depend only on elements within that same layer, or within layers beneath it. For example, the `Application Layer` can depend on other elements within the `Application Layer`, as well as elements in the `Domain Layer` and `Infrastructure Layer`. However, it cannot depend on any element in the `UI Layer`.

Using a layered architecture to isolate the domain logic into its own layer is crucial to being able to execute model-driven design. This layer is the "manifestation" of the domain model and all directly related domain design elements. This layer is the implementation of all domain concepts represented by the domain model itself. Evans states time and time again the domain layer's importance:

> Concentrate all the code related to the domain model in one layer and isolate it from the user interface, application, and infrastructure code. The domain objects, free of the responsibility of displaying themselves, storing themselves, managing application tasks, and so forth, can be focused on expressing the domain model. This allows a model to evolve to be rich enough to capture essential business knowledge and put it to work. **- Pg. 70**

Evans describes that the metaphor of layering a system as "intuitive" and "well-trodden ground", but also emphasizes its criticality in order for domain-driven design to succeed. It is likely that you too feel that a layered architecture is straightforward. Regardless, I encourage you to pay particularly close attention to the implementation of the layered architecture in the systems you work on. Communicating the importance of this architecture, as well as being able to explain the role of each layer and the benefits with your fellow engineers will ensure a strong foundation for domain-driven design to build on.
