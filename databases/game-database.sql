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
select * from platforms;

create table players (
  player_id varchar(12) not null,
  platform_id varchar(8) not null,
  name varchar(32) not null,
  primary key (player_id),
  foreign key (platform_id) references platform(platform_id));
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
select * from players;

create table servers (
  server_id varchar(12) not null,
  platform_id varchar(8) not null,
  owner varchar(12) not null,
  name varchar(32) not null,
  location varchar(16) not null,
  primary key (server_id),
  foreign key (platform_id) references platform(platform_id),
  foreign key (owner) references players(player_id));
insert into servers values ("000000000329", "STEAM", "594722502646", "Official PC Server 3", "EU");
insert into servers values ("000000001686", "STEAM", "594722502646", "Official PC Server 4", "EU");
insert into servers values ("000000005906", "STEAM", "594722502646", "Official PC Server 8", "ASIA");
insert into servers values ("000000001943", "STEAM", "594722502646", "Official PC Server 11", "US-CENTRAL");
insert into servers values ("000000007318", "STEAM", "594722502646", "Official PC Server 13", "US-WEST");
insert into servers values ("000000005142", "STEAM", "594720282446", "the funny zone", "EU");
insert into servers values ("000000008438", "STEAM", "594722522446", "Allison's Alley NA", "US-CENTRAL");
insert into servers values ("000000009094", "STEAM", "594722522446", "Allison's Alley EU", "EU");
insert into servers values ("000000006573", "SWITCH", "594722502646", "Official Switch Server 2", "ASIA");
insert into servers values ("000000005122", "PS5", "594722502646", "Official PS5 Server 4", "EU");
select * from servers;

create table items (
  item_id varchar(12) not null,
  item_type varchar(32) not null,
  item_name varchar(12),
  owner varchar(12) not null,
  primary key (item_id),
  foreign key (owner) references players(player_id));
insert into items values ("291384798235", "cowering_hat", "Scaredy Hat", "594722522446");
insert into items values ("598748252189", "demeaning_showl", "", "594722982446");
insert into items values ("632356448941", "rotating_skirt", "the spinner", "594722502646");
insert into items values ("831610863354", "overbearing_overcoat", "thiccums", "594720282446");
insert into items values ("860763853015", "inexpensive_gest", "", "594722333496");
insert into items values ("948206669579", "rotating_skirt", "", "594722982446");
insert into items values ("850259986450", "suspicious_stare", "the pretender", "599527132446");
insert into items values ("206336227507", "jumping_jacket", "The Speedster", "594722333496");
insert into items values ("496789188508", "hysterical_handbag", "", "547432520446");
insert into items values ("189225318711", "notorious_knot", "the funny hat", "594720282446");
select * from items;