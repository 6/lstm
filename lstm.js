(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
window.LSTM = {
  rmsprop: require('./rmsprop')
};


},{"./rmsprop":2}],2:[function(require,module,exports){
var addcdiv, addcmul, divide, rmsprop;

rmsprop = function(optimizationFunction, x, state) {
  var alpha, dfdx, epsilon, fx, learningRate, ref, ref1, ref2, ref3, squareRoots;
  if (state == null) {
    state = {};
  }
  learningRate = (ref = state.learningRate) != null ? ref : 1e-2;
  alpha = (ref1 = state.alpha) != null ? ref1 : 0.99;
  epsilon = (ref2 = state.epsilon) != null ? ref2 : 1e-8;
  ref3 = optimizationFunction(x), fx = ref3[0], dfdx = ref3[1];
  if (state.meanSquareValues == null) {
    state.meanSquareValues = math.zeros(dfdx.length);
  }
  state.meanSquareValues = math.multiply(state.meanSquareValues, alpha);
  state.meanSquareValues = addcmul(state.meanSquareValues, 1.0 - alpha, dfdx, dfdx);
  squareRoots = math.add(math.sqrt(state.meanSquareValues), epsilon);
  x = addcdiv(x, -learningRate, dfdx, squareRoots);
  return [
    x, {
      1: fx
    }
  ];
};

divide = function(tensor1, tensor2) {
  return tensor1.map(function(_, i) {
    return tensor1.get(i) / tensor2.get(i);
  });
};

addcmul = function(x, value, tensor1, tensor2) {
  return math.add(x, math.multiply(math.multiply(tensor1, tensor2), value));
};

addcdiv = function(x, value, tensor1, tensor2) {
  return math.add(x, math.multiply(divide(tensor1, tensor2), value));
};

module.exports = rmsprop;


},{}]},{},[1]);
