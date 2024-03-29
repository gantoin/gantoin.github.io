title=Configure Twitch API OAuth2 provider on a Spring Security app
date=2023-01-04T16:38:11Z
type=post
tags=oauth2, twicth, api
status=published
~~~~~~

Hi guys, I'm working on a SaaS to manage Twitch Clips of broadcasters: 
- Create vertical Clips automatically for TikTok, Youtube Shorts, etc.
- Create compilation for clips to easily make best-of

So, I had to plug my Spring Security app into the Twitch OAuth2 provider and it was not easy...

## How to do that?

### Prerequisites

Before you begin, you need to have the following:

- A Twitch account and a registered app on the Twitch Developer Dashboard. If you don't have one, you can create a new app [here](https://dev.twitch.tv/docs/authentication/#registration).

- A Spring Security application. If you don't have one, you can follow [these instructions](https://spring.io/guides/gs/securing-web/) to create a simple Spring Security app.

### Step 1: Add the necessary dependencies

First, you need to add the following dependencies to your project's `pom.xml` file:

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-security</artifactId>
</dependency>

<dependency>
  <groupId>org.springframework.security</groupId>
  <artifactId>spring-security-oauth2-client</artifactId>
</dependency>

<dependency>
  <groupId>org.springframework.security</groupId>
  <artifactId>spring-security-oauth2-jose</artifactId>
</dependency>
```

### Step 2: Configure the OAuth2 client

Next, you need to configure the OAuth2 client by adding the following properties to your `application.properties` file:

```
spring.security.oauth2.client.provider.twitch.authorization-uri=https://id.twitch.tv/oauth2/authorize
spring.security.oauth2.client.provider.twitch.token-uri=https://id.twitch.tv/oauth2/token
spring.security.oauth2.client.provider.twitch.jwk-set-uri=https://id.twitch.tv/oauth2/keys
spring.security.oauth2.client.provider.twitch.user-info-uri=https://api.twitch.tv/helix/users
spring.security.oauth2.client.registration.twitch.client-id=<your-client-id>
spring.security.oauth2.client.registration.twitch.client-secret=<your-client-secret>
spring.security.oauth2.client.registration.twitch.redirect-uri={baseUrl}/login/oauth2/code/{registrationId}
```

Replace `<your-client-id>` and `<your-client-secret>` with the client ID and client secret of your registered app on the Twitch Developer Dashboard.

### Step 3: Configure the OAuth2 filter

To configure the OAuth2 filter, you need to create a `WebSecurityConfigurerAdapter` class and override the `configure(HttpSecurity http)` method. Add the following code to the method:

```java
http.oauth2Login()
  .authorizationEndpoint()
    .baseUri("/oauth2/authorization/twitch")
  .and()
  .redirectionEndpoint()
    .baseUri("/oauth2/callback/*")
  .and()
```

🎉 Congratulations! 🎉

You have successfully configured the Twitch API OAuth2 provider on your Spring Security application.

🌟 Happy coding! 💻












