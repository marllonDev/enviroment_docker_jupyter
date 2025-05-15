from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("PySparkPostgres") \
    .config("spark.jars.packages", "org.postgresql:postgresql:42.3.1") \
    .getOrCreate()

df = spark.read \
    .format("jdbc") \
    .option("url", "jdbc:postgresql://postgres:5432/postgres") \
    .option("dbtable", "APP_TESTE") \
    .option("user", "adm") \
    .option("password", "adm") \
    .option("driver", "org.postgresql.Driver") \
    .load()

df.show()