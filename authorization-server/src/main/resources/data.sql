-- The encrypted password is `Sat@123`
INSERT INTO users (id, username, password, enabled, account_non_Expired, account_non_Locked, credentials_non_Expired) VALUES (1, 'satendra', '$2a$10$LASBtC5XXjjQSyN4Y7o9C.9aTjDFyAZ/0xG9mdu2kK9nQuarlB582', true, true,true,true);


-- The encrypted password is `client-secret`
INSERT INTO oauth_client_details (client_id, client_secret, scope, authorized_grant_types, authorities, access_token_validity) VALUES ('clientId', '$2a$10$Ych6kpYiY4kPUf8P9wBahexBJk9bS1UYxZDRg8gi71TVHGPkpCEmq', 'read,write', 'password,refresh_token,client_credentials', 'ROLE_CLIENT', 300);


INSERT INTO authorities (id, user_id, authority) VALUES (1, 1, 'ADMIN');
INSERT INTO authorities (id, user_id, authority) VALUES (2, 1, 'USER');