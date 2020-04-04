


custom log4j config file
```sh
spark-submit \
--deploy-mode client \
--master yarn \
--executor-memory 1g \
--files /home/hadoop/custom_log4j.properties \
--conf "spark.driver.extraJavaOptions=-Dlog4j.configuration=file:///home/hadoop/custom_log4j.properties" \
--class org.apache.spark.examples.SparkPi /usr/lib/spark/examples/jars/spark-examples.jar 10
```

