## Slices

A common data structure in many programming languages is a resizable array. Some languages call these "array lists" or just "lists" for short, but in `go` they are referred to as `slices`. There are several features and behaviors of `slices` that are unique to `go`, making them somewhat troublesome to nail when first learning the language.

A [`slice`](https://golang.org/ref/spec#Slice_types) is a data structure that represents a resizable sequence of data that can be accessed by index. Internally, a `slice` is comprised of an `array` of a set size known as the `capacity` of the `slice`. The `length` of a slice represents the number of elements that have been stored in the slice at any given time.

### Constructing Slices

To construct a slice, utilize the `make` built-in function. This function called in two different ways for creating slices:

```go
make([]int, 10) //(slice, length)

// vs.

make([]int, 10, 10) //(slice, length, capacity)
```

A `slice` can also be constructed by utilizing a composite literal. The syntax of the composite literal when creating a slice looks similar to the syntax of composite literals for creating instances of structs.

```go
s := []string{"java", "go", "python", "ruby", "c++"}
```

### Slice Expressions



### `len`

The [`len`](https://golang.org/ref/spec#Length_and_capacity) built-in function when used with `slices` provides the length of the slice represented as an `int`. If the slice provided to the `len` function happens to be `nil`, a value of `0` will be returned.

### `cap`

Another built-in function commonly used with `slices` is the [`cap`](https://golang.org/ref/spec#Length_and_capacity) function. When provided a `slice`, this function returns an `int` representing the size of the internal array of the `slice`.

### `append`

The built-in function [`append`](https://golang.org/pkg/builtin/#append) is responsible for appending elements to the end of the slice provided to it. If the internal array of the slice has enough capacity to accommodate the new elements, the the slice is resliced to include the elements. If the addition of the elements exceeds the capacity, a new internal array will be allocated large enough to be able to contain the new elements.

This function returns updated slice. All calls to `append` should capture its return value. It is typical for the return value of `append` to be captured in the same slice passed to it.

```go
slice = append(slice, elem1, elem2)
```

### Pitfalls

- slices share underlying arrays.
