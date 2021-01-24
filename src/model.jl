function drug_transport_organ!(u, p, t)
    F, Cart, P, V = p
    F*(Cart - u/(P * V))
end

""" 
Physiologically based pharmacokinetic model (PBPM)

https://en.wikipedia.org/wiki/Physiologically_based_pharmacokinetic_modelling
"""
function physio_pharma_drug_transport!(du, u, p, t)
    Cart, F, P, V = p
    for i in 1:length(du)
        p_i = (Cart, F[i], P[i], V[i])
        du[i] = drug_transport_organ!(u[i], p_i, t)
    end
    nothing
end

