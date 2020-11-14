MATCH ()-[R]-() DELETE R;
MATCH (A) DELETE A;
LOAD CSV WITH HEADERS FROM 'http://localhost:8000/employees.csv' AS row
MERGE (e:Employee {email: row.Email, name: row.Name})
WITH e, row
UNWIND split(row.Skills, ':') AS skill
MERGE (s:Skill {name: skill})
MERGE (e)-[r:HAS_EXPERIENCE]->(s);
