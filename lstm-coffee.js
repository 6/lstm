(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
window.LSTM = {
  rmsprop: require('./rmsprop')
};


},{"./rmsprop":2}],2:[function(require,module,exports){
var rmsprop;

rmsprop = function(opfunc, x, config, state) {
  var alpha, dfdx, epsilon, fx, learningRate, ref, ref1, ref2, ref3;
  if (config == null) {
    config = {};
  }
  if (state == null) {
    state = config;
  }
  learningRate = (ref = config.learningRate) != null ? ref : 1e-2;
  alpha = (ref1 = config.alpha) != null ? ref1 : 0.99;
  epsilon = (ref2 = config.epsilon) != null ? ref2 : 1e-8;
  ref3 = opfunc(x), fx = ref3[0], dfdx = ref3[1];
  return [x, fx];
};

module.exports = rmsprop;


},{}]},{},[1]);
