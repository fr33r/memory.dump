# Handling Associations

Eric Evans explains in Part II of his book _Domain-Driven Design_ how coming up with the associations between elements in the domain objects is rather simple, but actually implementing them can be a tricky endeavor.

> In real life, there are lots of many-to-many associations, and a great number are naturally bidirectional. The same tends to be true of early forms of a model as we brainstorm and explore the domain. But these general associations complicate implementation and maintenance. Furthermore, they communicate very little about the nature of the relationship. **- Pg. 83**

There are three ways of streamlining associations:

1. Imposing a traversal direction.
2. Adding a qualifier, effectively reducing multiplicity.
3. Eliminating nonessential associations.

It is important to understand that a bidirectional association means that both objects can be understood only together. In other words, since each reference the other, both will be incomplete without the other. Closer examination of the domain can reveal that there is a natural directional bias.

Evan's provides an example to demonstrate this.

Consider the relationship between a country and the presidents that have led the country. The United States, for example, has had many presidents since it's establishment. This can be initially seen as a bidirectional, one-to-many relationship. Each country has had many presidents, while a president has only led one country.

But when this relationship is formulated, you must ask yourself whether one direction of this bidirectional relationship is "more" natural. In this example, there is a clear winner. It is more often (or "natural") that when conceptualizing the relationship between a country and its presidents, that you start with the one country and traverse its association to the many presidents. After all, how common is that we would start out with "Abraham Lincoln" and next ask, "Which country was he president?".

This let's us refine the bidirectional one-to-many relationship to a unidirectional one-to-many relationship. Not only that, refining this association sheds more insight into the domain itself, while at the same time offering a less complicated implementation. The domain know demonstrates that the chosen direction of the association is far more important and meaningful than the direction removed.

Even deeper understanding of the domain can expose more refinements that constrain the associations further. Evans encourages us to push to refine associations as much as we can:

> It is important to constrain relationships as much as possible. **- Pg. 83**

Our deeper understanding has resulted in us finding that a country can only have a single president at a time. This further constrains the multiplicity of the association to one-to-one. Not only that, it embeds an important rule into the domain model.
