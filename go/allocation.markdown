## Allocation Using `new` and `make`

If you have taken a look at some code written in `go`, it is likely you have noticed the two built in functions `new` and `make`. You may be scratching your head as to when use one or the other. Despite that the contexts and the manner in which these two functions are utilized seems very similar, there are some subtle but important differences between them.

### `new`

The [`new`](https://golang.org/doc/effective_go.html#allocation_new) builtin function allocates memory for a type, but _does not_ initialize the memory. In other words, once memory is allocated, the `new` function zeroes that memory. After the allocation is complete, the `new` function returns a pointer to the new zeroed instance of the type provided to it.

```go
var myType *MyType = new(MyType)
```

### Constructors

When the [zero value](https://golang.org/ref/spec#The_zero_value) of type is not sufficient, a constructor function can do the job. A constructor function typically begins with `New` and is followed by the name of the struct it initializes. They usually are defined in the same package as the struct they initialize.

```go
func NewPerson(givenName string, surname string, age int8) *Person {
  person := new(Person)
  person.givenName = giveName
  person.surname = surname
  return person
}
```

### Composite Literals

An alternative to calling `new` and setting several properties on an instance is to use a composite literal. A composite literal provides syntax that initializes a type as well as a way to specify values for its members. Each time a composite literal expression is evaluated, a new instance is created.

```go
func NewPerson(givenName string, surname string, age int8) *Person {
  person := &Person{
    givenName,
    surname,
    age,
  }
  return person
}
```

If the field names of the type are omitted in the composite literal, they must be set in the order they are declared within the struct declaration, and they must all be present. When the field names _are_ specified, you can assign them in any order and even omit any number of them. The missing fields will be set to their corresponding type's zero value.

```go
func NewPerson(givenName string, surname string) *Person {
  person := &Person{
    surname: surname,
    givenName: givenName,
  }
  return person
}
```

If no values are provided for any of the types fields in a composite literal, the result is the zero value for the type.

```go
person := Person{}
```

You may be wondering:
>What is the difference between calling `new` and providing it a type, and using a composite literal without setting any fields?

```go
me := new(Person)

//vs.

you := &Person{}
```

My answer to you is: nothing. Absolutely nothing.

### `make`

In contrast, the [`make`](https://golang.org/doc/effective_go.html#allocation_make) builtin function constructs fully initialized instances of slices, maps, and channels exclusively. The result of calling `make` is a value (not a pointer!) of the type provided that is completely initialized. The driving reason for the special treatment of these three types lies with the fact that these types are comprised of data structures that must be initialized before they are of any value.

```go
var v []int = make([]int, 100)
```

### Usage

Now that we have an idea of how `new` and `make` work, what's the best way to use them?

Use `make` when:

- You are constructing a new instance of a slice, map, or channel.

Use `new` when:

- You are constructing a new instance of other types besides slices, maps, or channels.
- The types you are constructing have been designed in a way that their zero value doesn't require further initialization to be used.
