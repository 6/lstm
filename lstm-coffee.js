(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
window.LSTM = {
  rmsprop: require('./rmsprop'),
  tensor: require('./tensor')
};


},{"./rmsprop":2,"./tensor":3}],2:[function(require,module,exports){
var rmsprop;

rmsprop = function(opfunc, x, config, state) {
  var alpha, dfdx, epsilon, fx, learningRate, ref, ref1, ref2, ref3, t;
  t = LSTM.tensor;
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
  if (state.m == null) {
    state.m = t.zeros(dfdx.length);
    state.tmp = t.zeros(dfdx.length);
  }
  state.m = t.mul(state.m, alpha);
  state.m = t.addcmul(state.m, 1.0 - alpha, dfdx, dfdx);
  state.tmp = t.add(t.sqrt(state.m), epsilon);
  x = t.addcdiv(x, -learningRate, dfdx, state.tmp);
  return [
    x, {
      1: fx
    }
  ];
};

module.exports = rmsprop;


},{}],3:[function(require,module,exports){
var add, addcdiv, addcmul, cadd, cdiv, cmul, div, mul, sqrt, zeros;

mul = function(tensor, value) {
  return tensor.map(function(n) {
    return n * value;
  });
};

cmul = function(tensor1, tensor2) {
  return tensor1.map(function(_, i) {
    return tensor1[i] * tensor2[i];
  });
};

div = function(tensor, value) {
  return tensor.map(function(n) {
    return n / value;
  });
};

cdiv = function(tensor1, tensor2) {
  return tensor1.map(function(_, i) {
    return tensor1[i] / tensor2[i];
  });
};

add = function(tensor, value) {
  return tensor.map(function(n) {
    return n + value;
  });
};

cadd = function(tensor1, tensor2) {
  return tensor1.map(function(_, i) {
    return tensor1[i] + tensor2[i];
  });
};

addcmul = function(x, value, tensor1, tensor2) {
  return cadd(x, mul(cmul(tensor1, tensor2), value));
};

addcdiv = function(x, value, tensor1, tensor2) {
  return cadd(x, mul(cdiv(tensor1, tensor2), value));
};

sqrt = function(tensor) {
  return tensor.map(Math.sqrt);
};

zeros = function(length) {
  var j, ref, results;
  results = [];
  for (j = 1, ref = length; 1 <= ref ? j <= ref : j >= ref; 1 <= ref ? j++ : j--) {
    results.push(0);
  }
  return results;
};

module.exports = {
  mul: mul,
  cmul: cmul,
  div: div,
  cdiv: cdiv,
  add: add,
  cadd: cadd,
  addcmul: addcmul,
  addcdiv: addcdiv,
  sqrt: sqrt,
  zeros: zeros
};


},{}]},{},[1]);
