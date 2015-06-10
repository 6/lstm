# This function returns the function value, partial derivatives and Hessian of
# the (general dimension) rosenbrock function, given by:
# f(x) = sum_{i=1:D-1} 100*(x(i+1) - x(i)^2)^2 + (1-x(i))^2
# where D is the dimension of x. The true minimum is 0 at x = (1 1 ... 1).
# Carl Edward Rasmussen, 2001-07-21. Based on source:
# https://github.com/torch/optim/blob/07fb9e0e22c1ff1a64613b24f0ba290e710aa5bd/test/rosenbrock.lua

window.rosenbrock = (values) ->
  t = LSTM.tensor
  # (1) compute f(x)

  # x1 =  x(i)
  x1 = values[0..-2]

  # x(i+1) - x(i)^2
  x1 = t.cadd(t.mul(t.cmul(x1, x1), -1), values[1..-1])

  # 100*(x(i+1) - x(i)^2)^2
  x1 = t.mul(t.cmul(x1, x1), 100)

  # x(i)
  x0 = values[0..-2]

  # 1-x(i)
  x0 = t.add(t.mul(x0, -1), 1)

  # (1-x(i))^2
  x0 = t.cmul(x0, x0)

  # 100*(x(i+1) - x(i)^2)^2 + (1-x(i))^2
  x1 = t.cadd(x1, x0)

  # fout = x1:sum()
  fout = x1.reduce (x, y) -> x + y

  # (2) compute f(x)/dx

  dxout = t.zeros(values.length)

  # df(1:D-1) = - 400*x(1:D-1).*(x(2:D)-x(1:D-1).^2) - 2*(1-x(1:D-1));
  x1 = values[0..-2]
  x1 = t.cadd(t.mul(t.cmul(x1, x1), -1), values[1..-1])
  x1 = t.mul(t.cmul(x1, values[0..-2]), -400)
  x0 = t.mul(t.add(t.mul(values[0..-2], -1), 1), -2)
  x1 = t.cadd(x1, x0)
  (dxout[i] = value for value, i in x1)

  # df(2:D) = df(2:D) + 200*(x(2:D)-x(1:D-1).^2);
  x0 = values[0..-2]
  x0 = t.mul(t.cadd(t.mul(t.cmul(x0, x0), -1), values[1..-1]), 200)
  (dxout[i + 1] += value for value, i in x0)

  [fout, dxout]
