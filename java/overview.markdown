### Java Overview

The first version of Java was created in 1991 by a team at Sun Microsystems, led by James Gosling. The language was initially designed to be used on home appliances.

#### Compilation and Interpretation

Compilers are programs that essentially translate one programming language into another. It is typical to see one-step compilers, where a high level language written by the programmer is translated into machine language to be directly executed by the processor of the computer.

However, a disadvantage with this strategy is that the high level language (Java in this case) is translated directly to the machine language of _one_ machine. Different machines can have different machine languages, thus requiring a different compiler for each machine.

To mitigate this issue, the designers of Java created a _two-step_ compilation process:

1. Translate the Java source code into an _intermediate language_ (known as **byte-code** or **Java byte-code**) that is the same for all systems, regardless of the processor.
2. Using what is referred to as an **interpreter**, the byte-code produced from the first step of compilation is translated into the machine language so that it can be executed by the computer.

So how is this approach better? Walter Savitch, the author of Absolute Java 4th Edition states it well:

>Java byte-code makes your Java program very portable. After you compile your Java program into byte-code, you can use that byte-code on any computer. When you run your program on another type of computer, you do not need to recompile it. This means that you can send your byte-code over the Internet to another computer and have it easily run on that computer. - **Absolute Java 4th Edition; Page 9**

It is worth expanding on the interpretation process a little further. After the java program has been translated into byte-code and it is ready for the interpreter, the interpreter translates the byte-code into machine code _one instruction at a time_. In other words, it translates each byte-code instruction into the corresponding machine language instructions for the machine and then executes that machine code before moving on to the next byte-code instruction. The interpreter _does not_ translate the byte-code into machine level instructions all at one time.

The interpreter is also referred to as the **Java Virtual Machine** or **JVM**. In a way this terminology is sensical. In comparison to the one-step compilation process where source code is translated directly into machine code for a particular _real_ machine, the compilation of Java source code results in an intermediate language to be executed by a "virtual" or "fictional" machine.
