# This file was generated, do not modify it. # hide
#hideall
zeta_domain_coloring
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

fig = Figure()
ax = Axis(fig[1, 1],
    xlabel = L"\sigma",
    ylabel = L"t",
    title  = L"\zeta(\sigma + it)",
    aspect = DataAspect(),
    xlabelsize = 20,
    ylabelsize = 20,
    titlesize = 24
)

image!(ax, (0, 2), (-1, 1), img; interpolate=false)

save(joinpath(@OUTPUT, "zeta_domain_coloring.png"), fig)