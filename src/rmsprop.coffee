# Divide the learning rate for a weight by a running average of the magnitudes of recent gradients for that weight.
# Sources:
# - Tieleman, T. and Hinton, G. (2012), Lecture 6.5 - rmsprop, COURSERA: Neural Networks for Machine Learning
# - https://github.com/torch/optim/blob/07fb9e0e22c1ff1a64613b24f0ba290e710aa5bd/rmsprop.lua

rmsprop = (opfunc, x, config, state) ->
  t = LSTM.tensor

  # (0) get/update state
  config ?= {}
  state ?= config
  learningRate = config.learningRate ? 1e-2
  alpha = config.alpha ? 0.99
  epsilon = config.epsilon ? 1e-8

  # (1) evaluate f(x) and df/dx
  [fx, dfdx] = opfunc(x)

  # (2) initialize mean square values and square gradient storage
  if !state.m?
    state.m = t.zeros(dfdx.length)
    state.tmp = t.zeros(dfdx.length)

  # (3) calculate new (leaky) mean squared values
  state.m = t.mul(state.m, alpha)
  state.m = t.addcmul(state.m, 1.0 - alpha, dfdx, dfdx)

  # (4) perform update
  state.tmp = t.add(t.sqrt(state.m), epsilon)
  x = t.addcdiv(x, -learningRate, dfdx, state.tmp)

  # return x*, f(x) before optimization
  [x, {1: fx}]

module.exports = rmsprop
