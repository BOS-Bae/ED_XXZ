using BitBasis

# We apply PBC on the model.

# Build basis for full spectrum.
function Binary_basis_gen_arr(L)
    config_arr = []
    for i in 0:(2^L -1)
        push!(config_arr, bit(i;len=L))
    end
    return config_arr
end

# Insert elements of null matrix to make it Hamiltonian for 1D XXZ model.
function Act_H_1D_XXZ(config_arr,Δ,L,H_mat)
    for bit_config in config_arr
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
    end
    return mat_arr
end

# Set the basis of N-particle sector.
function Build_Basis_N(config_arr, basis_N, N, L)
    for bit_config in config_arr
        n_i = 0
        for i = 0:L-1
            n_i += (Int)(readbit(bit(bit_config;len=L),i+1))
        end
        if (n_i == N)
            push!(basis_N, bit_config) 
        end
    end
end

# Block diagonalization : Insert elements (of null matrix) to make it Hamiltonian for N-sector of 1D XXZ model.
function Build_H_N(H_tot, H_N, basis_N)
    for m in 1:length(basis_N)
        for n in 1:length(basis_N)
            row = (Int)(basis_N[m]) + 1
            col = (Int)(basis_N[n]) + 1
            H_N[m,n] = H_tot[row,col]
        end
    end
end


# Function below is not completed yet.
function Build_Basis_N_k(basis_N, basis_N_k, L, k)
    
    # Move spins in the right direction.
    for bit_config in basis_N
        min_val = 0
        period_arr = []
        saved_arr = Any[]

        bit_val = bit_config

        for p in 1:L
            # p is period
            if ((Int)(bit_val) < 2^(L-1))
                bit_T = bit((2*(Int)(bit_val));len=L)
                bit_int = (Int)(bit_T)
                if (bit(bit_int;len=L) == bit_config)
                    push!(saved_arr, [bit_int, p])
                    push!(period_arr, p)
                    println(bit(bit_int;len=L), " ",bit_val," ",p)
                end
            else
                bit_subtract = 2*((Int)(bit_val) - 2^(L-1)) + 1
                bit_T = bit((Int)(bit_subtract);len=L)
                bit_int = (Int)(bit_T)
                if (bit(bit_int;len=L) == bit_config)
                    push!(saved_arr, [bit_int, p])
                    push!(period_arr, p)
                    println(bit(bit_int;len=L), " ",bit_val," ",p)
                end
            end

            bit_val = bit(bit_int;len=L)
            #println(bit_config, " ",bit_val," ",p)
        end
        uni_period = unique!(period_arr)

        for k in 1:length(saved_arr)
            for idx in 1:length(uni_period)
                if saved_arr[k][2] == uni_period[idx]
                end
            end
        end

        min_val = minimum(saved_arr)[1]
        #println(minimum(saved_arr)[1])
        # period is minimum(saved_arr)[2]

        if (((k*minimum(saved_arr)[2]) % L == 0) && (bit_config == bit(min_val; len=L)))
            push!(basis_N_k, bit_config)
        end
    end
end