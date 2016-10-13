### Anonymous Classes

In all of the time I have spent writing Java over the years,
I had never stumbled across `anonymous classes` until just recently.
Immediately, when I read over some code demonstrating the concept
it felt foreign, so I dug in and did some research.

#### Syntax

```java
public interface IDrivable{

  public void drive();

  public void stop();

}
```

```java
IDrivable drivableThing = new IDrivable(){

  private double speed;

  public double getSpeed(){
    return this.speed;
  }

  public void drive(){
    speed = 50.0;
  }

  public void stop(){
    speed = 0.0;
  }

};
```

To some of you (including myself), this looked very strange to me when I first saw it. In particular, the `new IDrivable()` portion made me look twice. Are we really creating a new instance of an interface?

I felt that the author of `Absolute Java` explained this best:

> The `new` is sensible enough but what's the point of [`IDrivable()`]? It looks like this is an invocation of a constructor for [`IDrivable`]. But [`IDrivable`] is an interface and has no constructors. The meaning of [`new Drivable()`] is simply [`implements IDrivable`] - Walter Savitch; Absolute Java 4th Edition; Page 735

So in other words, the author is explaining that an object is created by providing a class definition of the object to be created as an expression, and this class definition implements `IDrivable`.

Still feels a little weird? I don't blame you, but hopefully understanding _how_ these classes are used can put the pieces together.

### Usage

The main question I had after seeing the syntax on anonymous classes was just: _why?_

#### Callbacks

The most pronounced reason for anonymous classes revolves around the goal of creating _callbacks_ in Java.

What is a callback?

>A callback is a mechanism for bundling up a block of code so that it can be invoked at a later time. - Cay Horstmann; Big Java 4th Edition; Page 381

Basically, there are times when it makes sense to provide a class an _action_ to perform to make it more generic. I think the best way to illustrate this is by showing how callbacks can be implemented without anonymous classes, and iteratively show how anonymous classes can make this more efficient.

##### Iteration #1 - Using "External" Named Classes

Assume you have the following class:

```java
public class Garage{

  private ArrayList<Vehicle> vehicles;
  private Vehicle nicestVehicle;

  public Garage(){
    this.vehicles = new ArrayList<Vehicles>();
  }

  public void addVehicle(Vehicle vehicle){
    this.vehicles.add(vehicle);
    if(this.nicestVehicle == null || this.nicestVehicle.value() < vehicle.value()){
        this.nicestVehicle = vehicle;
    }
  }

}
```

Pretty simple. We have a garage, which is comprised of a collection of vehicles. We naturally care about which car in our garage is the nicest.

However, as we collect vehicles over the years, we realize that the value of the vehicles fluctuates. Since we are motivated to know what vehicle in our garage is the nicest, we decide we should have our collection of vehicles in our garage appraised by appraisers.

But each appraiser has a different methodology of calculating the value of the vehicles.

Let's take a look at the following interface:

```java
public interface IAppraiser{

  public double appraise(Vehicle vehicle);

}
```

Each appraiser performs the same action (appraise!). Therefore, each type of appraiser would `implement IAppraiser`. However, the way they appraise, is different. Let's make some tweaks to our `Garage` to accommodate.

```java
public class Garage{

  private ArrayList<Vehicle> vehicles;
  private Vehicle nicestVehicle;
  private IAppraiser appraiser;

  public Garage(IAppraiser appraiser){
    this.vehicles = new ArrayList<Vehicles>();
    this.appraiser = appraiser;
  }

  public void addVehicle(Vehicle vehicle){
    this.vehicles.add(vehicle);
    if(this.nicestVehicle == null || this.nicestVehicle.value() < this.appraise(vehicle)){
      this.nicestVehicle = vehicle;
    }
  }

}
```

And lastly, lets introduce one of the appraisers we are going to use:

```java
public class BobTheAppraiser implements IAppraiser{

  //bob believes that cars made in 1960
  //or prior are worth more.
  public double appraise(Vehicle vehicle){
    if(vehicle.getYear() <= 1960){
      return 10000.00;
    }
    return 5000.00;
  }
}
```

Now let's revisit that definition of a _callback_. The new implementation of the `Garage` class utilizes the code bundled in the implementation of the `appraise(Vehicle vehicle)` method (for example, in the `BobTheAppraiser` class) whenever it so chooses (at a later time; when vehicles are added to the garage). That means that the `appraise(Vehicle)` method is a callback!

```java
public class GarageLand{

  public static void main(String[] args){

    IAppraiser bobTheAppraiser = new BobTheAppraiser();

    Garage myGarage = new Garage(bobTheAppraiser);

    Vehicle corvette = new Vehicle();

    myGarage.addVehicle(corvette);
  }

}
```

##### Iteration #2 - Using Inner Named Classes

~~Now that we have our callback structure set up, we begin to feel that this design has become rather trivial. Essentially we have required that in order to know what the nicest car in our garage is, we have to consult an `IAppraiser`. We also realize that the only responsibility of the `IAppraiser` is, well, to appraise the vehicles in the garage. No other logic in our program/application cares about `IAppraiser`.~~

Noticing that our `BobTheAppraiser` class has a very limited and trivial purpose specific to the `Garage` class, we are going to move its class definition _inside_ of `GarageLand` :

```java
public class GarageLand{

  class BobTheAppraiser implements IAppraiser{

    public double appraise(Vehicle vehicle){
      if(vehicle.getYear() <= 1960){
        return 10000.00;
      }
      return 5000.00;
    }

  }
  public static void main(String[] args){

    IAppraiser bobTheAppraiser = new BobTheAppraiser();

    Garage myGarage = new Garage(bobTheAppraiser);

    Vehicle corvette = new Vehicle();

    myGarage.addVehicle(corvette);
  }

}
```

Moving the class definition of `BobTheAppraiser` into the `GarageLand` class definition makes the statement that the `BobTheAppraiser` is only useful within the scope of its outer class. The `BobTheAppraiser` class is available to all methods with the `GarageLand` class.

We could also choose to place the class definition of `BobTheAppraiser` even closer to where it is consumed by `Garage` instances; in the `main` method of `GarageLand`:

```java
public class GarageLand{

  public static void main(String[] args){

    class BobTheAppraiser implements IAppraiser{

      public double appraise(Vehicle vehicle){
        if(vehicle.getYear() <= 1960){
          return 10000.00;
        }
        return 5000.00;
      }

    }

    IAppraiser bobTheAppraiser = new BobTheAppraiser();

    Garage myGarage = new Garage(bobTheAppraiser);

    Vehicle corvette = new Vehicle();

    myGarage.addVehicle(corvette);
  }

}
```

As you might imagine, this takes the concept a little further by restricting the scope of the `BobTheAppraiser` class to the `main` method of the `GarageLand` class. At this point, we have essentially realized that the only place where the `BobTheAppraiser` class is useful is within the `main` method of `GarageLand`.

##### Iteration #3 - Anonymous classes

You may be wondering, why at this point are we even identifying the `BobTheAppraiser` class by name? We are constructing a single instance of `BobTheAppraiser` so that we can apply it to any number of `Garage` instances
we have so that we their collection of cars can be appraised. Most importantly, we created the `BobTheAppraiser` so that we could have an implementation of the `IAppraiser` interface to provide to `Garage`.

Finally we have reached the punchline; the solution is an _anonymous class_:

```java
public class GarageLand{

  public static void main(String[] args){

    //anonymous class!
    IAppraiser bobTheAppraiser = new IAppraiser{

      public double appraise(Vehicle vehicle){
        if(vehicle.getYear() <= 1960){
          return 10000.00;
        }
        return 5000.00;
      }

    };

    Garage myGarage = new Garage(bobTheAppraiser);

    Vehicle corvette = new Vehicle();

    myGarage.addVehicle(corvette);
  }

}
```

And there you have it! No need for a named class definition outside of `GarageLand`, inside of `GarageLand`, or even inside of the only method in `GarageLand`. Since all we needed was an _action_ (to appraise vehicles) to be provided to another class `Garage` to be executed whenever `Garage` wanted, we construct a one-time object that implements the `IAppraiser` interface and provide it to `Garage` instances so that they can invoke its `appraise(Vehicle vehicle)` method whenver they so choose.

Typically, anonymous classes are used to construct a one-time object that implements an interface. However, it is important to know that anonymous classes are not limited to interfaces.
