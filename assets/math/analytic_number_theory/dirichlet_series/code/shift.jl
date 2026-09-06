# This file was generated, do not modify it. # hide
using CairoMakie

fig = Figure()
ax = Axis(fig[1, 1],
    title = "Contour Shifting",
    xlabel = L"\sigma",
    xlabelsize = 20,
    ylabel = L"t",
    ylabelsize = 20,
    titlesize = 24)
save(joinpath(@OUTPUT, "shift.svg"), fig)