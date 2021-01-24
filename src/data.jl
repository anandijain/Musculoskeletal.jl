# using Pkg

# pkg"add SparseArrays, DifferentialEquations, CSV, DataFrames"
# pkg"add FileIO, MeshIO, Makie"

using CSV, DataFrames, SparseArrays

using GeometryBasics

using CUDA
using FileIO, MeshIO
using Makie # doesn't work if no GPU :(

# citations 
# "Human Femur" (https://skfb.ly/6ursH) by Eric Bauer is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).

# https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.2002811
# Citation: Murphy AC, Muldoon SF, Baker D, Lastowka A, Bennett B, Yang M, et al. (2018) Structure, function, and control of the human musculoskeletal network. PLoS Biol 16(1): e2002811. https://doi.org/10.1371/journal.pbio.2002811


# not adj mat b/c edges can connect more than two nodes 
function get_inc_mats()
    df, df2 = CSV.read.(["data/s9.csv", "data/s10.csv"], DataFrame)
    v1, v2 = df[1:end, 3:end], df2[1:end, 3:end]
    m1, m2 = Matrix.([v1, v2])
    replace!.([m1, m2], missing=>0, "1"=>1, " "=>0)
    bm1 = Bool.(m1)
    bm2 = Bool.(m2)
    sparse.([bm1, bm2])
end


m, m2 = get_inc_mats()

x = load("data/Femur.stl") # 173 MB

typeof(x)

plot(x)
