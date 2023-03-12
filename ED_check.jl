using LinearAlgebra

include("ED_XXZ.jl")

L = 8
Δ = 1
N = 4
#k = 0
mat_arr = []

basis_N = []
basis_N_k = []

H_mat = zeros(2^L, 2^L)

config_arr = Binary_basis_gen_arr(L)
#print(config_arr)

Build_Basis_N(config_arr, basis_N, N, L)
#Idx_H_1D_XXZ(config_arr,Δ,L,mat_arr)
Act_H_1D_XXZ(config_arr,Δ,L,H_mat)

#Build_Basis_N_k(basis_N, basis_N_k, L, k)

#print(length(basis_N_k))
#println("")

#for each in mat_arr
#    m = (Int)(each[1]) + 1
#    n = (Int)(each[2]) + 1
#    val = each[3]
#
#    H_mat[m,n] = val
#end

#for m=1:2^L
#    for n=1:2^L
#        print((Int)(H_mat[m,n]),"  ")
#    end
#    print("\n")
#end
H_N_mat = zeros(length(basis_N),length(basis_N))

Build_H_N(H_mat, H_N_mat, basis_N)

println(length(basis_N))
#for m=1:2^L
#    for n=1:2^L
#        print(H_mat[m,n],"  ")
#    end
#    print("\n")
#end

#for m=1:length(basis_N)
#    for n=1:length(basis_N)
#        print((H_N_mat[m,n]),"  ")
#    end
#    print("\n")
#end

#println("")
#print(basis_N)

print(eigvals(H_N_mat))
println("")

#print(eigvecs(H_N_mat))
