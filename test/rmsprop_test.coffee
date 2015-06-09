describe "rmsprop", ->
  # Based on [assumed to be correct] outputs from:
  # https://github.com/torch/optim/blob/07fb9e0e22c1ff1a64613b24f0ba290e710aa5bd/test/rosenbrock.lua
  it "calculates rosenbrock correctly", ->
    expect(rosenbrock([0, 0])).toEqual([1, [-2, 0]])
    expect(rosenbrock([1, 2])).toEqual([100, [-400, 200]])
    expect(rosenbrock([-2, 4])).toEqual([9, [-6, 0]])
    expect(rosenbrock([0, 0, 0, 0, 0])).toEqual([4, [-2, -2, -2, -2, 0]])
    expect(rosenbrock([4, 3, 2, 1, 0])).toEqual([22814, [20806, 5804, 1002, -200, -200]])
