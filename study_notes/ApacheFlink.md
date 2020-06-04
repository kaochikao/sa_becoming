

Digest:
- 整體來說跟Spark Streaming很像：在cluster上的運作方式，API，DAG等等．
    - JobManager像Spark Driver
    - TaskManager像Spark Executor

Overview:
- Apache Flink is a Big Data processing framework that allows programmers to process the vast amount of data in a very efficient and scalable manner.
- The key vision for Apache Flink is to overcome and reduce the complexity that has been faced by other distributed data-driven engines. It is achieved by integrating query optimization, concepts from database systems and efficient parallel in-memory and out-of-core algorithms, with the MapReduce framework. 
- Apache Flink is mainly based on the `streaming model`. Apache Flink iterates data by using streaming architecture. The concept of an iterative algorithm is tightly bounded into Flink query optimizer. 
- Apache Flink’s pipelined architecture allows processing the streaming data faster with lower latency than `micro-batch` architectures like `Spark`.
- In Flink, `everything is considered as a stream of data`, and eventually some sort of transformation has to happen on the stream’s data. 
- Conceptually, a stream is a (potentially never-ending) `flow of data records`, and a `transformation` is an operation that takes `one or more streams` as input, and produces one or more output streams as a result.
- The basic building blocks of Flink programs are `streams` and `transformations`. (Note that the DataSets used in Flink’s DataSet API are also streams internally – more about that later.)


flink_architecture.png
Architecture:

