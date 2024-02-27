insert into users values (97,'Connor McDavid','cm@nhl.com','Edmonton',-7);
insert into users values (29,'Leon Draisaitl','ld@nhl.com','Edmonton',-7);
insert into users values (5,'Davood Rafiei','dr@ualberta.ca','Edmonton',-7);z

insert into follows values (29,97,'2021-01-10');
insert into follows values (97,29,'2021-09-01');
insert into follows values (5,97,'2022-11-15');

insert into tweets values (5,'2023-06-01','Looking for a good book to read. Just finished lone #survivor', null, null);
insert into tweets values (97,'2023-02-12','#Edmonton #Oilers had a good game last night.',null,null);
insert into tweets values (5,'2023-03-01','Go oliers!',97,'2023-02-12');

insert into hashtags values ('survivor');
insert into hashtags values ('oilers');
insert into hashtags values ('edmonton');

insert into mentions values (5,'2023-06-01', 'survivor');
insert into mentions values (97,'2023-02-12', 'edmonton');
insert into mentions values (97,'2023-02-12', 'oilers');

insert into retweets values (29,97,'2023-02-12','2023-02-13');

insert into lists values ('oilers players',5);
insert into lists values ('pc',5);
insert into lists values ('liberal',5);
insert into lists values ('ndp',5);

insert into includes values ('oilers players',97);
insert into includes values ('oilers players',29);
