DROP DATABASE IF EXISTS gameservice;
CREATE DATABASE IF NOT EXISTS gameservice;
USE gameservice;
DROP TABLE IF EXISTS platforms, players, servers, items;

create table platforms (
  platform_id varchar(8) not null,
  name varchar(32),
  owner varchar(32),
  pricing float,
  sales int,
  primary key (platform_id)
);
insert into platforms values ("WIIU", "Wii U", "Nintendo", 40.00, 1000);
insert into platforms values ("SWITCH", "Nintendo Switch", "Nintendo", 60.00, 25000);
insert into platforms values ("PS3", "Playstation 3", "Sony", 40.00, 9000);
insert into platforms values ("PS4", "Playstation 4", "Sony", 60.00, 23000);
insert into platforms values ("PS5", "Playstation 5", "Sony", 60.00, 21000);
insert into platforms values ("XB360", "Xbox 360", "Microsoft", 40.00, 12000);
insert into platforms values ("XB1", "Xbox One", "Microsoft", 60.00, 26000);
insert into platforms values ("XBSX", "Xbox Series X", "Microsoft", 60.00, 19000);
insert into platforms values ("STEAM", "Steam", "Valve", 50.00, 150000);
insert into platforms values ("EPIC", "Epic Games Store", "Epic Games", 50.00, 90000);

create table players (
  player_id varchar(12) not null,
  platform_id varchar(8) not null,
  name varchar(32) not null,
  primary key (player_id),
  foreign key (platform_id) references platforms(platform_id)
);
insert into players values ("594722522446", "STEAM", "AllisonPlays");
insert into players values ("594722523446", "XBSX", "DisguisedKitten");
insert into players values ("594725528446", "SWITCH", "thomasmatthews2005");
insert into players values ("594722333496", "XB1", "Emality");
insert into players values ("599527132446", "STEAM", "Allielife");
insert into players values ("594722982446", "EPIC", "Garrisonior");
insert into players values ("594722502646", "STEAM", "papaya");
insert into players values ("547432520446", "WIIU", "Niamh Murphy");
insert into players values ("594720282446", "STEAM", "festive noisemaker");
insert into players values ("694702577446", "PS5", "MaddyClimbs");

create table servers (
  server_id varchar(12) not null,
  platform_id varchar(8) not null,
  player_id varchar(12) not null,
  name varchar(32) not null,
  location varchar(16) not null,
  primary key (server_id),
  foreign key (platform_id) references platforms(platform_id),
  foreign key (player_id) references players(player_id) on delete cascade
);
insert into servers values ("000000000329", "STEAM", "594722502646", "Official PC Server 3", "EU");
insert into servers values ("000000001686", "STEAM", "594722502646", "Official PC Server 4", "EU");
insert into servers values ("000000005906", "STEAM", "594722502646", "Official PC Server 8", "ASIA");
insert into servers values ("000000001943", "STEAM", "594722502646", "Official PC Server 11", "US-CENTRAL");
insert into servers values ("000000007318", "STEAM", "594722502646", "Official PC Server 13", "US-WEST");
insert into servers values ("000000005142", "STEAM", "594720282446", "the funny zone", "EU");
insert into servers values ("000000008438", "STEAM", "594722522446", "Allisons Alley NA", "US-CENTRAL");
insert into servers values ("000000009094", "STEAM", "594722522446", "Allisons Alley EU", "EU");
insert into servers values ("000000006573", "SWITCH", "594722502646", "Official Switch Server 2", "ASIA");
insert into servers values ("000000005122", "PS5", "594722502646", "Official PS5 Server 4", "EU");

create table items (
  item_id varchar(12) not null,
  item_type varchar(32) not null,
  creation_date int(32) not null,
  item_name varchar(12),
  player_id varchar(12) not null,
  primary key (item_id),
  foreign key (player_id) references players(player_id) on delete cascade
);
insert into items values ("291384798235", "cowering_hat", 1616419341, "Scaredy Hat", "594722522446");
insert into items values ("598748252189", "demeaning_showl", 1578671440, "", "594722982446");
insert into items values ("632356448941", "rotating_skirt", 1649304763, "the spinner", "594722502646");
insert into items values ("831610863354", "overbearing_overcoat", 1530423839, "thiccums", "594720282446");
insert into items values ("860763853015", "inexpensive_gest", 1535352421, "", "594722333496");
insert into items values ("948206669579", "rotating_skirt", 1485626278, "", "594722982446");
insert into items values ("850259986450", "suspicious_stare", 1623862380, "the pretender", "599527132446");
insert into items values ("206336227507", "jumping_jacket", 1554106868, "The Speedster", "594722333496");
insert into items values ("496789188508", "hysterical_handbag", 1549315259, "", "547432520446");
insert into items values ("189225318711", "notorious_knot", 1603282848, "the funny hat", "594720282446");

/*
1. Show all players and the name of the platform they own the game on.
*/
select ply.name, plt.name from players ply join platforms plt using (platform_id);

/*
2. Show the names of all players on Steam, and their player IDs.
*/
select players.player_id, players.name from players where platform_id = "STEAM";

/*
3. Show all items with custom names, and their identifiers.
*/
select item_type, item_name from items where item_name != "";

/*
4. Shows all players who own atleast one item.
*/
select distinct players.name from items join players using (player_id);

/*
5. Gets the oldest item, it's custom name and it's owner.
*/
select item_type, item_name, players.name as "owner_name" from items join players order by creation_date desc limit 1;

/*
6. Release the game onto a new platform and put it on discount.
*/
select * from platforms order by pricing;
insert into platforms values ("ITCH", "Itch.io", "Leaf Corcoran", 50.00, 0);
select * from platforms order by pricing;
update platforms set pricing = 30.00 where platform_id = "ITCH";
select * from platforms order by pricing;

/*
7. Altars the player table to keep track of how many times a player has been reported, and counts 5 reports for Garrisonior.
*/
select * from players;
alter table players add report_count int(3) not null;
select * from players;
update players set report_count = 5 where player_id = 594722982446;
select * from players where player_id = 594722982446;

/*
8. Shows the last player to get an item and the time it happened at.
*/
select players.name, items.item_type, from_unixtime(items.creation_date) from items join players using (player_id) order by items.creation_date desc limit 1;

/*
9. Updates an item's creation time to 5 hours prior to now.
*/
select items.item_id, from_unixtime(items.creation_date) from items where item_id = "291384798235";
update items set creation_date = unix_timestamp(date_sub(now(), interval 5 hour)) where item_id = "291384798235";
select items.item_id, from_unixtime(items.creation_date) from items where item_id = "291384798235";

/*
10. Shows the number of items created on each day of the week, ordered by number of items.
*/
select dayname(from_unixtime(items.creation_date)), count(items.creation_date) as day_count from players, items where players.player_id = items.player_id group by dayname(from_unixtime(items.creation_date)) having day_count > 0 order by day_count desc;

/*
11. Displays every item, the player who owns it's username and the date of creation of the item. Ordered by the player's name.
*/
select players.name, items.item_type, from_unixtime(items.creation_date) from items join players using (player_id) order by players.name;

/*
12. Creates a new item at the current time.
*/
select * from items where player_id = "547432520446";
insert into items values ("295384712222", "backwards_bowtie", unix_timestamp(now()), "The Blowtie", "547432520446");
select * from items where player_id = "547432520446";

/*
13. Finds the platform with the lowest price for the game, and the price it charges.
*/
select name, pricing from platforms order by pricing limit 1;

/*
14. Deletes a players account, as well as all servers and items they own.
*/
select player_id, name from players;
delete from players where player_id = 594722982446;
select player_id, name from players;

/*
15. Creates a new server and hands it over to a new user.
*/
select * from servers;
insert into servers values ("000000012422", "STEAM", "599527132446", "The Underground", "ASIA");
select * from servers;
insert into players values ("719991112446", "STEAM", "Hatsune Miku", 0);
update servers set player_id = 719991112446 where server_id = "000000012422";
select * from servers;

/*
16. Show players who own a server and the number of servers they own.
*/
select players.name, count(players.name) as server_count from players, servers where players.player_id = servers.player_id group by servers.player_id having server_count > 0;