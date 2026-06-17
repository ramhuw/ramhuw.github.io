# This file was generated, do not modify it. # hide
using CairoMakie
#hideall
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