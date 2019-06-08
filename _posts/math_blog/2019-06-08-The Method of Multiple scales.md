---
layout: post
author: Aakash Gupta
---
Consider the Duffing oscillator

$$\ddot{x} + x + \epsilon x^3 = 0$$

with boundary conditions $x(0) = 0, \ \dot{x}(0) = 1$.

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

This gives 

$$x_0\left( T_0, T_1\right) = P\left(T_1\right) \sin\left(T_0 + Q(T_1)\right)$$

Now, we take $\epsilon$ order term and substitute the solution for $x_0$ and simplify to obtain, 

$$  x_1+{\partial^2 x_1\over\partial{T_0}^2 }+\frac{1}{4}\left(8 P' \cos (Q+{T_0})-8 P Q' \sin (Q+{T_0})+3 P^3 \sin (Q+{T_0})-P^3 \sin (3 Q+3 {T_0})\right) = 0$$

Since the solution should be bounded, we make the coefficient of $\cos(Q+T_0)$ and $\sin(Q+T_0)$ (called secular terms) $0$, otherwise the solution will blow up. Therefore, we obtain, 

$$P^\prime = 0$$
and 
$$3P^3 - 8PQ^\prime = 0$$

this gives

$$P = C_1$$
and 

$$Q = {3\over 8} T_1 C_1^2 + C_2$$

now $T_1 = \epsilon T_0$ and $T_0 = t$, therefore, 

$$x_0 = P \sin\left(t + Q\right) = C_1\sin\left(t+ {3\over 8}\epsilon t C_1^2 + C_2 \right)$$ 

applying boundary conditions, 

$$x(0) = 0 \Rightarrow C_1 \sin(C_2) = 0,$$
$$\dot{x}(0) = 1 \Rightarrow C_1 \left(1 + {3\over 8}\epsilon C_1^2\right)\cos\left(t+ {3\over 8}\epsilon t C_1^2 + C_2 \right) =1$$

we compare the leading order terms with leading order and $\epsilon$ order terms with itself, and obtain,

$$C_2 = 0, \ C_1 = 1 $$

Therefore the leading order solution will give,

$$x(t) = \sin\left({1+{3\over 8}\epsilon}\right)t $$
