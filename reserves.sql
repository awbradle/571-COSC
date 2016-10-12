CREATE TABLE sailors (
sid integer not null,
sname varchar(32),
rating integer,
age real,
CONSTRAINT PK_sailors PRIMARY KEY(sid)
);

CREATE TABLE boats (
bid integer not null,
bname varchar(32),
color varchar(32),
CONSTRAINT PK_boats PRIMARY KEY(bid)
);

CREATE TABLE reserves (
sid integer not null,
bid integer not null,
day datetime not null,
CONSTRAINT PK_reserves PRIMARY KEY(sid, bid, day),
FOREIGN KEY(sid) REFERENCES sailors(sid),
FOREIGN KEY(bid) REFERENCES boats(bid)
);
