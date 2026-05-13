@def title = "Dirichlet Series"
@def tags = ["number theory", "analytic number theory"]

[↑ Analytic Number Theory](/math/analytic_number_theory/)

# Dirichlet Series

\toc

## Motivation

Given a positive integer $n$, what is the number of its divisors? This problem appears constantly in coding challenges. Write this number of divisors into a condense form
$$
    d(n) \coloneqq \sum_{d \mid n} 1, \quad n \in \mathbb Z_+
$$
and let us also define this as a function in Julia with `Primes.jl` and plot the first values with `CairoMakie.jl`

```julia:./code/divisor_count
using Primes
using CairoMakie

function d(n)
    prime_factors = factor(n)
    count = 1
    for (_, e) in prime_factors
        count *= (e + 1)
    end
    count
end

N = 100
ns = 1:N

fig = Figure()
ax = Axis(fig[1, 1],
    xlabel = L"n",
    ylabel = L"d(n)",
    xlabelsize = 20,
    ylabelsize = 20,
    title = "Number of divisors",
    titlesize = 24)

stem!(ax, ns, d.(ns); label=L"$d(n)$")

axislegend(ax;
    position = :lt,
    framevisible = true,
    labelsize = 20)

save(joinpath(@OUTPUT, "divisor_count.svg"), fig)
```

\fig{divisor_count}

Seems quite random, however in this article we will discuss the following striking asymptoticity obtained by Dirichlet in 1849

$$
    \sum_{n \leq x} d(n) \sim x \log x, \quad x \to +\infty
$$

as plotted

```julia:./code/asymtote
using CairoMakie

N = 100
ns = 1:N

function sumd(x)
    sum([d(n) for n in 1:floor(x)])
end

function xlog(x)
    x * log(x)
end

fig = Figure()
ax = Axis(fig[1, 1],
    xlabel = L"x",
    ylabel = L"\sum_{n \leq x} d(n)",
    xlabelsize = 20,
    ylabelsize = 20,
    title = "Asymtote",
    titlesize = 24)

stem!(ax, ns, sumd.(ns); label=L"$\sum_{n \leq x}d(n)$")
lines!(ax, ns, xlog.(ns); color=:red, label=L"$x \log x$")

axislegend(ax;
    position = :lt,
    framevisible = true,
    labelsize = 20,
    rowgap = 4)

save(joinpath(@OUTPUT, "asymtote.svg"), fig)
```

\fig{asymtote}

As shown above, the asymptotic formula is already evident for $n \leq 100$.

The correct way to study $\sum_{n \leq x}d(n)$ is through its Dirichlet series $L(s, d) \coloneqq \sum_{n > 0} d(n)/n^s$. I will present two reasons to introduce Dirichlet series: they capture the algebraic structure behind $d(n)$, and their poles and zeros reflects the behavior of $\sum_{n \leq x} d(n)$ as $x \to +\infty$. This topic will motivate the study of analytic number theory.

## Arithmetic Functions and Dirichlet Series



Let us extract the obvious information from the definition $d(n) = \sum_{d \mid n} 1$: it is a function defined on $\mathbb Z_+$, and the sum is over divisors. This abstracts into the following definition.

*Definition.* The commutative ring of **arithmetic functions** is the set of functions
$$
    \mathcal A \coloneqq \{f: \mathbb Z_+ \to \mathbb C\}
$$
equipped with pointwise addition and multiplication given by convolution

$$
    f * g(n) \coloneqq \sum_{d \mid n} f(d) g(n/d).
$$

The function
$$
\delta(n) = \left\{ \begin{array}{ll}
  1, & n = 1, \\
  0, & n > 1.
\end{array} \right.
$$
serves as unity.

For every arithmetic function $a(n)$ there is an associated Dirichlet series $\sum_{n > 0}a(n)/n^s$. For now just ignore the convergence issue and consider this as a foraml series. The ring of formall Dirichlet series is nothing but $\mathbb C \llbracket \Z_+ \rrbracket$, the complete monoid algebra of the multiplicative monoid $(\Z_+, \times)$. Our association defines a ring isomorphism
$$
    \mathcal A \cong \C \llbracket \Z_+ \rrbracket, \quad a \mapsto L(s, a) \coloneqq \sum_{n > 0} \frac{a(n)}{n^s}
$$
this would be clear once we notice that for the function
$$
    \delta_m(n) = \delta(n - m)
$$
there is
$$
    \delta_l * \delta_m = \delta_{lm}.
$$

*Remark.* Mapping $1/p^s$ to $x_p$ for each prime $p$ gives an isomorphism $$\C \llbracket \Z_+ \rrbracket \cong \C \llbracket z_2, z_3, z_5, z_7, \dots \rrbracket$$
where the right-hand side is the formal power series ring of independent variables indexed by prime numbers.

Now consider the constant function $\mathbf{1}(n) = 1$, we immediately check that $d = \mathbf{1} * \mathbf{1}$, which means $L(s, d) = L(s, \mathbf{1})^2$. This $L(s, \mathbf{1})$ is better known as the **Riemann $\zeta$ function**, the central object of analytic number theory. We will study the very basics of $\zeta(s)$, then $\zeta(s)^2$ comes for free. But that will not be helpful unless we understand how $L(s, a)$ can be used to study $\sum_{n \leq x} a(n)$.

## Perron's Formula

If the Dirichlet series $L(s, a) = \sum_{n > 0} a(n)n^{-s}$ converges absolutely at some $s \in \C$, then convergence is guaranteed at every point to the right of $s$. If we define 
$$
    \sigma_a \coloneqq \inf \{\Re s \mid \text{$\sum_{n > 0} a(n) n^{-s}$ converges absolutely}\}
$$
the Dirichlet series will converge as long as $\Re s > \sigma_a$.

Assume $\Re s > \sigma_a$ and apply [Abel's summation formula](https://en.wikipedia.org/wiki/Abel%27s_summation_formula#Reciprocal_of_Riemann_zeta_function), we have
$$
\sum_{n > 0} \frac{a(n)}{n^s} = s \int_1^{+\infty} A(x) x^{-s - 1} \dd x
$$
where $A(x) = \sum_{n \leq x} a(x)$. Absolute convergence is necessary since we need to interchange summation and integral.

After a change of variable $x = \ee^t$, we see that $L(s, a)/s$ is the Laplace transform of $A(\ee^t)$:
$$
    \frac{L(s, a)}{s} = \int_0^{+\infty} A(\ee^t) \ee^{-st} \dd t.
$$
Apply the [inverse Laplace transform](https://en.wikipedia.org/wiki/Inverse_Laplace_transform#cite_note-3) and we get
$$
    \frac{A(x^-) + A(x^+)}{2} = \frac{1}{2\pi \ii}\int_{c - i \infty}^{c + i\infty} L(s, a) \frac{x^s}{s} \dd s.
$$
where $c$ is any real number larger than $\_sigma_a$. The left-hand side is often written as $\sum'_{n \leq x} a(n)$, the only difference from the usual $\sum$ is that when $x$ is an integer, the last term $a(x)$ is replaced by $a(x)/2$. The above equality is called **Perron's formula**.

## Contour Shifting

The Perron formula is exact, but it gives no information unless we can find the dominant terms. The idea is to shift the integral contour left to get a smaller integral, while the singularities crossed should contribute to the dominant terms. 

Take $a = \mathbf{1}$ for example, in this case $A(x) = \lfloor x \rfloor \sim x$ is obvious, so we expect to obtain the same result from Dirichlet series $L(s, \mathbf{1}) = \zeta(s)$. The series
$$
    \frac{1}{1^s} + \frac{1}{2^s} + \cdots
$$
converges for $\Re s > 1$, and has a pole at $s = 1$. But what is to the left of this pole? The hope is to find a meromorphic function extending $\sum_{n > 0}n^{-s}$ so that we can define $\zeta(s)$ on the points to the left of $s = 1$. This is called a **meromorphic continuation**. It turns out that $\zeta$ has a meromorphic continuation to the entired complex plane But for our purpose, we just need to extend $\zeta$ a little bit left, and the treatment is much easier.

Consider the alternating sum
$$
D(s) = \sum_{n > 0} (-1)^{n-1}n^{-s} = 1 - 2^{-s} + 3^{-s} - 4^{-s} + \cdots
$$
which converges for $\Re s > 0$ (uniformly in compact subsets). The trick is
$$
    \zeta(s) - D(s) = 2 * (2^{-s} + 4^{-s} + 6^{-s} + \cdots) = 2^{1 - s} \zeta(s)
$$
and therefore
$$
    \zeta(s) = \frac{D(s)}{1 - 2^{1-s}}
$$
for $\Re s > 0$. The possible poles are from the zeros of $1 - 2^{1-s}$, i.e. $s = 1 + \frac{2 \pi \ii}{\log 2}m, m \in \Z$. Only $s = 1$ is a pole and to show this we consider another function
$$
\tilde{D}(s) = 1 + \frac{1}{2^s} - \frac{2}{3^s} + \frac{1}{4^s} + \frac{1}{5^s} - \frac{2}{6^s} + \cdots = (1 - 3^{1-s})\zeta(s)
$$
which gives a different expression
$$
\zeta(s) = \frac{\tilde D(s)}{1 - 3^{1-s}}.
$$
Now the possible poles are of the form $s = 1 + \frac{2\pi \ii}{\log 3}m, m \in \Z$. Now that $\gcd(2, 3) = 1$, the quotient $\frac{\log 3}{\log 2} = \log_2 3$ cannot be a rational number, so $s = 1$ is the only pole. We may plot the $\zeta$ function as follows, the color reflects argument, and brightness reflects absolute value.

```julia:./code/zeta_domain_coloring
using CairoMakie, SpecialFunctions, Colors

# the domain
σs = range(0, 2, length=200)    # real part
ts = range(-1, 1, length=200)  # imaginary part

# evaluate ζ on the grid
Z = [zeta(σ + im*t) for σ in σs, t in ts]

# color each point by hue (arg) and lightness (|ζ|)
function domain_color(z)
    h = (angle(z) / (2π) + 1) % 1        # hue from arg, in [0,1)
    m = abs(z)
    # smoothly map magnitude to lightness: log scale, capped
    l = 0.5 + 0.5 * (2/π) * atan(log(m + 1e-10))
    return HSL(h * 360, 0.85, clamp(l, 0.1, 0.9))
end

img = domain_color.(Z)

fig = Figure(size=(400, 400))
ax = Axis(fig[1, 1],
    xlabel = L"\sigma",
    ylabel = L"t",
    title  = L"\zeta(\sigma + it)",
    aspect = DataAspect()
)

image!(ax, (0, 2), (-1, 1), img; interpolate=false)

save(joinpath(@OUTPUT, "zeta_domain_coloring.png"), fig)
```

\fig{zeta_domain_coloring}


## References

* \biblabel{apostol76}{Apostol (1976)} **T. M. Apostol**, *Introduction to Analytic Number Theory*, Undergraduate Texts in Mathematics, Springer, New York, 1976. DOI: [10.1007/978-1-4757-5579-4](https://doi.org/10.1007/978-1-4757-5579-4).

* \biblabel{sorensen25}{Sorensen (2025)} **C. Sorensen**, *From Classical L-Functions to Modern Reciprocity Laws*, Graduate Texts in Mathematics **307**, Springer, Cham, 2025. DOI: [10.1007/978-3-032-03035-1](https://doi.org/10.1007/978-3-032-03035-1).