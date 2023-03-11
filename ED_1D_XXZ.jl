using BitBasis

# config_arr = []
# ascending_arr = []

# Δ = 1.5
# L = 4

# We apply PBC on the model.

function Binary_basis_gen_arr(L)
    config_arr = []
    for i in 0:(2^L -1)
        push!(config_arr, bit(i;len=L))
    end
    return config_arr
end

function Idx_H_1D_XXZ(bit_config,Δ,L,mat_arr)
    n_l = -1; n_lp = -1; mask = -1
    diag = 0

    for i = 0:L-1
        if (i < L-1)
            n_l = (Int)(readbit(bit(bit_config;len=L),i+1))
            n_lp = (Int)(readbit(bit(bit_config;len=L),i+2))
            mask = 2^(i+1) + 2^(i)
        else
            n_l = (Int)(readbit(bit(bit_config;len=L),L))
            n_lp = (Int)(readbit(bit(bit_config;len=L),1))
            mask = 2^(0) + 2^(L-1)
        end

        diag += (2*n_l - 1)*(2*n_lp - 1)

        if n_l != n_lp
            mask = bit(mask;len=L)
            new_hop = (Int)(bit(flip(bit_config,mask);len=L))

            push!(mat_arr, [(Int)(bit_config),(Int)(new_hop),-1])
            push!(mat_arr, [(Int)(new_hop),(Int)(bit_config),-1])
        end
    end
    push!(mat_arr, [(Int)(bit_config),(Int)(bit_config),-(Δ/2)*diag])
    return mat_arr
end

function Act_H_1D_XXZ(bit_config,Δ,L,H_mat)
    n_l = -1; n_lp = -1; mask = -1
    diag = 0

    for i = 0:L-1
        if (i < L-1)
            n_l = (Int)(readbit(bit(bit_config;len=L),i+1))
            n_lp = (Int)(readbit(bit(bit_config;len=L),i+2))
            mask = 2^(i+1) + 2^(i)
        else
            n_l = (Int)(readbit(bit(bit_config;len=L),L))
            n_lp = (Int)(readbit(bit(bit_config;len=L),1))
            mask = 2^(0) + 2^(L-1)
        end

        diag += (2*n_l - 1)*(2*n_lp - 1)

        if n_l != n_lp
            mask = bit(mask;len=L)
            new_hop = (Int)(bit(flip(bit_config,mask);len=L))

            H_mat[(Int)(bit_config)+1,(Int)(new_hop)+1] = -1
            H_mat[(Int)(new_hop)+1,(Int)(bit_config)+1] = -1
        end
    end
    H_mat[(Int)(bit_config)+1,(Int)(bit_config)+1] = -(Δ/2)*diag
    return mat_arr
end

function Build_Basis_N(bit_config, basis_N, N, L)
    n_i = 0
    for i = 0:L-1
        n_i += (Int)(readbit(bit(bit_config;len=L),i+1))
    end
    if (n_i == N)
        push!(basis_N, bit_config) 
    end
end

function Build_H_N(H_tot, H_N, basis_N)
    for m in 1:length(basis_N)
        for n in 1:length(basis_N)
            row = (Int)(basis_N[m]) + 1
            col = (Int)(basis_N[n]) + 1
            H_N[m,n] = H_tot[row,col]
        end
    end
end