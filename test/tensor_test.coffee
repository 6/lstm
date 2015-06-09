describe "tensor", ->
  beforeEach ->
    @t = window.LSTM.tensor

  describe "#addcmul", ->
    it "performs the element-wise multiplication of tensor1 by tensor2, multiply the result by the scalar value and add it to x", ->
      expect(@t.addcmul([2, 2], 2, [3, 3], [5, 5])).toEqual([32, 32])
      expect(@t.addcmul([2, 2], 4, [-3, -3], [5, 5])).toEqual([-58, -58])

  describe "#addcdiv", ->
    it "performs the element-wise division of tensor1 by tensor1, multiply the result by the scalar value and add it to x", ->
      expect(@t.addcdiv([2, 2], 2, [3, 3], [5, 5])).toEqual([3.2, 3.2])
      expect(@t.addcdiv([2, 2], 8, [-3, -3], [5, 5])).toEqual([-2.8, -2.8])
