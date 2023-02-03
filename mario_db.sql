echo hello postgresql;
psql --username=freecodecamp --dbname=postgres

\c mario_database

select * from characters; select * from more_info; select * from sounds; select * from actions; select * from character_actions;
  
 -- characters table                            
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            3 | Peach  | Mushroom Kingdom | Pink           |
|            7 | Yoshi  | Dinosaur Land    | Green          |
|            6 | Daisy  | Sarasaland       | Orange         |
|            1 | Mario  | Mushroom Kingdom | Red            |
|            4 | Toad   | Mushroom Kingdom | Blue           |
|            5 | Bowser | Koopa Kingdom    | Yellow         |
+--------------+--------+------------------+----------------+
(7 rows)

 -- more_info table                               
+--------------+------------+--------------+--------------+--------------+
| more_info_id |  birthday  | height_in_cm | weight_in_kg | character_id |
+--------------+------------+--------------+--------------+--------------+
|            1 | 1981-07-09 |          155 |         64.5 |            1 |
|            2 | 1983-07-14 |          175 |         48.8 |            2 |
|            3 | 1985-10-18 |          173 |         52.2 |            3 |
|            4 | 1950-01-10 |           66 |         35.6 |            4 |
|            5 | 1990-10-29 |          258 |        300.0 |            5 |
|            6 | 1989-07-31 |              |              |            6 |
|            7 | 1990-04-13 |          162 |         59.1 |            7 |
+--------------+------------+--------------+--------------+--------------+
(7 rows)

 --sounds table            
+----------+--------------+--------------+
| sound_id |   filename   | character_id |
+----------+--------------+--------------+
|        1 | its-a-me.wav |            1 |
|        2 | yippee.wav   |            1 |
|        3 | ha-ha.wav    |            2 |
|        4 | oh-yeah.wav  |            2 |
|        5 | yay.wav      |            3 |
|        6 | woo-hoo.wav  |            3 |
|        7 | mm-hmm.wav   |            3 |
|        8 | yahoo.wav    |            1 |
+----------+--------------+--------------+
(8 rows)

 -- action table       
+-----------+--------+
| action_id | action |
+-----------+--------+
|         1 | run    |
|         2 | jump   |
|         3 | duck   |
+-----------+--------+
(3 rows)

-- character_actions table              
+--------------+-----------+
| character_id | action_id |
+--------------+-----------+
|            7 |         1 |
|            7 |         2 |
|            7 |         3 |
|            6 |         1 |
|            6 |         2 |
|            6 |         3 |
|            5 |         1 |
|            5 |         2 |
|            5 |         3 |
|            4 |         1 |
|            4 |         2 |
|            4 |         3 |
|            3 |         1 |
|            3 |         2 |
|            3 |         3 |
|            2 |         1 |
|            2 |         2 |
|            2 |         3 |
|            1 |         1 |
|            1 |         2 |
|            1 |         3 |
+--------------+-----------+
(21 rows)

-- tables relationship

\d characters

--result :
                                             Table "public.characters"
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column     |         Type          | Collation | Nullable |                     Default                      |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id   | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name           | character varying(30) |           | not null |                                                  |
| homeland       | character varying(60) |           |          |                                                  |
| favorite_color | character varying(30) |           |          |                                                  |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
Indexes:
    "characters_pkey" PRIMARY KEY, btree (character_id)
Referenced by:
    TABLE "character_actions" CONSTRAINT "character_actions_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    TABLE "more_info" CONSTRAINT "more_info_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    TABLE "sounds" CONSTRAINT "sounds_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    
    
 \d more_info
 
-- result:
                                        Table "public.more_info"
+--------------+--------------+-----------+----------+-------------------------------------------------+
|    Column    |     Type     | Collation | Nullable |                     Default                     |
+--------------+--------------+-----------+----------+-------------------------------------------------+
| more_info_id | integer      |           | not null | nextval('more_info_more_info_id_seq'::regclass) |
| birthday     | date         |           |          |                                                 |
| height_in_cm | integer      |           |          |                                                 |
| weight_in_kg | numeric(4,1) |           |          |                                                 |
| character_id | integer      |           | not null |                                                 |
+--------------+--------------+-----------+----------+-------------------------------------------------+
Indexes:
    "more_info_pkey" PRIMARY KEY, btree (more_info_id)
    "more_info_character_id_key" UNIQUE CONSTRAINT, btree (character_id)
Foreign-key constraints:
    "more_info_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    
    
   \d sounds
   -- result:
                                    Table "public.sounds"
+--------------+-----------------------+-----------+----------+------------------------------------------+
|    Column    |         Type          | Collation | Nullable |                 Default                  |
+--------------+-----------------------+-----------+----------+------------------------------------------+
| sound_id     | integer               |           | not null | nextval('sounds_sound_id_seq'::regclass) |
| filename     | character varying(40) |           | not null |                                          |
| character_id | integer               |           | not null |                                          |
+--------------+-----------------------+-----------+----------+------------------------------------------+
Indexes:
    "sounds_pkey" PRIMARY KEY, btree (sound_id)
    "sounds_filename_key" UNIQUE CONSTRAINT, btree (filename)
Foreign-key constraints:
    "sounds_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    
    \d character_actions
    --result :
             Table "public.character_actions"
+--------------+---------+-----------+----------+---------+
|    Column    |  Type   | Collation | Nullable | Default |
+--------------+---------+-----------+----------+---------+
| character_id | integer |           | not null |         |
| action_id    | integer |           | not null |         |
+--------------+---------+-----------+----------+---------+
Indexes:
    "character_actions_pkey" PRIMARY KEY, btree (character_id, action_id)
Foreign-key constraints:
    "character_actions_action_id_fkey" FOREIGN KEY (action_id) REFERENCES actions(action_id)
    "character_actions_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)



