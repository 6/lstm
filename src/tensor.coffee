# TODO - give these more readable names
mul = (tensor, value) ->
  tensor.map (n) -> n * value

cmul = (tensor1, tensor2) ->
  tensor1.map (_, i) -> tensor1[i] * tensor2[i]

div = (tensor, value) ->
  tensor.map (n) -> n / value

cdiv = (tensor1, tensor2) ->
  tensor1.map (_, i) -> tensor1[i] / tensor2[i]

add = (tensor, value) ->
  tensor.map (n) -> n + value

cadd = (tensor1, tensor2) ->
  tensor1.map (_, i) -> tensor1[i] + tensor2[i]

addcmul = (x, value, tensor1, tensor2) ->
  cadd(x, mul(cmul(tensor1, tensor2), value))

addcdiv = (x, value, tensor1, tensor2) ->
  cadd(x, mul(cdiv(tensor1, tensor2), value))

sqrt = (tensor) ->
  tensor.map(Math.sqrt)

zeros = (length) ->
  (0 for [1..length])

module.exports =
  mul: mul
  cmul: cmul
  div: div
  cdiv: cdiv
  add: add
  cadd: cadd
  addcmul: addcmul
  addcdiv: addcdiv
  sqrt: sqrt
  zeros: zeros
