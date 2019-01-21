# Fifth Homework
This homework was about comparing the exhaustive search from [Forth Homework](../Lab4) with other variable selection procedures, more efficient from the time complexity point of view.
---

### Let's consider the ["House" data set](house.dat) (Source: Long-Kogan Realty, Chicago, USA). Full explanation of variables meaning can be found [here](../Lab4).
1. Determine the best (sub) regression model using forward, backward and stepwise selection.
1. Consider the optimal model obtained in Theme 4 through the exhaustive generation of all possible submodels. Displayed in one chart and different colors, the pairs form (![][y], ![][y_estimated]), where i = 1, ..., 26, m = exhaustive, forward, backward or stepwise and ![][y_estimated] represent estimated (calculated) values ​​of using the m obtained model. Ideally these points should be located on the line (0,1). What can you say about the power of prediction of the four models?
![][all]
![][forward] ![][backward]
![][stepwise] ![][exhaustive]

[y]: https://latex.codecogs.com/gif.latex?y_i
[y_estimated]: https://latex.codecogs.com/gif.latex?\widehat{y_i}^{(m)}
[all]: all.png
[forward]: forward.png
[backward]: backward.png
[stepwise]: stepwise.png
[exhaustive]: exhaustive.png