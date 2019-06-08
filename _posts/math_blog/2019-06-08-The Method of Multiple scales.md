---
layout: post
author: Aakash Gupta
---
Consider the Duffing oscillator

$$\ddot{x} + x + \epsilon x^3 = 0$$

To find an approximate analytical solution, we will use the method of multiple scales.
Here $\epsilon$ is a small number $(<<1)$ and the oscillator is normalized appropriately to get the above form.
We start by defining two time steps $T_0 = t$ (the original time scale) and $T_1 = \epsilon t$ and treat them as independent variables.
So, the solution of the oscillator $x$ will be of the form $x(T_0, T_1)$. 
Therefore, 

$$\dot{x} = {\partial{x}\over \partial{T_0}} + \epsilon {\partial{x}\over \partial{T_1}} $$

