# This function returns the function value, partial derivatives and Hessian of
# the (general dimension) rosenbrock function, given by:
# f(x) = sum_{i=1:D-1} 100*(x(i+1) - x(i)^2)^2 + (1-x(i))^2
# where D is the dimension of x. The true minimum is 0 at x = (1 1 ... 1).
# Carl Edward Rasmussen, 2001-07-21. Based on source:
# https://github.com/torch/optim/blob/07fb9e0e22c1ff1a64613b24f0ba290e710aa5bd/test/rosenbrock.lua

window.rosenbrock = (values) ->
  # (1) compute f(x)

  # x1 =  x(i)
  x1 = $M([values[0..-2]])
  console.log(x1.elements)

  # x(i+1) - x(i)^2
  x1 = x1.multiply(values[0..-2]).multiply(-1).add($V(values[1..-1]))
  console.log("NEW", JSON.stringify(x1.elements))

  # # 100*(x(i+1) - x(i)^2)^2
  # x1 = math.multiply(math.multiply(x1.clone(), x1.clone()), 100)
  # console.log("NEW2", x1)

  # # x(i)
  # x0 = values[0..-2]

  # # 1-x(i)
  # x0 = math.add(math.multiply(x0, -1), 1)

  # # (1-x(i))^2
  # x0 = math.multiply(x0, x0)

  # # 100*(x(i+1) - x(i)^2)^2 + (1-x(i))^2
  # x1 = math.add(x1, x0)

  # # fout = x1:sum()
  # fout = 0
  # console.log(x1)
  # x1.forEach (value) ->
  #   fout += value

  # # (2) compute f(x)/dx

  # dxout = math.zeros(values.length)

  # # df(1:D-1) = - 400*x(1:D-1).*(x(2:D)-x(1:D-1).^2) - 2*(1-x(1:D-1));
  # x1 = values[0..-2]
  # x1 = math.add(math.multiply(math.multiply(x1, x1), -1), values[1..-1])
  # x1 = math.multiply(math.multiply(x1, values[0..-2]), -400)
  # x0 = math.multiply(math.add(math.multiply(values[0..-2], -1), 1), -2)
  # x1 = math.add(x1, x0)
  # x1.forEach (value, i) -> dxout[i] = value

  # # df(2:D) = df(2:D) + 200*(x(2:D)-x(1:D-1).^2);
  # x0 = values[0..-2]
  # x0 = math.multiply(math.add(math.multiply(math.multiply(x0, x0), -1), values[1..-1]), 200)
  # x0.forEach (value, i) -> dxout[i + 1] += value

  # [fout, dxout]
  [0,0]
