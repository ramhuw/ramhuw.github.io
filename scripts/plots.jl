using GLMakie

fig = Figure()
ax = Axis(fig[1, 1],
    title = "Contour Shifting",
    xlabel = L"\sigma",
    xlabelsize = 20,
    ylabel = L"t",
    ylabelsize = 20,
    titlesize = 24)