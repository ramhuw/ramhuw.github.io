# This file was generated, do not modify it. # hide
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