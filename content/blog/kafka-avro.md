title=Make your Kafka bus more robust with Apache Avro & Confluent Schema Registry
date=2023-01-26T13:44:23Z
type=post
tags=kafka, avro, blog
status=published
~~~~~~

In this article, you will learn how to use Apache Avro and Confluent Schema Registry to make your Kafka bus more robust.

## Introduction

Apache Kafka is a distributed streaming platform. It is used to publish and subscribe to streams of records, similar to a message queue or enterprise messaging system. Kafka is often used as a data bus to connect different systems and applications. It is a very powerful tool, but it is not without its challenges. One of the most common challenges is the lack of data validation.

![Kafka bus](https://raw.githubusercontent.com/gantoin/gantoin.github.io/master/assets/images/blog_content/avro1.png)

It is important to understand that Kafka take bytes as input and output. It is up to the application to serialize and deserialize. Also, if you don't have a total control on application that consume your data, you can't be sure that the data will be valid.

If you need to update your data model, you will have to deal with backward compatibility with probably some consumer that will not be able to read the new data.

## Let's make the Kafka cluster validating the data?

![Kafka validator](https://raw.githubusercontent.com/gantoin/gantoin.github.io/master/assets/images/blog_content/avro2.png)

In theory, it is possible to validate the data in the Kafka cluster. But, the most important, it is not very efficient. You will break what Kafka is doing best: **distributing data fast**.

That's definitely not what we want.

## Solution: Apache Avro & Confluent Schema Registry

The solution is to use Apache Avro and Confluent Schema Registry.

![Kafka validator](https://raw.githubusercontent.com/gantoin/gantoin.github.io/master/assets/images/blog_content/avro3.png)

## How to implement it?

### 1. Define your data model

First, you need to define your data model. It is very important to understand that Avro is a schema-based serialization format.

You will need to add Apache Avro dependency in your project.

```xml

<dependencies>
  <dependency>
    <groupId>org.apache.avro</groupId>
    <artifactId>avro</artifactId>
    <version>1.10.2</version>
  </dependency>
  <dependency>
    <groupId>org.apache.avro</groupId>
    <artifactId>avro-maven-plugin</artifactId>
    <version>1.10.2</version>
  </dependency>
</dependencies>
```

To define a new model you will have to create a new Avro schema. It is a JSON file that describe the data model.

```json
{
  "namespace": "fr.gantoin.domain",
  "name": "Book",
  "type": "record",
  "fields": [
    {
      "name": "title",
      "type": "string",
      "doc": "The title of the book"
    },
    {
      "name": "author",
      "type": [
        "null",
        {
          "namespace": "fr.gantoin.domain",
          "name": "Author",
          "type": "record",
          "fields": [
            {
              "name": "firstName",
              "type": "string",
              "doc": "The author's first name"
            },
            {
              "name": "lastName",
              "type": "string",
              "doc": "The author's last name"
            }
          ]
        }
      ],
      "default": null,
      "doc": "The author of the book"
    },
    {
      "name": "year",
      "type": "int",
      "logicalType": "timestamp-millis",
      "doc": "The year of the book"
    }
  ]
}
```

You can create really complex data model with Avro. You can check the [Avro documentation](https://avro.apache.org/docs/current/spec.html) for more information.

You will also have to create a maven profile to generate the Java classes from the Avro schema.

```xml

<plugin>
  <groupId>org.apache.avro</groupId>
  <artifactId>avro-maven-plugin</artifactId>
  <version>1.10.2</version>
  <executions>
    <execution>
      <phase>generate-sources</phase>
      <goals>
        <goal>schema</goal>
        <goal>protocol</goal>
        <goal>idl-protocol</goal>
      </goals>
      <configuration>
        <sourceDirectory>${project.basedir}/src/main/resources/avro</sourceDirectory>
        <stringType>String</stringType>
        <createSetters>false</createSetters>
        <enableDecimalLogicalType>true</enableDecimalLogicalType>
        <fieldVisibility>private</fieldVisibility>
      </configuration>
    </execution>
  </executions>
</plugin>
```

With a simple command, you will be able to generate the Java classes from the Avro schema.

```bash
mvn clean package
```

### 2. Register your schema in the Confluent Schema Registry

Once you have defined your data model, you will have to register it in the Confluent Schema Registry.
Confluent Schema Registry is a schema registry for Avro developed by Confluent.

Is it important to know that with this kind of architecture, your schema registry become a vital part of your infrastructure. If your schema registry is down, your Kafka cluster will not be able to validate the data.

To try it, you can start with the project fast-data-dev. It is a docker image that contains a Kafka cluster with Confluent Schema Registry:
[https://hub.docker.com/r/landoop/fast-data-dev/dockerfile](https://hub.docker.com/r/landoop/fast-data-dev/dockerfile).

### 3. Use the Confluent Schema Registry in your application

Now, you can use the Confluent Schema Registry in your application. First, add the Confluent Avro serializer and deserializer dependency in your project:

```xml

<dependency>
  <groupId>io.confluent</groupId>
  <artifactId>kafka-avro-serializer</artifactId>
  <version>6.2.1</version>
</dependency>
```

And Confluence Schema Registry dependency.

```xml

<dependency>
  <groupId>io.confluent</groupId>
  <artifactId>kafka-schema-registry-client</artifactId>
  <version>6.2.1</version>
</dependency>
```

You will need to add the Confluent Maven repository.

```xml

<repositories>
  <repository>
    <id>confluent</id>
    <name>Confluent</name>
    <url>https://packages.confluent.io/maven/</url>
  </repository>
</repositories>
```

You will also have to configure the Kafka producer and consumer to use the Confluent Avro serializer and deserializer.

```java

@Configuration
public class KafkaSenderConfiguration {
    @Bean
    public ProducerFactory<String, GenericRecord> producerFactory() {
        return new DefaultKafkaProducerFactory<>(Map.of(
                ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers,
                ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class,
                ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class,
                "schema.registry.url", schemaRegistryUrl,
                "specific.avro.reader", true,
                "auto.register.schemas", true
        ));
    }
}
```

Here, is referred the serializer and the schema registry url.

### 4. Use the Confluent Schema Registry in your consumer

```java

@Configuration
public class KafkaReceiverConfiguration {
    @Bean
    public ConsumerFactory<String, GenericRecord> consumerFactory() {
        return new DefaultKafkaConsumerFactory<>(Map.of(
                ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers,
                ConsumerConfig.GROUP_ID_CONFIG, groupId,
                ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class,
                ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, KafkaAvroDeserializer.class,
                "schema.registry.url", schemaRegistryUrl,
                "specific.avro.reader", true,
                "auto.register.schemas", true
        ));
    }
}
```

### 5. Update your data model

If you need to update your data model, you will have to update the Avro schema and register it in the Confluent Schema Registry.
Once it is done, you can send your new data model with the new version. Your old consumer will still be able to read your data.
If you want to know more about Confluent Schema Registry, you can check this article:
[https://docs.confluent.io/current/schema-registry/docs/index.html](https://docs.confluent.io/current/schema-registry/docs/index.html).

## Conclusion

In this article, you have learned how to use Apache Avro and Confluent Schema Registry to make your Kafka bus more robust.

For more details on how to do, here is a live coding video that I made on YouTube (in French, sorry about that):

[https://www.youtube.com/watch?v=xcWidCZTEok](https://www.youtube.com/watch?v=xcWidCZTEok)
