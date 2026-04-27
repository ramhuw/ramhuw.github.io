@def title = "Algebraic Data Types"

[↑ Contents](/cs/functional-programming/)

# Algebraic Data Types

Algebraic data type is the super power how functional programming languages define abstract mathematical structures. We will use Haskell for illustration since its design is the purist. Since most of the definitions already exist in Haskell, you might want to give a new name when trying yourself, or the new definition will shadow the built-in one.

\toc

## Let There Be Light, but in a Constructive Way

Irresponsibly speaking, a *type* in type theory is like a set in set theory, where the world is made up of elements each with some type. In Haskell, you may find types like the natural numbers `Natural`, and "`Zero` has type `Natural`" is written as `Zero :: Natural`. A more standard type theoretical notation would be to use a single colon `Zero : Natural`, which appears in Lean and Agda. But Haskell is using the `:` symbol for something else, we just need to get used to it.

Note that `Zero :: Natural` is not a condition "whether `Zero` has type `Natural` or not", this expression in Haskell is merely a signature that the variable `Zero` has type `Natural`. Types and sets are different in several ways, keep this in mind and we will a gain solid understanding along the way.

How do we define a type? In Haskell, you do not define a type by giving all its possible values , but the rules for the computer to create such values. We start with the keyword `data`, which is always followed by the name of the type, then `=` and the rules if any. And spaces are needed to split these tokens (not for `::` where both `Zero::Natrual` and `Zero :: Natural` would work, but adding spaces is a convention). The simplist type `Void` is the one with absolutely no rule to construct. This is analogous to an empty set. To define it simply write:
```haskell
data Void
```
Here `Void` is simply a name, you can change it if you want. It is already defined in the module `Data.Void`, so whenever you want to use it, import via
```haskell
import Data.Void
```
and defining it again with the same name `Void` will shadow the built-in version. Nothing follows `Void`, and this is exactly what we want. We are not giving any rule to construct a value of type `Void`, so any expression of the form `val :: Void` will result in an error. Since there is no rule, we do not write the `=`.

There is one thing subtle to notice. If `Void` is defined, and you define another
```haskell
data MyVoid
```
this works perfectly but `MyVoid` will not be the same as `Void`. This is one of the main difference between type theory and set theory. In set theory, the axiom of extensionality ensures that two sets are equal as long as they have the same elements. However type theory is constructive, we created two empty types with the same rules (no rule), but the compiler will not be able to see if they have the same rules. If two types $A, B$ are defined by the same rules, we say that $A$ is isomorphic to $B$ and write $A \cong B$. In a theorem prover such as Lean, you may provide a map $A \to B$ and prove that it is an isomorphism, thus identifying isomorphic types, but unfortunately in Haskell there is no proof system and you just live with all these isomorphic yet distinct types. 

To actually build something meaningful we need a *constructor*, we need it to implement a rule. Roughly speaking, a constructor is an injective function, it tells the compiler that we only admit values returned by this function to have this type. We start with a type with only one possible element :
```haskell
data MyUnit = MkUnit
```
the built-in (in the `Prelude` module, means you do not need importation to use it) definition is actually
```haskell
data () = ()
```
and I will explain why it has `()` on both sides later. For now we use the 'custom' `MyUnit` type instead. The `MkUnit` is the name we give for the constructor. You may replace either `Unit` or `MkUnit` with any other name. 

Now take a look at `MkUnit`, it is followed by nothing. And the entire definition means that we are defining a type `Unit` which has one constructor `MkUnit`, and this constructor takes 0 arguments. What can we construct with this constructor? A function that takes no input can only be a constant, meaning that there is only one way to construct a value of type `MyUnit`, that is `MkUnit` (imagine `MkUnit` is followed by empty input).

@@further-reading
In languages like C there are functions with return type `void`, they are used when we don't expect a return value. This `void` however, is actually a singleton type similar to our `MyUnit` in Haskell. Since we don't expect a return value, it is safe to always return the only value with type `MyUnit`. There is no way for a function to returns a `Void`, since nothing has type `Void`.
@@

Our definition for `MyUnit` is quite reasonable in terms of set theory. For $A, B$ two sets with cardinality $\# A, \# B$, the maps
$$
    A^n \to B
$$
 can be thought of as functions with $n$ arguments. What happens if $n = 0$? A 'function' with no input can easily be identified with an element in $B$, but this is the same as functions
$$
    \{*\} \to B.
$$
where $\{*\}$ is a set with one element $*$. The values 'constructed' by this function forms another singleton.



But wait! How can we defining the singleton `MyUnit` using another singleton? It seems circular. In set theory, we don't have this difficulty since there is always an explicitly constructed singleton $\{\varnothing\}$, where $\varnothing$ is the empty set. We are not going to use set theory since it is not native for computers. The ZFC axioms simply declare the existence of certain sets, while computers prefer solid constructions. And type theory is exactly the answer. 

@@further-reading
**Construct $\{\varnothing\}$ from ZF axioms.** This is an interesting exercise!
@@






---

[↑ Contents](/cs/functional-programming/)