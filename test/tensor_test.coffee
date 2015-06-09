describe "tensor", ->
  beforeEach ->
    @t = window.LSTM.tensor

  describe "#addcmul", ->
    it "returns the correct result", ->
      expect(@t.addcmul([2, 2], 2, [3, 3], [5, 5])).toEqual([32, 32])
      expect(@t.addcmul([2, 2], 4, [-3, -3], [5, 5])).toEqual([-58, -58])

  describe "#addcdiv", ->
    it "returns the correct result", ->
      expect(@t.addcdiv([2, 2], 2, [3, 3], [5, 5])).toEqual([3.2, 3.2])
      expect(@t.addcdiv([2, 2], 8, [-3, -3], [5, 5])).toEqual([-2.8, -2.8])
