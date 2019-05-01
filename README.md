# authorization-resource-server

Securing REST API with Spring Security OAuth2 password flow

Minimal [Spring Boot](http://projects.spring.io/spring-boot/) sample app.

## Requirements

For building and running the application you need:

- [JDK 11](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- [Maven 3](https://maven.apache.org)

## Running the application locally

There are several ways to run a Spring Boot application on your local machine. One way is to execute the `main` method in the `io.satendra.authorizationserver.AuthorizationServerApplication` and `io.satendra.resourceserver.ResourceServerApplication` class from your IDE (Run both application).

Alternatively you can use the [Spring Boot Maven plugin](https://docs.spring.io/spring-boot/docs/current/reference/html/build-tool-plugins-maven-plugin.html) like so:

```shell
mvn spring-boot:run
```
## Usage example
#### 1. Authorization-server
###### 1.1 Generate jwt token oauth2 from authorization server
```jshelllanguage
curl -X POST -u "clientId:client-secret" -d "grant_type=password&username=satendra&password=Sat@123" http://localhost:8081/oauth/token

{
    "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NTY3Mjc3NTAsInVzZXJfbmFtZSI6InNhdGVuZHJhIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiIsIkFETUlOIl0sImp0aSI6ImQ1YjlmOGY5LWQ1OTUtNDBiNC1hZTAxLTE0M2JmYzMzYzg3NSIsImNsaWVudF9pZCI6ImNsaWVudElkIiwic2NvcGUiOlsicmVhZCIsIndyaXRlIl19.RNfFjNIDs0Gf2_2bPnQvJqWl9yxjNHhNYLYCrIePjHxVAy5qlxcLO_gg4w-idKh29oWLDsnr50PXTbzIm9Nt0XXu8S99qJ0ekc1Flgr5BM9pvDOLl_WNbjIo20YFRFEt8Hrr0t8zwAphWN3OiMnbk599bIUwJQHFyXNugrBBgHqAF4CZdv-36roWScmRO3XxXRZ4ylCIImAh9R_IIKDGOHoA4K0Voro3xl0o0fp3Z-SkEm1JeLdSM8E1yecRqGj-a8u8bA2b5UUmCajlppuaWDJnQ1GhCbcBm5Z7zRcd6R_YnVLwshdEdNHEWfp9bDM-ulQHKiK6GCJlqMeQogmfeg",
    "token_type": "bearer",
    "refresh_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJzYXRlbmRyYSIsInNjb3BlIjpbInJlYWQiLCJ3cml0ZSJdLCJhdGkiOiJkNWI5ZjhmOS1kNTk1LTQwYjQtYWUwMS0xNDNiZmMzM2M4NzUiLCJleHAiOjE1NTkzMTk0NTAsImF1dGhvcml0aWVzIjpbIlVTRVIiLCJBRE1JTiJdLCJqdGkiOiI1NzAzZmQ0MS1jYjAxLTRjMzktYWE5Ny0xMzk2MDM4NTNiOTkiLCJjbGllbnRfaWQiOiJjbGllbnRJZCJ9.YAdghdjALuARv2vAxbQXO5OQF5aR4gCx2AFLPhkgKvoBUEXgXs_LPYYi3HqeoFxKvv0d3pK7JIYA6bEVYQudNR-O43TeJmGGePKpkgKetxrvAAggFkkqW03e4TuBsMufg68-z-UKfmfvJ_YBdS1Gn-fSMcYjM-6C2M_d6F-FOKBfAGjwPl88T8jIIwQTwemrHxBEXFALEGCtj5wY59mUaWivVIKc1oQ2Hhsp80LoAnAkUeu2r8wFThZPkQI1NTpggf6ravenpDgG0naa3b4JwKDl8Py3g6_17s5d7wgHDBeOwuvZTKDqhfRip9xTjgx6coqnCHEBR4XSfiZwhr4X8g",
    "expires_in": 299,
    "scope": "read write",
    "jti": "d5b9f8f9-d595-40b4-ae01-143bfc33c875"
}
```
###### 1.2 Wrong password
```jshelllanguage
curl -X POST -u "clientId:client-secret" -d "grant_type=password&username=satendra&password=Sat@" http://localhost:8081/oauth/token
{
  "error":"invalid_grant",
  "error_description":"Bad credentials"
}

```
#### 2. Resource-server
###### 2.1 Use jwt token to access resouce for invalid token
```jshelllanguage
curl -H 'Accept: application/json' -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NTY3MjQ0MDUsInVzZXJfbmFtZSI6InNhdGVuZHJhIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiIsIkFETUlOIl0sImp0aSI6IjAxMDVhYWFjLTEwODgtNDcyZi05MmNhLTJiM2Y3MjJjZTFmZiIsImNsaWVudF9pZCI6ImNsaWVudElkIiwic2NvcGUiOlsicmVhZCIsIndyaXRlIl19.M5pI_WkKNmjVvt33Se00h2gXLWQ9w_r8h0soYX29aiX5Cn4fOQfvYV7X26o2k5QIEPMd6dnTXyrYRcK6IVF7jvxYkHwsyiQjhEayR2Coc6ztZCNDhASKUYPqvOut3xLqHdFvgYFaxlXCOHnlvGfUlTvu42XVLgPtF7U-LYE2Ysq2qHvTSmFRx7_u4LIZ57i99quW-5VAofhuTgooptWo_gT9E4vcmTK3eheB74a16DFOC7QgsZy5t21dif8EvQmYBLVvdvLq9029W5WKuJMpQwoSE5OOP3pDOLn7Sypjj7_DA4HsZUC7JDWZiB8xewAeUui7FwbIazbZYcmyuE9l6w" http://localhost:8082/test


{
    "error": "invalid_token",
    "error_description": "Access token expired: eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NTY3MjQ0MDUsInVzZXJfbmFtZSI6InNhdGVuZHJhIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiIsIkFETUlOIl0sImp0aSI6IjAxMDVhYWFjLTEwODgtNDcyZi05MmNhLTJiM2Y3MjJjZTFmZiIsImNsaWVudF9pZCI6ImNsaWVudElkIiwic2NvcGUiOlsicmVhZCIsIndyaXRlIl19.M5pI_WkKNmjVvt33Se00h2gXLWQ9w_r8h0soYX29aiX5Cn4fOQfvYV7X26o2k5QIEPMd6dnTXyrYRcK6IVF7jvxYkHwsyiQjhEayR2Coc6ztZCNDhASKUYPqvOut3xLqHdFvgYFaxlXCOHnlvGfUlTvu42XVLgPtF7U-LYE2Ysq2qHvTSmFRx7_u4LIZ57i99quW-5VAofhuTgooptWo_gT9E4vcmTK3eheB74a16DFOC7QgsZy5t21dif8EvQmYBLVvdvLq9029W5WKuJMpQwoSE5OOP3pDOLn7Sypjj7_DA4HsZUC7JDWZiB8xewAeUui7FwbIazbZYcmyuE9l6w"
}

```

###### 2.1 Use jwt token to access resouce
```jshelllanguage

curl -H 'Accept: application/json' -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NTY3MjQ0MDUsInVzZXJfbmFtZSI6InNhdGVuZHJhIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiIsIkFETUlOIl0sImp0aSI6IjAxMDVhYWFjLTEwODgtNDcyZi05MmNhLTJiM2Y3MjJjZTFmZiIsImNsaWVudF9pZCI6ImNsaWVudElkIiwic2NvcGUiOlsicmVhZCIsIndyaXRlIl19.M5pI_WkKNmjVvt33Se00h2gXLWQ9w_r8h0soYX29aiX5Cn4fOQfvYV7X26o2k5QIEPMd6dnTXyrYRcK6IVF7jvxYkHwsyiQjhEayR2Coc6ztZCNDhASKUYPqvOut3xLqHdFvgYFaxlXCOHnlvGfUlTvu42XVLgPtF7U-LYE2Ysq2qHvTSmFRx7_u4LIZ57i99quW-5VAofhuTgooptWo_gT9E4vcmTK3eheB74a16DFOC7QgsZy5t21dif8EvQmYBLVvdvLq9029W5WKuJMpQwoSE5OOP3pDOLn7Sypjj7_DA4HsZUC7JDWZiB8xewAeUui7FwbIazbZYcmyuE9l6w" http://localhost:8082/test

[
    "one",
    "two",
    "three",
    "four",
    "satendra"
]
```

#### 3. Generate key
```jshelllanguage
satendra@minerva:~/Desktop/key$ keytool -genkeypair -alias mytestkey  -keyalg RSA  -keypass changePass  -keystore keystore.jks  -storepass changePass
What is your first and last name?
  [Unknown]:  Satendra Singh
What is the name of your organizational unit?
  [Unknown]:  
What is the name of your organization?
  [Unknown]:  
What is the name of your City or Locality?
  [Unknown]:  Bangalore
What is the name of your State or Province?
  [Unknown]:  India
What is the two-letter country code for this unit?
  [Unknown]:  IN
Is CN=Satendra Singh, OU=Unknown, O=Unknown, L=Bangalore, ST=India, C=IN correct?
  [no]:  yes




satendra@minerva:~/Desktop/key$ keytool -list -rfc --keystore keystore.jks | openssl x509 -inform pem -pubkey
Enter keystore password:  changePass
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnjghpCwFO6sGQvPX4Yn6
9jSjnglPP32Z/q5Dj3DXf7+dEECqLzjowrbz2+oKF1my0pAEqNmrT7Esf7nmWL9F
tMnOA5skdidFrztJztSox6YpJWaPmguBLV95QJ8z/XdJx/GtXk3SrLevGzcxL4Zc
YnvkpYHPyIb1iv5WNUTa3u5xKDtgElYeWQ2Qg/heiqg85b5co/GUHQnNa9PD/C5v
T68dZsrDnmcQ+8eorVtT+L+d7YsxatryVlyiurjiLjcJ1c0VFFyXdgESOBPHvTV8
MY5ZUUkUeRG4dZ4YkmyOPxp4wL+/21JLt5MFEfmAc16N+eNy1/je1YtgriT9hxSs
bQIDAQAB
-----END PUBLIC KEY-----
-----BEGIN CERTIFICATE-----
MIIDezCCAmOgAwIBAgIEW8o/MTANBgkqhkiG9w0BAQsFADBuMQswCQYDVQQGEwJJ
TjEOMAwGA1UECBMFSW5kaWExEjAQBgNVBAcTCUJhbmdhbG9yZTEQMA4GA1UEChMH
VW5rbm93bjEQMA4GA1UECxMHVW5rbm93bjEXMBUGA1UEAxMOU2F0ZW5kcmEgU2lu
Z2gwHhcNMTkwNTAxMTExMzE1WhcNMTkwNzMwMTExMzE1WjBuMQswCQYDVQQGEwJJ
TjEOMAwGA1UECBMFSW5kaWExEjAQBgNVBAcTCUJhbmdhbG9yZTEQMA4GA1UEChMH
VW5rbm93bjEQMA4GA1UECxMHVW5rbm93bjEXMBUGA1UEAxMOU2F0ZW5kcmEgU2lu
Z2gwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCeOCGkLAU7qwZC89fh
ifr2NKOeCU8/fZn+rkOPcNd/v50QQKovOOjCtvPb6goXWbLSkASo2atPsSx/ueZY
v0W0yc4DmyR2J0WvO0nO1KjHpiklZo+aC4EtX3lAnzP9d0nH8a1eTdKst68bNzEv
hlxie+Slgc/IhvWK/lY1RNre7nEoO2ASVh5ZDZCD+F6KqDzlvlyj8ZQdCc1r08P8
Lm9Prx1mysOeZxD7x6itW1P4v53tizFq2vJWXKK6uOIuNwnVzRUUXJd2ARI4E8e9
NXwxjllRSRR5Ebh1nhiSbI4/GnjAv7/bUku3kwUR+YBzXo3543LX+N7Vi2CuJP2H
FKxtAgMBAAGjITAfMB0GA1UdDgQWBBTMvD1bjg9otD/z6Vb56nXbp4nWkzANBgkq
hkiG9w0BAQsFAAOCAQEAOu0uVs/mohPmTE7uYDxEZapPCDNuS2npcKFqpHiVbkrl
QmhRwREydmarJ6xX/c8cHe3L3AU5kNZwRIGTqujKPdRkCCOaQ0PqHgGkAOXBJChD
muKSuswlGqzdOA0+Fgo/1DvHlAkRCsHlF6BLg5h8FE1kQwgIASrGrTqcfjUO6x3l
q5wv6MprNyE4b7KscU4JYdhASS8Z4tp4IMRLkLvwzaLyHdFVpXPv/U43gApPZceD
qjoLgT7Wl1mHwfd9ziGz43Wj74oSlcTtUM1df09E/vPjv2BmytyblQAydp+JqOjo
64AbwyKQK1GYUMr9sqB0ypZx08kona2iQTvSV/d8nA==
-----END CERTIFICATE-----
satendra@minerva:~/Desktop/key$ 


```

