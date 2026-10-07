@def title = "Introduction"

[↑ Contents](/cs/haskell/)

# [Haskell](/cs/haskell/)

## 1. Introduction

Haskell is probably the best functional programming language for education, though my experience with Haskell is probably different from programmers. I was trying to learn theorem formalization with Lean, when I realize that it would be painful if I know nothing about functional programming.

And Haskell is exactly the missing piece: on the one hand its static type system and type classes are so mathematically satisfying that it leads naturally to theorem provers like Lean and Agda; on the other hand many of its ideas were absorbed in modern languages like Rust and Swift.

Haskell became one of my favorite languages, and believe it or not, it is not so difficult despite its reputation. In this introduction, we cover the basics.

The main difference between imperative and functional programming is probably that functional programming does not allow variables. Every value is constant, so there is no loop for us to update a value. We can declare values as follows:

```Haskell
x :: Int -- Machine-sized integers
x = 0

y :: Integer -- Arbitrary precision integers
y = 1

a :: Float -- 32-bit floating-point numbers
a = 1.5

b :: Double -- 64-bit floating-point numbers
b = 4.5

c :: Char -- Characters
c = 'A'

s :: String -- Strings are just Char lists
s = "Hello"

l :: [Int] -- Int lists
l = [1, 2, 3]
```

As the examples above, types are in Pascal cases, and comments are followed by `--`. We also have functions:

```Haskell
double :: Int -> Int 
double n = 2 * n
```

To apply functions, simply put the argument behind the function separated by whitespace.

```Haskell
m :: Int
m = double 2 -- 4
```

Multi-argument functions are defined as follow:

```Haskell
add :: Int -> Int -> Int
add a b = a + b
```

The type `A -> B -> C` means that given `a :: A`, we output a function `B -> C`. In the `add` function above, `add a` is simply a function sending `b :: Int` to `a + b`. This notation is right associative, in other words `A -> B -> C -> D -> E` is the same as `A -> (B -> (C -> (D -> E)))`.

Functions are first-class citizens, means we can pass them around like ordinary types. For example if we define

```Haskell
apply :: (Int -> Int) -> Int -> Int
apply f x = f x
```

then `apply double 2` evaluates to `4`. There is another way to write functions,

```Haskell
double' :: Int -> Int
double' = \x -> 2 * x
```

the expression `\x -> 2 * x` is called a closure or lambda expression. I have heard that they use the backslash so that `\x` resembles $\lambda$.
