-   Py4J enables Python programs running in a Python interpreter to
    dynamically access Java objects in a Java Virtual Machine. Methods
    are called as if the Java objects resided in the Python interpreter
    and Java collections can be accessed through standard Python
    collection methods.
-   Py4J also enables Java programs to call back Python objects.
    (雙向的)
-   Note that the Java program must be started before executing the
    Python code above. In other words, the Py4J does not start a JVM.

+--------------------------------------------------------------------------+
| import py4j.GatewayServer;\                                              |
| \                                                                        |
| public class AdditionApplication {\                                      |
| \                                                                        |
|   public int addition(int first, int second) {\                          |
|     return first + second;\                                              |
|   }\                                                                     |
| \                                                                        |
|   public static void main(String[] args) {\                              |
|     AdditionApplication app = new AdditionApplication();\                |
|     //在Java端要instantiate server\                                      |
|     GatewayServer server = new GatewayServer(app);\                      |
|     server.start();\                                                     |
|   }\                                                                     |
| }                                                                        |
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| from py4j.java\_gateway import JavaGateway\                              |
| \                                                                        |
| \# connect to JVM\                                                       |
| gateway = JavaGateway()\                                                 |
| \                                                                        |
| \# 直接使用Java class, method\                                           |
| random = gateway.jvm.java.util.Random()\                                 |
| number1 = random.nextInt(10)\                                            |
| \                                                                        |
| \# 直接使用自己定義的java class\                                         |
| addition\_app = gateway.entry\_point\                                    |
| value = addition\_app.addition(number1, number2)                         |
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| \# apache/spark/blob/master/python/pyspark/java\_gateway.py\             |
| script = "./bin/spark-submit.cmd" if on\_windows                         |
| else "./bin/spark-submit"\                                               |
| command = [os.path.join(SPARK\_HOME, script)]\                           |
| \                                                                        |
| command = command + shlex.split(submit\_args)\                           |
| ...\                                                                     |
| proc = Popen(command, \*\*popen\_kwargs)\                                |
| ...\                                                                     |
| gateway = JavaGateway(\                                                  |
|             gateway\_parameters=GatewayParameters(\                      |
|                 port=gateway\_port,\                                     |
|                 auth\_token=gateway\_secret,\                            |
|                 auto\_convert=True))\                                    |
| \                                                                        |
| gateway.proc = proc                                                      |
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| \# spark/python/pyspark/context.py\                                      |
| from pyspark.java\_gateway import launch\_gateway,                       |
| local\_connect\_and\_auth\                                               |
| \                                                                        |
| ...\                                                                     |
| SparkContext.\_ensure\_initialized(self, gateway=gateway, conf=conf)\    |
| ...\                                                                     |
| \                                                                        |
| @classmethod\                                                            |
| def \_ensure\_initialized(cls, instance=None, gateway=None, conf=None):\ |
|     """\                                                                 |
|     Checks whether a SparkContext is initialized or not.\                |
|     Throws error if a SparkContext is already running.\                  |
|     """\                                                                 |
|     with SparkContext.\_lock:\                                           |
|         if not SparkContext.\_gateway:\                                  |
|             SparkContext.\_gateway = gateway or launch\_gateway(conf)\   |
|             SparkContext.\_jvm = SparkContext.\_gateway.jvm\             |
|         ...                                                              |
+--------------------------------------------------------------------------+


