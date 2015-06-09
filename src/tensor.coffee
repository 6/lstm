# TODO - give these more readable names
mul = (tensor, value) ->
  tensor.map (n) -> n * value

cmul = (tensor1, tensor2) ->
  tensor1.map (_, i) -> tensor1[i] * tensor2[i]

add = (tensor, value) ->
  tensor.map (n) -> n + value

cadd = (tensor1, tensor2) ->
  tensor1.map (_, i) -> tensor1[i] + tensor2[i]

zeros = (length) ->
  (0 for [1..length])

module.exports =
  mul: mul
  cmul: cmul
  add: add
  cadd: cadd
  zeros: zeros
