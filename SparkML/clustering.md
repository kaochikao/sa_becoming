

- "KMeans is implemented as an Estimator and generates a KMeansModel as the `base model`."
    - 官方描述的語言

```python 
from pyspark.ml.clustering import KMeans
from pyspark.ml.evaluation import ClusteringEvaluator


# file讀取方式其實就是一般的SparkSQL read file.
# 注意這邊libsvm其實是一個txt檔
dataset = spark.read.format('libsvm').load('data/mllib/sample_kmeans_data.txt')

kmeans = KMeans().setK(2).setSeed(1)
model = kmeans.fit(dataset)

predictions = model.transform(dataset)

evaluator = ClusteringEvaluator()


```

上面的libsvm檔長這樣：
```
0 1:0.0 2:0.0 3:0.0
1 1:0.1 2:0.1 3:0.1
2 1:0.2 2:0.2 3:0.2
3 1:9.0 2:9.0 3:9.0
4 1:9.1 2:9.1 3:9.1
5 1:9.2 2:9.2 3:9.2
```
https://github.com/apache/spark/blob/master/data/mllib/sample_kmeans_data.txt