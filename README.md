# Numerical-Methods-Benchmarking

This repository contains a MATLAB-based benchmarking suite that compares three fundamental numerical methods for finding roots of non-linear equations: **Newton-Raphson**, **Secant**, and **Bisection**.

## 📌 Project Overview

The project evaluates algorithms based on their convergence speed (Linear vs. Quadratic) and computational efficiency. It features a target function f(x) = e^{-x} - \sin(x) and analyzes how quickly each method approaches the root.

### Included Algorithms
* **Newton-Raphson Method:** Utilizes a numerical derivative (Finite Difference) to achieve quadratic convergence.
* **Secant Method:** A superlinear approach that approximates the derivative using two initial points.
* **Bisection Method:** A robust, interval-halving method that guarantees convergence if a sign change is detected.

## 🚀 Key Features

* **Numerical Derivative:** Uses a Finite Difference approximation ($h=1e-6$) to eliminate the need for manual analytical derivatives.
* **Performance Benchmarking:** Execution times are averaged over $N=10,000$ runs to ensure statistical stability.
* **Advanced Visualization:** * **Root Location Plot:** Visualizes the function behavior and the specific points where roots were found.
    * **Convergence Analysis:** A semi-logarithmic plot comparing the absolute error per iteration for all three methods.

## 🛠️ How to Run

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/BeratKayar/root-finding-analysis.git
    ```
2.  Open **MATLAB**.
3.  Navigate to the project folder.
4.  Run the main script:
    ```matlab
    project_main
    ```

## 📊 Comparison Summary

| Method | Convergence Type | Requirements |
| :--- | :--- | :--- |
| **Newton-Raphson** | Quadratic (Fastest) | Initial guess + Derivative |
| **Secant** | Superlinear | Two initial guesses |
| **Bisection** | Linear (Safest) | Bracketing interval $[a, b]$ |


---
*Developed in 2025 as part of a Numerical Methods & Convergence Analysis study.*
