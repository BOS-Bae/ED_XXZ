include("ED_1D_XXZ.jl")

L = 4
N = 2^L
Δ = 3

mat_arr = []
H_mat = zeros(N, N)


config_arr = Binary_basis_gen_arr(L)

for i_config in config_arr    
    Idx_H_1D_XXZ(i_config,Δ,L,mat_arr)
    Act_H_1D_XXZ(i_config,Δ,L,H_mat)
end

#for each in mat_arr
#    m = (Int)(each[1]) + 1
#    n = (Int)(each[2]) + 1
#    val = each[3]
#
#    H_mat[m,n] = val
#end

for m=1:N
    for n=1:N
        print((Int)(H_mat[m,n]),"  ")
    end
    print("\n")
end