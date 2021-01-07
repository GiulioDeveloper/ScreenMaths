# ScreenMaths

ScreenMaths is a library written entirely in Swift and SwiftUI that allows to parse, render, evaluate and plot mathematical functions. One of the main features is that it is completely customizable and versatile. It can be used to build a native user experience for a CAS, or to dynamically use and store Math functions in your app, while showing them to the user on the screen.

# Installation

The library is available only through **Swift Package Manager** or direct download of the files in your project folder. Becuase it relies on SwiftUI, it requires iOS 14 or macOS 10.15 as your build target to work properly.

# Features

With SwiftyEquations you can: 
- Parse a string representaing a mathematical formula into a useful Swift data structure.
- Evaluate math equations using arbitrary values
- Render equations with super simple SwiftUI components, starting only from plain text!
- Enable touch interaction and visual editing of equations like you would do in app such as Photomath and Geogebra.
- Customize the visual apperaence and alignment of equations.
- Plot functions in a xy cartesian plane, with customizable aspect.

To try a simple possible implementation of these features, just check the demo folder, and see how they work!

 ### Contribution
If you have problems or you need extra features, feel free to send your request in the github form.

# How it works

## The Expression Type and the Parser

The basic data structures of the library is called Expression, and as the name tells, it represents a symple mathmatical expression. It's definition is recursive and super simple, thanks to the power of Swift: 

```swift
indirect enum Expression: Hashable, CustomStringConvertible {
    case costant(Int)
    case variable(Symbol)
    case sum([Expression])
    case product([Expression])
    case fraction(num: Expression, den: Expression)
    case exponential(base: Expression, exponent: Expression)
    case logarithm(base: Expression, argument: Expression)  
    case cosine(Expression)
    case sine(Expression)
    case tangent(Expression)
}
```

There is also a "parent" structure to this, "Container", that can be used to represent equations (that is a left expression and a right), and maybe in future also disequations.

The Expression type it's the core of all ScreenMaths's features. To get one of these objects there are two ways:
- Manually declare it using enum syntax
- Get one by parsing a string

To parse a string into an Expression you should use a TextParser object with the `parse()` method, which returns a `Result<Expression, ParsingError>`. Here's an example of how to use it:

```swift
let myExp = " 1 / (x ^ 2)"
let parsed = TextParser(input: myExp).parse()
var expression: Expression? = nil
parsed.map {
    expression = $0
}
```

The syntax of the math expressions should be the one commonly used like that of Wolphram Alpha. Parsing supports using different variables, and underscores to differentiate them, for example "v + 3" is different from "v_i + 3". The parser returns an Expression, which means that to parse something more complex you should use the GeneralParser object, which returns a container. The Expression type also supports some simple semplification functions built-in, thus, for example, "x + x" will be parsed as "2x" and "x^2 * x" as "x ^ 3".

You can evaluate an Expression by giving a value to each of the variables inside it. Here's how to use it

```swift
let myExp = " x + y_a^2"
let parsed = TextParser(input: myExp).parse()
var expression: Expression? = nil
parsed.map {
    print($0.evaluate(using: [Symbol("x") : 3, Symbol("y", kind: "a") : 5])) // Prints 28
    print($0.evaluate(using: [Symbol("x") : 3, Symbol("a", kind: "i") : 5])) // Prints nil
}
```

## UI

This is the most interesting part of the library. Here's an example of what you can get

### The Data structure

To represent math equation we must use a flexible data sturcture that supports live editing. My solution was to create a mixture of a recursive linked list and a conventional array (the latter is needed actually only because of complicated SwiftUI requirements for lists). The key types of the Data Structure are RSet, RGroup and RKey, with the accessory types MathKey, GroupKey and GroupReference.
In this image you can have a simplified scheme of the structure.

![Data Structure Scheme](https://i.ibb.co/JrhrxjM/Schema-per-Github-New-frame.jpg)

You can get one of this structure using  the `generateBuffer(in set: RSet) -> RSet` method of the Expresison type, feeding it with an empty RSet (`RSET()`). However you may need this only if you want to edit the equation. Another way is to create an empty RSet, giving the user the task to fill it.
The RSet can be converted to a text using the Converter class.

### The views

The struct you use to represent equations and expressions is MathView. You can also initialize it directly using a plain text and it will render the result without any additional configuration (this is actually achieved using a QuickMathView):

```swift
struct MathView_Previews: PreviewProvider {
    static var previews: some View {
        QuickMathView(text: "x ^ 2 + cos(3*x + cos(log(R_i , (2)/(3a / (4x))))) +y")
    }
}
```

### Editing

Once you linked an interactionManager to a MathView and linked it to a set (using interactionObject), you can edit it at runtime, or most probably let the user edit it. You should build an interface with buttons and numbers (like the ones in PhotoMath for example) and then link these buttons with the functions provided in the ButtonFunctions class. This class contains the foundamental functions to edit an RSet through an interaction manager, and you can personalize them as you need. Check the Demo Folder for an example of how to use it, here's what you'd get:

![Video](https://i.ibb.co/ypBfnWf/ezgif-com-crop.gif)


### Customization

All customization happens using environment keys. The easiest thing to customize is the scale, like follows:
```swift
    QuickMathView(text: "x ^ 2 + cos(3*x + cos(log(R_i , (2)/(3a / (4x))))) +y")
        .environment(\.mathScale, 30)
```
You can customize all the other elements through two object: Style and ElementsAspect. The first allows to customize the relative distances between the various components of the equations (exponents, brackets etc..), the other allows you to completely replace some of the default graphical elements (digits, variables, texts and placeholder). Both are set using environment keys:

```swift
    QuickMathView(text: "x ^ 2 + cos(3*x + cos(log(R_i , (2)/(3a / (4x))))) +y")
        .environment(\.mathStyle, Style())
        .environment(\.mathElementsAspect, ElementsAspect())
```

In order to create a custom ElementAspects object, you should manually code the views you want to change and make them conform to the respective protocol. For example if you want to create a custom appearence for digits, you must create an object that conforms to DigitStyle protocol. Then you create an ElementsAspect object and change the digitsAspect property, wrapping your object in a type eraser (I have already provided all the different type erasers. For DigitStyle conforming objects it is called AnyDigitStyle, and so on...). Here's an example:

```swift

public class MyCustomDigitStyle: DigitStyle {
    
    public func makeBody(digit: UInt8) -> some View {
        return Text(String(digit)).italic()
    }
    
}

let newAspect = ElementsAspect()
newAspect.digitsAspect = AnyDigitStyle(DefaultDigitStyle()) //AnyDigitStyle is the type eraser for DigitStyle objects

```

All MathViews have a generic type called "ActivatorType", which conforms to the Activator protocol. I have provided one for you, which is the default one, but you can replace it completely. Activator conforming objects change the aspect of the elements that are highlighted while editing. Here's how the default one changes the aspect of math elements based on whether they are "activated" or not:

```swift

Group {
    if activated {
        HStack {
            content
            Rectangle()
                .frame(width: 2)
                .foregroundColor(.blue)
        }
    } else {
        content
    }
}

```
You could add a loop animation to it, or whatever you want.

## Graphing
You can plot the graph of functions using the GraphShape struct, which is a SwiftUI Shape with customizable aspect. It only supports one variable, so everything that is not a keyword or a digit will be considered as an "x". The struct evaluates the function for approximately every pixel in the view, with more calculations in the steep parts and less in the flattest parts of the function.
I have also provided a GridShape, that as the GraphShape, supports traslation and scaling.
Combining the Graph and the Grid, and adding some gesture and control, you can create an experience similar to the one in the demo folder. Here's how it looks:

![Video](https://i.ibb.co/CzRrQXy/ezgif-com-gif-maker.gif)

Support for equations with two variables (ex: "cos(x^2 + y^2) = x^y") will come in future, with support for GPU computing.

