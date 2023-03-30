# ED_XXZ

This is the code to conduct block diagonalization and set the binary basis for 1D XXZ model

by using two libraries of Julia, which are BitBasis and LinearAlgebra.

BitBasis : https://docs.juliahub.com/BitBasis/Iufdn/0.7.0/tutorial.html

LinearAlgebra : https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/

## $L=8, \ N=4, \Delta = 1/2$

ED result for 1D XXZ chain with 8 sites and 4 particles and $\Delta = 1/2$.

![alt text](https://github.com/BOS-Bae/ED_XXZ/blob/main/L8N4Dh.png?raw=true)

x-axis means eigenstate index which is diveded by dimension of basis, and

y-axis shows energy eigenvalues.

## Reference

I referred to pseudocodes in the following paper in writing this ED code.

https://doi.org/10.3938/jkps.76.670 : 'Guide to Exact Diagonalization Study of Quantum Thermalization (Jung-Hoon Jung and Jae Dong Noh, 2020)'