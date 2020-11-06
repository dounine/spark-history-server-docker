ARG SPARK_IMAGE=gcr.io/spark-operator/spark:v3.0.0
FROM ${SPARK_IMAGE}

#RUN apk add --no-cache tini
USER root
RUN chmod -R u+x /tmp

# Set up dependencies for Google Cloud Storage access.
#RUN rm $SPARK_HOME/jars/guava-14.0.1.jar
ADD https://repo1.maven.org/maven2/com/google/guava/guava/23.0/guava-23.0.jar $SPARK_HOME/jars
# Add the connector jar needed to access Google Cloud Storage using the Hadoop FileSystem API.
ADD https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-latest-hadoop2.jar $SPARK_HOME/jars

# Add dependency for hadoop-aws
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar $SPARK_HOME/jars
# Add hadoop-aws to access Amazon S3
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.5/hadoop-aws-2.7.5.jar $SPARK_HOME/jars

# Add dependency for hadoop-azure
ADD https://repo1.maven.org/maven2/com/microsoft/azure/azure-storage/2.0.0/azure-storage-2.0.0.jar $SPARK_HOME/jars
# Add hadoop-azure to access Azure Blob Storage
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/2.7.3/hadoop-azure-2.7.3.jar $SPARK_HOME/jars

# Add dependency for alibaba cloud
#ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aliyun/2.9.1/hadoop-aliyun-2.9.1.jar $SPARK_HOME/jars
COPY lib/hadoop-aliyun-2.7.3.2.6.1.0-129.jar $SPARK_HOME/jars
ADD https://repo1.maven.org/maven2/com/aliyun/oss/aliyun-sdk-oss/3.4.1/aliyun-sdk-oss-3.4.1.jar $SPARK_HOME/jars

ADD https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-latest-hadoop2.jar $SPARK_HOME/jars

COPY entrypoint.sh /usr/bin/
USER root
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

#ENTRYPOINT ["/opt/entrypoint.sh"]
