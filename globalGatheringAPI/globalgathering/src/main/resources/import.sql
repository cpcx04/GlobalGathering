INSERT INTO client (id, username, full_name, password, email,avatar, role, account_non_expired, account_non_locked, credentials_non_expired, enabled, banned) VALUES ('e062bb13-56e8-43ff-94d8-59adea71a0c6', 'cristianpc', 'Cristian Pulido', '{bcrypt}$2a$10$O9gBlJqfCKUMVkDYxYs/puwiXpuVfWTMTBjql6x07T8bl8yXXBSi.', 'pulidocabellochristian@gmail.com','https://www.shareicon.net/data/2016/09/01/822739_user_512x512.png', 'ADMIN', TRUE, TRUE, TRUE, TRUE,FALSE);
INSERT  INTO client_worker (id, jefe)  VALUES ('e062bb13-56e8-43ff-94d8-59adea71a0c6', TRUE);
-- Usuario 2
INSERT INTO client (id, username, full_name, password, email, avatar, role, account_non_expired, account_non_locked, credentials_non_expired, enabled,banned) VALUES ('e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf', 'juancarlosgamer', 'Nombre Usuario 2', '{bcrypt}$2a$10$O9gBlJqfCKUMVkDYxYs/puwiXpuVfWTMTBjql6x07T8bl8yXXBSi.', 'usuario2@gmail.com', 'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector.png', 'USER', TRUE, TRUE, TRUE, TRUE,TRUE);

INSERT INTO client_worker (id, jefe) VALUES ('e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf', FALSE);

-- Usuario 3
INSERT INTO client (id, username, full_name, password, email, avatar, role, account_non_expired, account_non_locked, credentials_non_expired, enabled,banned) VALUES ('6465de6a-102c-4a05-8151-9fe209ecf534', 'viajerotrapero', 'Nombre Usuario 3', '{bcrypt}$2a$10$O9gBlJqfCKUMVkDYxYs/puwiXpuVfWTMTBjql6x07T8bl8yXXBSi.', 'usuario3@gmail.com', 'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Pic.png', 'USER', TRUE, TRUE, TRUE, TRUE,FALSE);

-- Asociación de Usuario 3 como trabajador de Usuario 1 (cristianpc)
INSERT INTO client_worker (id, jefe) VALUES ('6465de6a-102c-4a05-8151-9fe209ecf534', FALSE);


INSERT  INTO event (id, name,descripcion,url,latitude, longitude, date, price, created_by_id,ciudad,abierto) VALUES ('c5827e72-f2cf-4889-811c-85d6313bdf1e', 'Tour RSP','Tour por la casa del Sevilla Fc','https://sevillafc.es/sites/default/files/inline-images/estadio-ramon.png', 37.38719483261625, -5.971153027846458,CURRENT_DATE, 12, 'e062bb13-56e8-43ff-94d8-59adea71a0c6','Sevilla',true);

INSERT INTO event (id, name, descripcion, url, latitude, longitude, date, price, created_by_id, ciudad, abierto)VALUES ('550e8400-e29b-41d4-a716-446655440000','Catedral de Sevilla', 'Visita a la famosa Catedral de Sevilla','https://www.lacatedraldesevilla.org/img/catedral-sevilla-1.jpg',37.39357029098547, -5.992938705028886,CURRENT_DATE, 10,'e062bb13-56e8-43ff-94d8-59adea71a0c6', 'Sevilla', true);

INSERT INTO event (id, name, descripcion, url, latitude, longitude, date, price, created_by_id, ciudad, abierto)VALUES ('7c9e6679-7425-40de-944b-e07fc1f90ae7','Parque de Maria Luisa','Paseo en el hermoso Parque de Maria Luisa','https://offloadmedia.feverup.com/sevillasecreta.co/wp-content/uploads/2020/06/24070607/shutterstock_1324665797-1-1024x651.jpg',37.37653714861036, -5.988489945558949,CURRENT_DATE, 15,'e062bb13-56e8-43ff-94d8-59adea71a0c6', 'Sevilla', true);

INSERT INTO event (id, name, descripcion, url, latitude, longitude, date, price, created_by_id, ciudad, abierto)VALUES ('123e4567-e89b-12d3-a456-426614174001','Benito Villamarin','Tour por el Splendido Benito Villamarin','https://www.eldeportedejaen.com/blog/wp-content/uploads/2021/03/estadio-benito-villamarin.jpg',37.360420552521376, -5.983260220127166,CURRENT_DATE, 20,'e062bb13-56e8-43ff-94d8-59adea71a0c6', 'Sevilla', true);

INSERT INTO comments (id, content, posted_by_id) VALUES ('3dfeae2b-e202-41f5-81f9-85bdec7c7934', 'Los mejores 20 euros en invertidos en mi vida fueron la excursion al parque de bolas', 'e062bb13-56e8-43ff-94d8-59adea71a0c6');
INSERT INTO comments (id, content, posted_by_id) VALUES ('2a2ba9ae-e36e-49ab-a5de-5ac81a2b78bc', 'El viaje a croacia nos ayudo a desconectar #CroaciaMola#Trips', '6465de6a-102c-4a05-8151-9fe209ecf534');
INSERT INTO comments (id, content, posted_by_id) VALUES ('f9270d61-a605-4cb6-b861-512e6e8f6067', 'Me parece increible que Las Maldivas no sea patrimonio universal jajajajaja #Flipo#Increible', 'e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf');
INSERT INTO comments (id, content, posted_by_id) VALUES ('4e12b1d1-91c0-42d1-8fe3-d8f7c9362b52', 'La comida en Japon es simplemente espectacular. Recomiendo probar el sushi.', '6465de6a-102c-4a05-8151-9fe209ecf534');
INSERT INTO comments (id, content, posted_by_id) VALUES ('78b8e9cf-63a7-4ea9-bf4e-bfe7f786a457', 'Hice una caminata en los Alpes suizos y las vistas fueron impresionantes. #Naturaleza', 'e062bb13-56e8-43ff-94d8-59adea71a0c6');
INSERT INTO comments (id, content, posted_by_id) VALUES ('9a4e6857-36b9-47fc-a85e-8620eb141fb4', 'Explorando las ruinas de Machu Picchu. Una experiencia inolvidable.', 'e062bb13-56e8-43ff-94d8-59adea71a0c6');
INSERT INTO comments (id, content, posted_by_id) VALUES ('1f39e924-120d-41d3-b9e1-87ab2706e727', 'En Pariss, la Torre Eiffel ilumina la ciudad cada noche. #Romance', 'e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf');
INSERT INTO comments (id, content, posted_by_id) VALUES ('6c7c33e7-9b57-45c3-90e5-2f8e6f171ed2', 'Recorriendo las calles historicas de Roma. #Cultura', '6465de6a-102c-4a05-8151-9fe209ecf534');
INSERT INTO comments (id, content, posted_by_id) VALUES ('8231b33a-37b9-4a3e-8905-8e9f91aa1b56', 'Disfrutando de la playa en Bali. Arena blanca y aguas cristalinas.', 'e062bb13-56e8-43ff-94d8-59adea71a0c6');
INSERT INTO comments (id, content, posted_by_id) VALUES ('0dab9d16-7406-4c4f-849b-855f9a2ed88b', 'Visite la Gran Muralla China y quede maravillado por su grandeza.', 'e062bb13-56e8-43ff-94d8-59adea71a0c6');
INSERT INTO comments (id, content, posted_by_id) VALUES ('c0d1a16d-6bbd-4049-86d4-cd070862160f', 'Aventura en el Amazonas. Naturaleza en su maxima expresion.', '6465de6a-102c-4a05-8151-9fe209ecf534');
INSERT INTO comments (id, content, posted_by_id) VALUES ('e542c583-2b19-4c7d-b267-99f4c8bce00c', 'Viviendo la magia de Disney en Orlando. #MagicKingdom', 'e062bb13-56e8-43ff-94d8-59adea71a0c6');
INSERT INTO comments (id, content, posted_by_id) VALUES ('5f1633c9-13ae-4e14-88a2-308a3f6d2e54', 'Explore la Ciudad Prohibida en Pekin. Una joya arquitectonica.', 'e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf');

-- Posts
INSERT INTO post (id, related_event_id, comment, uri, created_by, created_at) VALUES ('02e914fc-e3aa-4f83-86c0-8b8933f0c65b', 'c5827e72-f2cf-4889-811c-85d6313bdf1e', 'Tremendo este chico, estuvo en el tour', 'http://localhost:8080/download/GBFdd0SWMAAHX1G.jpg', 'cristianpc', '2024-06-10T13:03:39.926341');
INSERT INTO post (id, related_event_id, comment, uri, created_by, created_at) VALUES ('e857c626-9fee-457a-8cfc-6e0a47ea70d4', '7c9e6679-7425-40de-944b-e07fc1f90ae7', 'Estuve de paso por aqui cuando fui a visitar el parque de maria luisa', 'http://localhost:8080/download/photo-of-concrete-building-near-dock-during-night-time-andalucia-andalucia-wallpaper-thumb.jpg', 'cristianpc', '2024-05-8T13:03:39.926341');