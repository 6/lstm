# This function returns the function value, partial derivatives and Hessian of
# the (general dimension) rosenbrock function, given by:
# f(x) = sum_{i=1:D-1} 100*(x(i+1) - x(i)^2)^2 + (1-x(i))^2
# where D is the dimension of x. The true minimum is 0 at x = (1 1 ... 1).
# Carl Edward Rasmussen, 2001-07-21. Based on source:
# https://github.com/torch/optim/blob/07fb9e0e22c1ff1a64613b24f0ba290e710aa5bd/test/rosenbrock.lua

window.rosenbrock = (values) ->
  # (1) compute f(x)

  # x1 =  x(i)
  x1 = values[0..-2]

  # x(i+1) - x(i)^2
  # x1:cmul(x1):mul(-1):add(x:narrow(1,2,d-1))
  x1 = x1.map (n, i) -> (n * n * -1) + values[1..-1][i]

  # 100*(x(i+1) - x(i)^2)^2
  # x1:cmul(x1):mul(100)
  x1 = x1.map (n) -> n * n * 100

  # x(i)
  # local x0 = x.new(d-1):copy(x:narrow(1,1,d-1))
  x0 = values[0..-2]

  # 1-x(i)
  # x0:mul(-1):add(1)
  x0 = x0.map (n) -> (n * -1) + 1

  # (1-x(i))^2
  # x0:cmul(x0)
  x0 = x0.map (n) -> n * n

  # 100*(x(i+1) - x(i)^2)^2 + (1-x(i))^2
  # x1:add(x0)
  x1 = x1.map (n, i) -> x1[i] + x0[i]

  # fout = x1:sum()
  fout = x1.reduce (x, y) -> x + y

  # (2) compute f(x)/dx

  dxout = (0 for [1..values.length])

  # df(1:D-1) = - 400*x(1:D-1).*(x(2:D)-x(1:D-1).^2) - 2*(1-x(1:D-1));
  x1 = values[0..-2]
  x1 = x1.map (n, i) -> (n * n * -1) + values[1..-1][i]
  x1 = x1.map (n, i) -> (n * values[0..-2][i]) * -400
  x0 = values[0..-2].map (n) -> ((n * -1) + 1) * -2
  x1 = x1.map (n, i) -> x1[i] + x0[i]
  (dxout[i] = value for value, i in x1)

  # df(2:D) = df(2:D) + 200*(x(2:D)-x(1:D-1).^2);
  x0 = values[0..-2]
  x0 = x0.map (n, i) -> ((((n * n) * -1)) + values[1..-1][i]) * 200
  (dxout[i + 1] += value for value, i in x0)

  [fout, dxout]
