# Implements RMS-scaled backpropagation.
# Divide the learning rate for a weight by a running average of the magnitudes of recent gradients for that weight.
# Sources:
# - Tieleman, T. and Hinton, G. (2012), Lecture 6.5 - rmsprop, COURSERA: Neural Networks for Machine Learning
# - https://github.com/torch/optim/blob/07fb9e0e22c1ff1a64613b24f0ba290e710aa5bd/rmsprop.lua

rmsprop = (optimizationFunction, x, state = {}) ->
  t = LSTM.tensor
  learningRate = state.learningRate ? 1e-2
  alpha = state.alpha ? 0.99
  epsilon = state.epsilon ? 1e-8

  # (1) evaluate f(x) and df/dx
  [fx, dfdx] = optimizationFunction(x)

  # (2) initialize mean square values
  state.meanSquareValues ?= t.zeros(dfdx.length)

  # (3) calculate new (leaky) mean squared values
  state.meanSquareValues = t.mul(state.meanSquareValues, alpha)
  state.meanSquareValues = t.addcmul(state.meanSquareValues, 1.0 - alpha, dfdx, dfdx)

  # (4) perform update
  squareRoots = t.add(t.sqrt(state.meanSquareValues), epsilon)
  x = t.addcdiv(x, -learningRate, dfdx, squareRoots)

  # return x*, f(x) before optimization
  [x, {1: fx}]

module.exports = rmsprop
