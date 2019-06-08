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
and 

$$\ddot{x} = {\partial\over\partial{T_0}} \left({\partial{x}\over \partial{T_0}} + \epsilon {\partial{x}\over \partial{T_1}}\right) + \epsilon{\partial\over\partial{T_1}} \left({\partial{x}\over \partial{T_0}} + \epsilon {\partial{x}\over \partial{T_1}}\right) $$

we take only the terms till $O(\epsilon)$, hence

$$\ddot{x} = {\partial^2 x\over\partial{T_0}^2 } + 2 \epsilon {\partial^2{x}\over \partial{T_0 T_1}} $$

Also, we expand $x$ as 

$$x = x_0\left(T_0, T_1\right) + \epsilon x_1\left( T_0, T_1\right) $$

substituting all of these in the original equation, we obtain

$$\epsilon  x_0^3+\epsilon  x_1+2 \epsilon  {\partial^2{x_0}\over \partial{T_0 T_1}}+\epsilon  {\partial^2 x_1\over\partial{T_0}^2 }+x_0+{\partial^2 x_0\over\partial{T_0}^2 } + O(\epsilon^2) = 0$$

Now we make the leading order term $0$, giving us

$$x_0+{\partial^2 x_0\over\partial{T_0}^2 } = 0$$
