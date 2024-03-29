title=How to use ChatGPT API in your Java application?
date=2023-01-08T11:05:55Z
type=post
tags=chatgpt, java, api
status=published
~~~~~~

Hi guys 👋 I'm sure you enjoy using chat GPT to produce, optimise, or translate code from any programming language to Java.

Today I'll show you how to use OpenAI ChatGPT API with Java, it's pretty easy.

## 1. Register for an API key

First, you'll need to register for an API key by going to the [OpenAI API page](https://beta.openai.com/signup/). Follow the instructions to create an account and obtain an API key.

## 2. Enter a credit card into your OpenAI account

OpenAI blocks the API calls for `exceeded your current quota` when you don't have any card registered in your account. So, you will need to configure one.

## 3. Implements code like:

```java
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class ChatGPT {
    public static void chatGPT(String text) throws Exception {
        String url = "https://api.openai.com/v1/completions";
        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();

        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setRequestProperty("Authorization", "Bearer YOUR-API-KEY");

        JSONObject data = new JSONObject();
        data.put("model", "text-davinci-003");
        data.put("prompt", text);
        data.put("max_tokens", 4000);
        data.put("temperature", 1.0);

        con.setDoOutput(true);
        con.getOutputStream().write(data.toString().getBytes());

        String output = new BufferedReader(new InputStreamReader(con.getInputStream())).lines()
                .reduce((a, b) -> a + b).get();

        System.out.println(new JSONObject(output).getJSONArray("choices").getJSONObject(0).getString("text"));
    }

    public static void main(String[] args) throws Exception {
        chatGPT("Hello, how are you?");
    }
}
```

## It works!

```
src.main.java.ChatGPT


I'm doing great, thank you for asking. How about you?

Process finished with exit code 0
```

### Resources used:

- `org.json` [https://mvnrepository.com/artifact/org.json/json/20220924](https://mvnrepository.com/artifact/org.json/json/20220924) (add this dependency to your project)
- this python tutorial I converted to Java [https://datasans.medium.com/how-to-use-chatgpt-api-directly-in-your-jupyter-notebook-simple-no-gimmicks-be30bdf9f031](https://datasans.medium.com/how-to-use-chatgpt-api-directly-in-your-jupyter-notebook-simple-no-gimmicks-be30bdf9f031)

