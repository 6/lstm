# describe "rmsprop", ->
#   it "calculates correctly for a single iteration", ->
#     x = [0, 0]
#     [x, f] = LSTM.rmsprop(rosenbrock, x, {learningRate: 5e-4})
#     expect(x.length).toEqual(2)
#     expect(x[0]).toBeCloseTo(0.005)
#     expect(x[1]).toEqual(0)
#     expect(f).toEqual({1: 1})

#   it "calculates correctly over 10,000 iterations", ->
#     x = [0, 0]
#     fx = []
#     state = {learningRate: 5e-4}
#     for i in [1..10001]
#       [x, f] = LSTM.rmsprop(rosenbrock, x, state)
#       if (i - 1) % 1000 == 0
#         fx.push(f[1])

#     # Outputs based on test output from:
#     # https://github.com/torch/optim/blob/07fb9e0e22c1ff1a64613b24f0ba290e710aa5bd/test/test_rmsprop.lua
#     expect(x[0]).toBeCloseTo(0.9997)
#     expect(x[1]).toBeCloseTo(1.0001)

#     expect(fx[0]).toBeCloseTo(1)
#     expect(fx[1]).toBeCloseTo(0.22250273093778)
#     expect(fx[2]).toBeCloseTo(0.012812312479782)
#     expect(fx[3]).toBeCloseTo(0.0010756704751355)
#     expect(fx[4]).toBeCloseTo(0.00015817558618915)
#     expect(fx[5]).toBeCloseTo(6.7179877403203e-05)
#     expect(fx[6]).toBeCloseTo(5.74880956389e-05)
#     expect(fx[7]).toBeCloseTo(5.6427175779296e-05)
#     expect(fx[8]).toBeCloseTo(5.6308437060917e-05)
#     expect(fx[9]).toBeCloseTo(5.6294538955955e-05)
#     expect(fx[10]).toBeCloseTo(5.6292724076977e-05)
