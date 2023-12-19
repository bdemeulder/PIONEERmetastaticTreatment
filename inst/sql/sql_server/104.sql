CREATE TABLE #Codesets (
  codeset_id int NOT NULL,
  concept_id bigint NOT NULL
)
;

INSERT INTO #Codesets (codeset_id, concept_id)
SELECT 1 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (432851,4205430,4201930,4264861,4264288,4246703,763131)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (432851,4205430,4201930)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 2 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4163261,37208188)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (4163261,37208188)
  and c.invalid_reason is null

) I
LEFT JOIN
(
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4314337)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (4314337)
  and c.invalid_reason is null

) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 6 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (36769180,1635142)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (36769180,1635142)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 7 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (3006575)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (3006575)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 10 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (443392,4312326)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (443392,4312326)
  and c.invalid_reason is null

) I
LEFT JOIN
(
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (432851,4112752,4111921,764971,36716186,200962,36712762,37395835,4164017,4141960,4163261,4183913,4283614,4289246,4283740,4280897,4289379)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (432851,4112752,4111921,764971,36716186,200962,36712762,37395835,4164017,4141960,4163261,4183913,4283614,4289246,4283740,4280897,4289379)
  and c.invalid_reason is null

) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 11 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (19058410,739471,35834903,1343039,19089810,1366310,1351541,1344381,19010792,1356461,1500211,1300978,1315286,35807385,35807349)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (19058410,739471,35834903,1343039,19089810,1366310,1351541,1344381,19010792,1356461,1500211,1300978,1315286,35807385,35807349)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 13 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4304921,4341536,4145907)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (4304921,4341536,4145907)
  and c.invalid_reason is null

) I
LEFT JOIN
(
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4012324,35608156,35624545,35624534,35624540,35624546,35624535,35624541,35624539,4021070,2780498,2780499,2780496,2780497,2780494,2780495,35624537,35624542)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (4012324)
  and c.invalid_reason is null

) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 14 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (40239056,963987,42900250,1361291)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (40239056,963987,42900250,1361291)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 15 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (1315942,40222431,1378382)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (1315942,40222431,1378382)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 16 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (40239056,963987,1361291,1315942,42900250)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (40239056,963987,1361291,1315942,42900250)
  and c.invalid_reason is null

) I
) C
;

SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, visit_occurrence_id
INTO #qualified_events
FROM 
(
  select pe.event_id, pe.person_id, pe.start_date, pe.end_date, pe.op_start_date, pe.op_end_date, row_number() over (partition by pe.person_id order by pe.start_date ASC) as ordinal, cast(pe.visit_occurrence_id as bigint) as visit_occurrence_id
  FROM (-- Begin Primary Events
select P.ordinal as event_id, P.person_id, P.start_date, P.end_date, op_start_date, op_end_date, cast(P.visit_occurrence_id as bigint) as visit_occurrence_id
FROM
(
  select E.person_id, E.start_date, E.end_date,
         row_number() OVER (PARTITION BY E.person_id ORDER BY E.sort_date ASC, E.event_id) ordinal,
         OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date, cast(E.visit_occurrence_id as bigint) as visit_occurrence_id
  FROM 
  (
  -- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 11)
) C

WHERE (C.drug_exposure_start_date >= DATEFROMPARTS(2016, 1, 1) and C.drug_exposure_start_date <= DATEFROMPARTS(2020, 12, 31))
-- End Drug Exposure Criteria

UNION ALL
-- Begin Procedure Occurrence Criteria
select C.person_id, C.procedure_occurrence_id as event_id, C.procedure_date as start_date, DATEADD(d,1,C.procedure_date) as END_DATE,
       C.visit_occurrence_id, C.procedure_date as sort_date
from 
(
  select po.* 
  FROM @cdm_database_schema.PROCEDURE_OCCURRENCE po
JOIN #Codesets cs on (po.procedure_concept_id = cs.concept_id and cs.codeset_id = 13)
) C

WHERE (C.procedure_date >= DATEFROMPARTS(2016, 1, 1) and C.procedure_date <= DATEFROMPARTS(2020, 12, 31))
-- End Procedure Occurrence Criteria

UNION ALL
select PE.person_id, PE.event_id, PE.start_date, PE.end_date, PE.visit_occurrence_id, PE.sort_date FROM (
-- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 16)
) C

WHERE (C.drug_exposure_start_date >= DATEFROMPARTS(2016, 1, 1) and C.drug_exposure_start_date <= DATEFROMPARTS(2020, 12, 31))
-- End Drug Exposure Criteria

) PE
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 16)
) C

WHERE (C.drug_exposure_start_date >= DATEFROMPARTS(2016, 1, 1) and C.drug_exposure_start_date <= DATEFROMPARTS(2020, 12, 31))
-- End Drug Exposure Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 16)
) C

WHERE (C.drug_exposure_start_date >= DATEFROMPARTS(2016, 1, 1) and C.drug_exposure_start_date <= DATEFROMPARTS(2020, 12, 31))
-- End Drug Exposure Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) P
JOIN (
  -- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 11)
) C


-- End Drug Exposure Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,0,P.START_DATE) AND A.START_DATE <= DATEADD(day,183,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

UNION ALL
-- Begin Correlated Criteria
select 1 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 16)
) C

WHERE (C.drug_exposure_start_date >= DATEFROMPARTS(2016, 1, 1) and C.drug_exposure_start_date <= DATEFROMPARTS(2020, 12, 31))
-- End Drug Exposure Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) P
JOIN (
  -- Begin Procedure Occurrence Criteria
select C.person_id, C.procedure_occurrence_id as event_id, C.procedure_date as start_date, DATEADD(d,1,C.procedure_date) as END_DATE,
       C.visit_occurrence_id, C.procedure_date as sort_date
from 
(
  select po.* 
  FROM @cdm_database_schema.PROCEDURE_OCCURRENCE po
JOIN #Codesets cs on (po.procedure_concept_id = cs.concept_id and cs.codeset_id = 13)
) C


-- End Procedure Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,0,P.START_DATE) AND A.START_DATE <= DATEADD(day,183,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) > 0
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id and AC.event_id = pe.event_id

  ) E
	JOIN @cdm_database_schema.observation_period OP on E.person_id = OP.person_id and E.start_date >=  OP.observation_period_start_date and E.start_date <= op.observation_period_end_date
  WHERE DATEADD(day,183,OP.OBSERVATION_PERIOD_START_DATE) <= E.START_DATE AND DATEADD(day,183,E.START_DATE) <= OP.OBSERVATION_PERIOD_END_DATE
) P
WHERE P.ordinal = 1
-- End Primary Events
) pe
  
) QE

;

--- Inclusion Rule Inserts

select 0 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_0
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Demographic Criteria
SELECT 0 as index_id, e.person_id, e.event_id
FROM #qualified_events E
JOIN @cdm_database_schema.PERSON P ON P.PERSON_ID = E.PERSON_ID
WHERE P.gender_concept_id in (8507)
GROUP BY e.person_id, e.event_id
-- End Demographic Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

select 1 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_1
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Demographic Criteria
SELECT 0 as index_id, e.person_id, e.event_id
FROM #qualified_events E
JOIN @cdm_database_schema.PERSON P ON P.PERSON_ID = E.PERSON_ID
WHERE YEAR(E.start_date) - P.year_of_birth >= 18
GROUP BY e.person_id, e.event_id
-- End Demographic Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

select 2 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_2
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  select PE.person_id, PE.event_id, PE.start_date, PE.end_date, PE.visit_occurrence_id, PE.sort_date FROM (
-- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* , row_number() over (PARTITION BY co.person_id ORDER BY co.condition_start_date, co.condition_occurrence_id) as ordinal
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 1)
) C

WHERE C.ordinal = 1
-- End Condition Occurrence Criteria

) PE
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* , row_number() over (PARTITION BY co.person_id ORDER BY co.condition_start_date, co.condition_occurrence_id) as ordinal
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 1)
) C

WHERE C.ordinal = 1
-- End Condition Occurrence Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* , row_number() over (PARTITION BY co.person_id ORDER BY co.condition_start_date, co.condition_occurrence_id) as ordinal
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 1)
) C

WHERE C.ordinal = 1
-- End Condition Occurrence Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) P
JOIN (
  -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 2)
) C


-- End Condition Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id and AC.event_id = pe.event_id

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,-183,P.START_DATE) AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

UNION ALL
-- Begin Correlated Criteria
select 1 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  select PE.person_id, PE.event_id, PE.start_date, PE.end_date, PE.visit_occurrence_id, PE.sort_date FROM (
-- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, DATEADD(d,1,C.measurement_date) as END_DATE,
       C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
  select m.* , row_number() over (PARTITION BY m.person_id ORDER BY m.measurement_date, m.measurement_id) as ordinal
  FROM @cdm_database_schema.MEASUREMENT m
JOIN #Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 7)
) C

WHERE C.value_as_concept_id in (45878386,45881618,45882500,45876322)
AND C.ordinal = 1
-- End Measurement Criteria

) PE
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, DATEADD(d,1,C.measurement_date) as END_DATE,
       C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
  select m.* , row_number() over (PARTITION BY m.person_id ORDER BY m.measurement_date, m.measurement_id) as ordinal
  FROM @cdm_database_schema.MEASUREMENT m
JOIN #Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 7)
) C

WHERE C.value_as_concept_id in (45878386,45881618,45882500,45876322)
AND C.ordinal = 1
-- End Measurement Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, DATEADD(d,1,C.measurement_date) as END_DATE,
       C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
  select m.* , row_number() over (PARTITION BY m.person_id ORDER BY m.measurement_date, m.measurement_id) as ordinal
  FROM @cdm_database_schema.MEASUREMENT m
JOIN #Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 7)
) C

WHERE C.value_as_concept_id in (45878386,45881618,45882500,45876322)
AND C.ordinal = 1
-- End Measurement Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) P
JOIN (
  -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 2)
) C


-- End Condition Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id and AC.event_id = pe.event_id

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,-183,P.START_DATE) AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

UNION ALL
-- Begin Correlated Criteria
select 2 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  select PE.person_id, PE.event_id, PE.start_date, PE.end_date, PE.visit_occurrence_id, PE.sort_date FROM (
-- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, DATEADD(d,1,C.measurement_date) as END_DATE,
       C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
  select m.* , row_number() over (PARTITION BY m.person_id ORDER BY m.measurement_date, m.measurement_id) as ordinal
  FROM @cdm_database_schema.MEASUREMENT m
JOIN #Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 6)
) C

WHERE C.ordinal = 1
-- End Measurement Criteria

) PE
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, DATEADD(d,1,C.measurement_date) as END_DATE,
       C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
  select m.* , row_number() over (PARTITION BY m.person_id ORDER BY m.measurement_date, m.measurement_id) as ordinal
  FROM @cdm_database_schema.MEASUREMENT m
JOIN #Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 6)
) C

WHERE C.ordinal = 1
-- End Measurement Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, DATEADD(d,1,C.measurement_date) as END_DATE,
       C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
  select m.* , row_number() over (PARTITION BY m.person_id ORDER BY m.measurement_date, m.measurement_id) as ordinal
  FROM @cdm_database_schema.MEASUREMENT m
JOIN #Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 6)
) C

WHERE C.ordinal = 1
-- End Measurement Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
  and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) P
JOIN (
  -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 2)
) C


-- End Condition Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id and AC.event_id = pe.event_id

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,-183,P.START_DATE) AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) > 0
) G
-- End Criteria Group

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

select 3 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_3
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, p.person_id, p.event_id
from #qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 10)
) C


-- End Condition Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria

UNION ALL
-- Begin Correlated Criteria
select 1 as index_id, p.person_id, p.event_id
from #qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Observation Criteria
select C.person_id, C.observation_id as event_id, C.observation_date as start_date, DATEADD(d,1,C.observation_date) as END_DATE,
       C.visit_occurrence_id, C.observation_date as sort_date
from 
(
  select o.* 
  FROM @cdm_database_schema.OBSERVATION o
JOIN #Codesets cs on (o.observation_concept_id = cs.concept_id and cs.codeset_id = 10)
) C


-- End Observation Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= DATEADD(day,30,P.START_DATE) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 2
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

select 4 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_4
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, p.person_id, p.event_id
from #qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 14)
) C


-- End Drug Exposure Criteria

) A on A.person_id = P.person_id  AND A.START_DATE <= DATEADD(day,-1,P.START_DATE) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria

UNION ALL
-- Begin Correlated Criteria
select 1 as index_id, p.person_id, p.event_id
from #qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 15)
) C


-- End Drug Exposure Criteria

) A on A.person_id = P.person_id  AND A.START_DATE <= DATEADD(day,-1,P.START_DATE) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria

UNION ALL
-- Begin Correlated Criteria
select 2 as index_id, p.person_id, p.event_id
from #qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 11)
) C


-- End Drug Exposure Criteria

) A on A.person_id = P.person_id  AND A.START_DATE <= DATEADD(day,-183,P.START_DATE) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria

UNION ALL
-- Begin Correlated Criteria
select 3 as index_id, p.person_id, p.event_id
from #qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Procedure Occurrence Criteria
select C.person_id, C.procedure_occurrence_id as event_id, C.procedure_date as start_date, DATEADD(d,1,C.procedure_date) as END_DATE,
       C.visit_occurrence_id, C.procedure_date as sort_date
from 
(
  select po.* 
  FROM @cdm_database_schema.PROCEDURE_OCCURRENCE po
JOIN #Codesets cs on (po.procedure_concept_id = cs.concept_id and cs.codeset_id = 13)
) C


-- End Procedure Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE <= DATEADD(day,-183,P.START_DATE) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 4
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

SELECT inclusion_rule_id, person_id, event_id
INTO #inclusion_events
FROM (select inclusion_rule_id, person_id, event_id from #Inclusion_0
UNION ALL
select inclusion_rule_id, person_id, event_id from #Inclusion_1
UNION ALL
select inclusion_rule_id, person_id, event_id from #Inclusion_2
UNION ALL
select inclusion_rule_id, person_id, event_id from #Inclusion_3
UNION ALL
select inclusion_rule_id, person_id, event_id from #Inclusion_4) I;
TRUNCATE TABLE #Inclusion_0;
DROP TABLE #Inclusion_0;

TRUNCATE TABLE #Inclusion_1;
DROP TABLE #Inclusion_1;

TRUNCATE TABLE #Inclusion_2;
DROP TABLE #Inclusion_2;

TRUNCATE TABLE #Inclusion_3;
DROP TABLE #Inclusion_3;

TRUNCATE TABLE #Inclusion_4;
DROP TABLE #Inclusion_4;


select event_id, person_id, start_date, end_date, op_start_date, op_end_date
into #included_events
FROM (
  SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, row_number() over (partition by person_id order by start_date ASC) as ordinal
  from
  (
    select Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date, SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) as inclusion_rule_mask
    from #qualified_events Q
    LEFT JOIN #inclusion_events I on I.person_id = Q.person_id and I.event_id = Q.event_id
    GROUP BY Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date
  ) MG -- matching groups

  -- the matching group with all bits set ( POWER(2,# of inclusion rules) - 1 = inclusion_rule_mask
  WHERE (MG.inclusion_rule_mask = POWER(cast(2 as bigint),5)-1)

) Results
WHERE Results.ordinal = 1
;



-- generate cohort periods into #final_cohort
select person_id, start_date, end_date
INTO #cohort_rows
from ( -- first_ends
	select F.person_id, F.start_date, F.end_date
	FROM (
	  select I.event_id, I.person_id, I.start_date, CE.end_date, row_number() over (partition by I.person_id, I.event_id order by CE.end_date) as ordinal
	  from #included_events I
	  join ( -- cohort_ends
-- cohort exit dates
-- By default, cohort exit at the event's op end date
select event_id, person_id, op_end_date as end_date from #included_events
UNION ALL
-- Censor Events
select i.event_id, i.person_id, MIN(c.start_date) as end_date
FROM #included_events i
JOIN
(
-- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 10)
) C


-- End Condition Occurrence Criteria

) C on C.person_id = I.person_id and C.start_date >= I.start_date and C.START_DATE <= I.op_end_date
GROUP BY i.event_id, i.person_id


    ) CE on I.event_id = CE.event_id and I.person_id = CE.person_id and CE.end_date >= I.start_date
	) F
	WHERE F.ordinal = 1
) FE;

select person_id, min(start_date) as start_date, end_date
into #final_cohort
from ( --cteEnds
	SELECT
		 c.person_id
		, c.start_date
		, MIN(ed.end_date) AS end_date
	FROM #cohort_rows c
	JOIN ( -- cteEndDates
    SELECT
      person_id
      , DATEADD(day,-1 * 0, event_date)  as end_date
    FROM
    (
      SELECT
        person_id
        , event_date
        , event_type
        , SUM(event_type) OVER (PARTITION BY person_id ORDER BY event_date, event_type ROWS UNBOUNDED PRECEDING) AS interval_status
      FROM
      (
        SELECT
          person_id
          , start_date AS event_date
          , -1 AS event_type
        FROM #cohort_rows

        UNION ALL


        SELECT
          person_id
          , DATEADD(day,0,end_date) as end_date
          , 1 AS event_type
        FROM #cohort_rows
      ) RAWDATA
    ) e
    WHERE interval_status = 0
  ) ed ON c.person_id = ed.person_id AND ed.end_date >= c.start_date
	GROUP BY c.person_id, c.start_date
) e
group by person_id, end_date
;

DELETE FROM @target_database_schema.@target_cohort_table where cohort_definition_id = @target_cohort_id;
INSERT INTO @target_database_schema.@target_cohort_table (cohort_definition_id, subject_id, cohort_start_date, cohort_end_date)
select @target_cohort_id as cohort_definition_id, person_id, start_date, end_date 
FROM #final_cohort CO
;






TRUNCATE TABLE #cohort_rows;
DROP TABLE #cohort_rows;

TRUNCATE TABLE #final_cohort;
DROP TABLE #final_cohort;

TRUNCATE TABLE #inclusion_events;
DROP TABLE #inclusion_events;

TRUNCATE TABLE #qualified_events;
DROP TABLE #qualified_events;

TRUNCATE TABLE #included_events;
DROP TABLE #included_events;

TRUNCATE TABLE #Codesets;
DROP TABLE #Codesets;
