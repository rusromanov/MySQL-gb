DROP database IF EXISTS vk_test;
CREATE database vk_test;
use vk_test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY , -- int unsigned NOT NULL AUTO_INCREMENT UNIQUE
	firstname varchar (100),
	lastname varchar (100),
	email varchar (150) UNIQUE,
	password_hash varchar (200),
	phone bigint,

	INDEX users_phone_idx(phone),
	INDEX (firstname, lastname)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
	gender char (1),
	birthday date,
	photo_id bigint unsigned NULL,
	hometown varchar (100),
	created_at datetime DEFAULT now(),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id bigint unsigned NOT NULL,
	to_user_id bigint unsigned NOT NULL,
	body text,
	created_at datetime DEFAULT now(),
	
	INDEX (from_user_id),
	INDEX (to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id bigint unsigned NOT NULL,
	target_user_id bigint unsigned NOT NULL,
	status enum('requested','approved','unfriended','declined'),
	requested_at datetime DEFAULT now(),
	updated_at datetime ON UPDATE current_timestamp,
	
	PRIMARY KEY (initiator_user_id, target_user_id),
	FOREIGN KEY (initiator_user_id) REFERENCES users(id),
	FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name varchar(100),
	admin_user_id bigint unsigned NOT NULL,
	
	INDEX (name),
	INDEX (admin_user_id),
	FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id bigint unsigned NOT NULL,
	community_id bigint unsigned NOT NULL,
	created_at datetime DEFAULT now(),
	
	PRIMARY KEY (user_id, community_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
	id SERIAL PRIMARY KEY,
	name varchar(225)
);

DROP TABLE IF EXISTS media;
CREATE TABLE media (
	id SERIAL PRIMARY KEY,
	media_type_id bigint unsigned NOT NULL,
	user_id bigint unsigned NOT NULL,
	body text,
	filename varchar(225),
	file_size int,
	metadata JSON,
	created_at datetime DEFAULT now(),
	updated_at datetime ON UPDATE current_timestamp,
	
	INDEX (user_id),
	FOREIGN KEY (media_type_id) REFERENCES media_types(id),
	FOREIGN KEY (user_id) REFERENCES users(id)	
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
	id SERIAL PRIMARY KEY,
	user_id bigint unsigned NOT NULL,
	media_id bigint unsigned NOT NULL,
	created_at datetime DEFAULT now()
);

DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums (
	id SERIAL,
	name varchar(225),
	user_id bigint unsigned NOT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
	id SERIAL,
	album_id bigint unsigned NULL,
	media_id bigint unsigned NOT NULL,
	
	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
	
);
