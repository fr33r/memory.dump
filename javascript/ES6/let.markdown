## `let`

With the ES6 specification comes the `let` keyword. `let` provides the ability
to create variables that are attached to the surrounding _block scope_. This
contrasts with `var`, which declares variables and attaches them to the surrounding
_function scope_.

```javascript
var a = 2;

{ //enclosing scope.
  let a = 3;
  console.log(a); //3
}

console.log(a); //2
```

#### The Standalone Block Pattern

Although not common, it is has been recommended by well regarded members of the JavaScript community to make use of the _standalone block_ as shown above when utilizing `let`. As stated by Kyle Simpson, in his booked titled _ES6 & Beyond_, constructing `let` declarations without a _standalone block_ surrounding it closely mimicks its `var` counterpart because it "hijacks" whatever outer scope it is surrounded by, just as `var` "hijacks" whatever function scope it is surrounded by. He labels this behavior as _implicit_ block scoping, and the _standalone block_ pattern as _explicit_ block scoping.

Kyle Simpson takes it a step further, suggesting that  `let` declarations should also be the first statements in a standalone block. Ideally, several `let` declarations could be consolidated into one line:

```javaScript
{
  let a = 2, b, c;
  //...
}
```

He argues that this style is emphasizes that the block's intent is purely to scope the variables created using `let`, and ultimately enhancing the explicitness of the block scoping.

I do find Kyle's perspective interesting, and have always been a practitioner of explicitness in my code. However, I feel that his advice may play more in favor of engineers that have spent the majority of their careers using JavaScript (ES5 and prior). Coming from languages such as Java and C#, block scoping is heavily
engrained and natural. Variable declarations in these languages are strikingly similar to how `let` behaves, and don't even offer a variable declaration mechanism similar to JavaScript's `var`.

#### `let` and `for`
