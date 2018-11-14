# Generics in Java

The concept of _generic_ programming involves creating programming constructs such as classes, and/or methods of classes that can be utilized with a multitude of _types_. The main goal in mind is to be able to create a class or a method once so that it can accommodate for multiple types, instead of having to create separate implementations of the class or method for each type it was intended to support.

Perhaps you considered creating a class that served as a "container" of some sort. Perhaps I have decided to create the concept of a "bag" in my program:

```java
public class IntBag{
  private int[] items;

  public Bag(int[] items){
    this.items = items;
  }

  public int pickFrom(){
    Random random = new Random();
    int randomIndex = random.nextInt(this.items.length);
    return this.items[randomIndex];
  }
}
```

This works, but ideally I should make my concept of a bag be able to store other types beside just `int`. Otherwise, I will be forced to write a separate implementation for each type I want to support, such as `DoubleBag`, `StringBag`, and so on. The solution to this redundancy is to use _generic_ programming so that I only have to create one class that can handle a variety of types.

Generic programming, often referred to as just _generics_, involves declaring a _type parameter_ for a class, method, or both. The process of supplying a type for the type parameter is referred to as _instantiating_ the type parameter. It is important to note that a type parameter cannot be instantiated with any one of the eight primitive types (`byte`, `short`, `int`, `long`, `double`, `float`, `char`, `boolean`). Instead, the corresponding wrapper class can be used. A generic class or generic class can have any number of type parameters, and it is common convention to see type parameters as uppercase letters such as `T`, `S`, `E`, and so on.

### Generic Classes (AKA Generic Types)

It is likely that you have stumbled upon generic types with Java already. Some of the most commonly used generic types are collection-base generic types such as the `ArrayList<T>` generic class. Making the `ArrayList` class generic allows for creating lists of any type, such as `ArrayList<String>` or `ArrayList<Integer>`.

In order to make a class generic, at least one type parameter needs to be declared between two angle brackets (`<`, `>`) within the class declaration like so:

```java
public class Bag<T>{
  ...
}
```

Now, when implementing the generic class, the type parameter of `T` can be utilized when specifying the types of instance variables, method parameters, etc. Check it out:

```java
public class Bag<T>{

  private ArrayList<T> items;

  public Bag(ArrayList<T> items){
    this.items = items;
  }

  public T pickFrom(){
    Random random = new Random();
    int randomIndex = random.nextInt(this.items.size());
    return this.items.get(randomIndex);
  }
}
```

As clearly shown above, the type parameter of `T` is used throughout the `Bag<T>` class definition. It is even used to specify the type parameter of the `items` instance variable, which has the type `ArrayList<T>` where `T` is the type provided to the `Bag<T>` class. So now, if I wanted to have a bag of integers, I could do so by _instantiating_ the type parameter to `Integer`. That would look like this:

```java
Bag<Integer> bagOfIntegers = new Bag<Integer>();
```

### Generic Methods

### Type Parameter Constraints

There are times when we want to restrict what types can be accepted as type parameters in our generic classes or generic methods. We can add _constraints_ to the type parameters of generic classes and generic methods so that the types utilized have to extend a particular class or implement a particular interface.

Here is a simple demonstration of a generic class `Garage` that utilizes type constraints:

```java
public class Garage<T extends Vehicle>{

    private ArrayList<T> vehicles;

    public Garage(){
        this.vehicles = new ArrayList<T>();
    }

    public Garage(ArrayList<T> vehicles){
        this.vehicles = vehicles;
    }

    public void add(T vehicles){
        this.vehicles.add(vehicles);
    }

    protected ArrayList<T> getVehicles(){
        return this.vehicles;
    }
}
```

The type constraint of `extends Vehicle` enforces that we only have types that inherit from the `Vehicle` class. This makes sense; we can only want vehicles in our garage!

It's important to call out that the keyword `extends` when specifying type constraints applies to both classes _and_ interfaces. Think of it as "extends or implements" when the keyword is used for applying type constraints.

Type constraints are not limited to having just a single type constraint. Check it out with the `ElectricGarage` generic class:

```java
public class ElectricGarage<T extends Vehicle & Rechargeable> extends Garage<T> {

    public ElectricGarage(){
        super();
    }

    public ElectricGarage(ArrayList<T> vehicles){
        super(vehicles);
    }

    public void chargeVehicles(){
        ArrayList<T> vehicles = this.getVehicles();
        int size = vehicles.size();

        for(int i = 0; i < size; i++){
            this.getVehicles().get(i).recharge();
        }
    }
}
```

The `ElectricGarage` is a garage only for electric vehicles. The type constraint enforces that only types that extend the `Vehicle` class and implement the `Rechargeable` interface can be provided for `T`.

#### Wildcards

Lastly, Java allows the usage of wildcards when specifying type parameters for generic classes and generic methods. Wildcards provide more subtle constraints to type parameters.

| Description               	| Syntax        	| Meaning            	|
|---------------------------	|---------------	|--------------------	|
| Wildcard with lower bound 	| `? extends T` 	| Any subtype of T   	|
| Wildcard with upper bound 	| `? super T`   	| Any supertype of T 	|
| Unbounded wildcard        	| `?`           	| Any type           	|


### Type Erasure

Due to the fact that generic types were not introduced until Java Standard Edition 5.0 in 2004, the virtual machine does not actually recognize and utilize generic classes or methods. A process, known as _type erasure_, is performed to convert generic classes and methods in Java source code into non-generic forms that the virtual machine can understand.

The basic algorithm for type erasure is explained with the following pseudocode:

```
if( the type parameter has a bound ){

  replace the type parameter with the bound itself.

}else{

  replace the type parameter with Object.

}
```

Consider the following generic `Pair` class as an example:

```java
public class Pair<T, S>{
  private T first;
  private S second;

  public Pair(T first, S second){
    this.first = first;
    this.second = second;
  }

  public T getFirst(){
    return this.first;
  }

  public T getSecond(){
    return this.second;
  }
}
```

This generic `Pair` class is transformed into the following "raw" class after type erasure:

```java
public class Pair{
  private Object first;
  private Object second;

  public Pair(Object first, Object second){
    this.first = first;
    this.second = second;
  }

  public Object getFirst(){
    return this.first;
  }

  public Object getSecond(){
    return this.second;
  }
}
```

You'll notice that both of the generic type parameters (`T` and `S`) for the `Pair` class are transformed into `Object`. As explained in the algorithm's pseudocode earlier, a type parameter is converted into `Object` if it is unbounded.

Let's take a look at another example that demonstrates the same algorithm applied to a generic method with a bounded type parameter:

```java
public static <T extends Comparable> T min(T[] input){
  T smallest = input[0];

  for(int i = 0; i < input.length; i++){
    if(input[i].compareTo(smallest) < 0){
      smallest = input[i];
    }
  }
  return smallest;
}
```

The result after type erasure is performed for the `min` method is as seen below:

```java
public static Comparable min(Comparable[] input){
  Comparable smallest = input[0];

  for(int i = 0; i < input.length; i++){
    if(input[i].compareTo(smallest) < 0){
      smallest = input[i];
    }
  }
  return smallest;
}
```


Since the type parameter of the `min` method was bounded to all types that implement the `Comparable` interface, the type parameter was replaced with `Comparable` itself.

Although type erasure happens under the covers, it is important for engineers like you and I to know how type erasure works. This understanding is especially useful when running into scenarios where you find that you _can't_ use generic type parameters. In other words, having knowledge of how type erasure works can aid you when running into the limitations of generics in Java.
