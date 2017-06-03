--
-- PostgreSQL useful

-- This function is created to return the value of slug column, preceded by '/article/' to match path in log table
create or replace function trans(value text)
returns text as $inc$
begin
return '/article/' || value;
end;
$inc$ language plpgsql;

-- This function is created to return the value of "time column" formatted to a day representation 
create or replace function day_trans(value timestamp with time zone) 
returns timestamp as $dmc$
begin return date_trunc('day', value); 
end; 
$dmc$ language plpgsql;

-- This view is for returning a table where we have the different articles and their author
CREATE VIEW ceasar AS SELECT authors.name AS name, articles.title AS title FROM authors JOIN articles ON authors.id = articles.author GROUP BY name, title;

-- This view is for returning the number of view for a article
CREATE VIEW bestceasar AS SELECT articles.title AS Title, count(path) AS Time FROM articles JOIN Log ON trans(articles.slug) = Log.path GROUP BY Title;

-- This view is for returning the authors and the number of view corresponding to the articles
CREATE VIEW orderdo AS SELECT name, bestceasar.time FROM ceasar join bestceasar on ceasar.title =  bestceasar.title GROUP BY name,bestceasar.time ORDER BY  time DESC;

-- This view we sum the different view for an author, group by author
CREATE VIEW author_rank AS SELECT name, sum(time) FROM orderdo GROUP BY name ORDER BY  sum DESC;

-- This view is for returning the different days and the number of corresponding errors
CREATE VIEW herror AS SELECT day_trans(time) AS day, count(time) AS Nbrerror FROM log where status = '404 NOT FOUND' GROUP BY day ORDER BY day ASC;

-- This view is for returning the different days and the corresponding total value of requests
CREATE VIEW herror2 AS SELECT day_trans(time) AS day, count(time) AS Nbrtotal FROM log GROUP BY day ORDER BY day ASC;

-- This view is for returning a table where we mix day, number of error and total number of requests
CREATE VIEW herror3 AS SELECT herror.day AS day, herror.Nbrerror AS error, herror2.Nbrtotal AS total FROM herror join herror2
 on herror.day = herror2.day GROUP BY herror.day, error, total ORDER BY day DESC;

-- This view is for returning a table where we have a column for day and the other for the corresponding percentage of error
CREATE VIEW days AS SELECT day, (error*100/total::float) AS value FROM herror3;
