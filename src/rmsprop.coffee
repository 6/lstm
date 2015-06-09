# Divide the learning rate for a weight by a running average of the magnitudes of recent gradients for that weight.
# Sources:
# - Tieleman, T. and Hinton, G. (2012), Lecture 6.5 - rmsprop, COURSERA: Neural Networks for Machine Learning
# - https://github.com/torch/optim/blob/master/rmsprop.lua

rmsprop = (opfunc, x, config, state) ->

module.exports = rmsprop
