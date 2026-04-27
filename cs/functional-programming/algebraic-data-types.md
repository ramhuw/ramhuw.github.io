@def title = "Algebraic Data Types"

[↑ Contents](/cs/functional-programming/)

# Algebraic Data Types

Algebraic data type is the super power how functional programming languages define abstract mathematical structures. We will use Haskell for illustration since its design is the purist. Since most of the definitions already exist in Haskell, you might want to give a new name when trying yourself.

## Let There Be Light

Irresponsibly speaking, a *type* in type theory is like a set in set theory, where the world is made up of elements each with some type. In Haskell, you may find types like the natural numbers `Natural`, and "`Zero` has type `Natural`" is written as `Zero :: Natural`. A more standard type theoretical notation would be to use a single colon `Zero : Natural`, which appears in Lean and Agda. But Haskell is using the `:` symbol for something else, we just need to get used to it.

Note that `Zero :: Natural` is not a condition "whether `Zero` has type `Natural` or not", this expression in Haskell is merely a signature that the variable `Zero` has type `Natural`. We will see how to create an instance of a type later, before that we still have to understand how to create a type. This is done in Haskell with the keyword `data`. The simplist types `Void` is the one with absolutely no information, so nothing can have type `Void`, this is like an empty set. To define it simply write:
```haskell
data Void
```
Here `Void` is simply a name, you can replace it if you want. Nothing follows `Void` implies that there is no way to construct anything with type `Void`.

To actually build something meaningful we need a *constructor*. Roughly speaking, a constructor is an injective function, and given a constructor we can define a type formed by all its return values, and these are the only way you can construct something of this type. You probably won't understand what this means untill I show you examples. A type `Unit` with only one possible element can be defined as follows:
```haskell
data Unit MkUnit
```
the built-in definition is actually
```haskell
data () = ()
```
and I will explain it later. For now we will use the custom `Unit` type instead. The `MkUnit` is the name we give to represent a constructor. It is possible to replace either `Unit` or `MkUnit` with any other name. Now let's look at `MkUnit`, it is followed by nothing, and the entire definition means we are defining a type `Unit` which has one constructor `MkUnit`, and this constructor takes 0 arguments.

Let's first see why this is natural. For $A$ a set with cardinality $\# A$, the Cartesian product $A^n, n \in \mathbb Z_+$ has cardinality $(\# A)^n$, it is a standard convention to identify $A^0$ with the singleton $\{*\}$. This convention has meaning beyond cardinality coincidence. If consider another set $B$ with cardinality $\# B$, the maps
$$
    A^n \to B
$$
 can be thought of as functions with $n$ arguments. What happens if there is no argument at all? A 'function' with no input can easily be identified with an element in $B$, but this is the same as functions
$$
    \{*\} \to B.
$$
Back to our type definition. We are defining `Unit` to be the type that can only be constructed using the return values of a injective function `MkUnit`, which has no input. If follow the set theoretical analogy, we can see that `Unit` must be the injective image of a singleton, which must itself be a singleton.

@@further-reading
In languages like C there are functions with return type `void`, they are used when we don't expect a return value. This `void` however, is actually a singleton type similar to our `Unit` in Haskell. Since we don't expect a return value, it is safe to always return the only value with type `Unit`. If a Haskell function returns a `Void`, since nothing has type `Void`, there is no way the function to return normally.
@@

But wait! How can we defining the singleton `Unit` using another singleton? It seems circular. In set theory, we don't have this difficulty since there is always an explicitly constructed singleton $\{\varnothing\}$, where $\varnothing$ is the empty set. We are not going to use set theory since it is not native for computers. The ZFC axioms simply declare the existence of certain sets, while computers prefer solid constructions. And type theory is exactly the answer. I will now explain how the construction of `Unit` works both in math and in coding.

@@further-reading
**Construct $\{\varnothing\}$ from ZF axioms.** This is an interesting exercise!
@@






---

[↑ Contents](/cs/functional-programming/)