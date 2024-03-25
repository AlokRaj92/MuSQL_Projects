create database analysis;
use analysis;

-- Create Table 1

create table character_tab(
id int8, name varchar(50));
insert into character_tab(id,name)
values
(1, 'Doogie Howser'),
(2, 'Barney Stinson'),
(3, 'Lily Aldrin'),
(4, 'Willow Rosernbery');

-- Create Table 2

create table character_tv_show(id int8, character_id int8 , tv_show_id int8);
insert into character_tv_show(id,character_id,tv_show_id)
values(1,1,3),(2,2,2),(3,3,2),(4,4,1);


-- Create Table 3

create table tv_show(id int8, name varchar(70));
insert into tv_show(id,name)
values(1,'Buffy The Vampire Slayer'),(2,'How I Met Your Mother'),(3,'Doogi Howser M.D.');


-- Create Table 4

create table actor(id int8, name varchar(50));
insert into actor(id,name)
values(1,'Alyson Hannigan'),(2,'Neil Patrick Harris');

-- Create Table 5

create table character_actor(id int8, character_id int8, actor_id int8);
insert into character_actor(id,character_id,actor_id)
values(1,1,2),(2,2,2),(3,3,1),(4,4,1);

-- Question and Answer

-- Question.1)Use two joins to pair each character name with the actor who plays them ? Select the column (character.name,actor.name).

select character_tab.name, actor.name from character_tab
inner join character_actor on
character_tab.id = character_actor.character_id
inner join actor on
actor.id = character_actor.actor_id;

-- Question.2) To get each character name with his/her tv show name ?

select character_tab.name,tv_show.name from character_tab
inner join character_tv_show on
character_tab.id = character_tv_show.character_id
inner join tv_show on
character_tv_show.tv_show_id = tv_show.id;


-- Question.3) Return a list of characters and tv shows that are not names "Willow Rosenberg" and in the show "How I Met Your Mother" ?

select character_tab.name, tv_show.name from character_tab
inner join character_tv_show on
character_tab.id = character_tv_show.character_id
inner join tv_show on
tv_show.id = character_tv_show.tv_show_id
where character_tab.name != "Willow Rosenberg" and
tv_show.name != "How I Met Your Mother";


-- Question.4) Use left joins to match character names with the actors that play them? Select the columns (character.name , actor.name).

select character_tab.name,actor.name from character_tab
left join character_actor on
character_tab.id = character_actor.character_id
left join actor on
character_actor.actor_id = actor.id;

-- Self-Join

create table employees1(id int8, name varchar(50), title varchar(50), boss_id int8);
insert into employees1(id,name,title,boss_id)
values(1,'Patrick Smith','Software Engineer',2),
(2,'Abligail Reed','Engineering Manager',3),
(3,'Bob Carey','Director of Engineering',4),
(4,'Maxine Tang','CEO',null);

-- Question.5) Run a query that returns the name of an employee and the name of their boss ? use column aliases to make the columns employee_name and boss_name.

select e1.name as employee_name, e2.name as boss_name from employees1 as e1
inner join employees1 as e2 on 
e1.boss_id = e2.id;