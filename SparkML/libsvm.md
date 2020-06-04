
### 一句話：用來存sparse arrays/matrix, 不用寫出0

- LibSVM allows for sparse training data. 
- That is, the non-zero values are the only ones that are included in the dataset. 
- Hence, the index specifies the column of the instance data (feature index). 
- To convert from a conventional dataset just iterate over the data, and if the value of X(i,j) is non-zero, print j+1 : X(i,j).


Example:
```
-1 5:1 7:1 14:1 19:1 39:1 40:1 51:1 63:1 67:1 73:1 74:1 76:1 78:1 83:1
```
- Here -1 is the class or label
- The values of paramaters with indexes 1,2,3,4,6, and others unmentioned are 0's
- In 5:1, 5 is index, and 1 is the value of parameter

