DROP TABLE IF EXISTS @cohort_database_schema.drug_codesets;
CREATE TABLE @cohort_database_schema.drug_codesets
(
    codeset_tag VARCHAR NOT NULL,
    concept_id BIGINT NOT NULL
);


INSERT INTO @cohort_database_schema.drug_codesets (codeset_tag, concept_id)
SELECT codeset_tag, concept_id
FROM (
     --ADT
     SELECT 'ADT' AS codeset_tag, c.concept_id
     FROM (
          SELECT DISTINCT I.concept_id
          FROM (
               SELECT concept_id
               FROM @cdm_database_schema.CONCEPT
               WHERE concept_id IN (19058410, 739471, 35834903, 1343039, 19089810, 1366310, 1351541, 1344381, 19010792,
                                    1356461, 1500211, 1300978, 1315286, 35807385, 35807349)
               UNION
               SELECT C.concept_id
               FROM @cdm_database_schema.CONCEPT C
                   JOIN @cdm_database_schema.CONCEPT_ANCESTOR ca
               ON C.concept_id = ca.descendant_concept_id
                   AND ca.ancestor_concept_id IN (19058410, 739471, 35834903, 1343039, 19089810, 1366310, 1351541, 1344381,
                                                  19010792, 1356461, 1500211, 1300978, 1315286, 35807385, 35807349)
                   AND C.invalid_reason IS NULL
               ) I
          ) C

     UNION
     
     -- ARTA
     SELECT 'ARTA' AS codeset_tag, c.concept_id
     FROM (
          SELECT DISTINCT I.concept_id
          FROM (
               SELECT concept_id
               FROM @cdm_database_schema.CONCEPT
               WHERE concept_id IN (40239056, 963987, 42900250, 1361291)
               UNION
               SELECT C.concept_id
               FROM @cdm_database_schema.CONCEPT C
                   JOIN @cdm_database_schema.CONCEPT_ANCESTOR ca
               ON C.concept_id = ca.descendant_concept_id
                   AND ca.ancestor_concept_id IN (40239056, 963987, 42900250, 1361291)
                   AND C.invalid_reason IS NULL
               ) I
          ) C

     UNION
     
     --Chemo
     SELECT 'Chemo' AS codeset_tag, c.concept_id
     FROM (
          SELECT DISTINCT I.concept_id
          FROM (
               SELECT concept_id
               FROM @cdm_database_schema.CONCEPT
               WHERE concept_id IN (1315942, 40222431, 1378382)
               UNION
               SELECT C.concept_id
               FROM @cdm_database_schema.CONCEPT C
                   JOIN @cdm_database_schema.CONCEPT_ANCESTOR ca
               ON C.concept_id = ca.descendant_concept_id
                   AND ca.ancestor_concept_id IN (1315942, 40222431, 1378382)
                   AND C.invalid_reason IS NULL
               ) I
          ) C

     UNION
     
     --PARP
     SELECT 'PARP' AS codeset_tag, c.concept_id
     FROM (
          SELECT DISTINCT I.concept_id
          FROM (
               SELECT concept_id
               FROM @cdm_database_schema.CONCEPT
               WHERE concept_id IN (45892579, 1718850)
               UNION
               SELECT C.concept_id
               FROM @cdm_database_schema.CONCEPT C
                   JOIN @cdm_database_schema.CONCEPT_ANCESTOR ca
               ON C.concept_id = ca.descendant_concept_id
                   AND ca.ancestor_concept_id IN (45892579, 1718850)
                   AND C.invalid_reason IS NULL
               ) I
          ) C

     UNION
     
     --Immunotherapy
     SELECT 'Immuno' AS codeset_tag, c.concept_id
     FROM (
          SELECT DISTINCT I.concept_id
          FROM (
               SELECT concept_id
               FROM @cdm_database_schema.CONCEPT
               WHERE concept_id IN (45775965, 40224095)
               UNION
               SELECT C.concept_id
               FROM @cdm_database_schema.CONCEPT C
                   JOIN @cdm_database_schema.CONCEPT_ANCESTOR ca
               ON C.concept_id = ca.descendant_concept_id
                   AND ca.ancestor_concept_id IN (45775965, 40224095)
                   AND C.invalid_reason IS NULL
               ) I
          ) C

     UNION
     
     --lutetium
     SELECT 'lutetium' AS codeset_tag, c.concept_id
     FROM (
          SELECT DISTINCT I.concept_id
          FROM (
               SELECT concept_id
               FROM @cdm_database_schema.CONCEPT
               WHERE concept_id IN (44816340)
               UNION
               SELECT C.concept_id
               FROM @cdm_database_schema.CONCEPT C
                   JOIN @cdm_database_schema.CONCEPT_ANCESTOR ca
               ON C.concept_id = ca.descendant_concept_id
                   AND ca.ancestor_concept_id IN (44816340)
                   AND C.invalid_reason IS NULL
               ) I
          ) C

     UNION
     
     --radium223
     SELECT 'radium' AS codeset_tag, c.concept_id
     FROM (
          SELECT DISTINCT I.concept_id
          FROM (
               SELECT concept_id
               FROM @cdm_database_schema.CONCEPT
               WHERE concept_id IN (45775578, 902727, 43526934)
               UNION
               SELECT C.concept_id
               FROM @cdm_database_schema.CONCEPT C
                   JOIN @cdm_database_schema.CONCEPT_ANCESTOR ca
               ON C.concept_id = ca.descendant_concept_id
                   AND ca.ancestor_concept_id IN (45775578, 902727, 43526934)
                   AND C.invalid_reason IS NULL
               ) I
          LEFT JOIN
              (
              SELECT concept_id
              FROM @cdm_database_schema.CONCEPT
              WHERE concept_id IN (41267222)

              ) E
              ON I.concept_id = E.concept_id
          WHERE E.concept_id IS NULL
          ) C
     ) tab
;


-- assign drug tag to each drug_exposure instead of individual drug concept_ids 
DROP TABLE IF EXISTS @cohort_database_schema.treatment_tagged;

CREATE TABLE @cohort_database_schema.treatment_tagged(
  cohort_definition_id int, 
  person_id bigint,
  codeset_tag varchar,
  drug_exposure_start_date date,
  cohort_start_date date,
  cohort_end_date date
);

WITH tab AS(
  SELECT coh.cohort_definition_id, de.person_id,
         cs.codeset_tag, de.drug_exposure_start_date,
         coh.cohort_start_date,
         coh.cohort_end_date
  FROM @cdm_database_schema.drug_exposure de
  JOIN @cohort_database_schema.@cohort_table coh
      ON de.person_id = coh.subject_id
  JOIN @cohort_database_schema.drug_codesets cs
      ON cs.concept_id = de.drug_concept_id
      )
INSERT INTO @cohort_database_schema.treatment_tagged
SELECT DISTINCT * 
FROM tab 
WHERE cohort_definition_id IN (@treatment_cohort_ids)
  AND cohort_end_date >= drug_exposure_start_date
  AND cohort_start_date <= drug_exposure_start_date
ORDER BY cohort_definition_id, person_id, drug_exposure_start_date;


-- Add orchiectomy procedure info as a ADT treatment to treatment_tagged table
DROP TABLE IF EXISTS @cohort_database_schema.adt_proc;
CREATE TABLE @cohort_database_schema.adt_proc(
  cohort_definition_id int, 
  person_id bigint,
  codeset_tag varchar,
  drug_exposure_start_date date,
  cohort_start_date date,
  cohort_end_date date
);


WITH tab AS(
  SELECT coh.cohort_definition_id, pr.person_id,
         CAST('ADT' as text) AS codeset_tag, 
         pr.procedure_date AS drug_exposure_start_date,
         coh.cohort_start_date,
         coh.cohort_end_date
  FROM @cdm_database_schema.PROCEDURE_OCCURRENCE pr
  JOIN @cohort_database_schema.@cohort_table coh
      ON pr.person_id = coh.subject_id
  WHERE procedure_concept_id IN (4012324, 4304921, 4073141, 4071936, 4073142, 4073143, 2103796,
                                 2109975, 2109976, 44512827, 4314682, 4286887, 4341536, 4145907)
                                 )
INSERT INTO @cohort_database_schema.adt_proc
SELECT DISTINCT * 
FROM tab 
WHERE cohort_definition_id IN (@treatment_cohort_ids)
  AND cohort_end_date >= drug_exposure_start_date
  AND cohort_start_date <= drug_exposure_start_date;

INSERT INTO @cohort_database_schema.adt_proc 
SELECT cohort_definition_id, person_id, codeset_tag, 
       dateadd(day, 184, cohort_start_date) as drug_exposure_start_date, cohort_start_date, cohort_end_date
FROM  @cohort_database_schema.adt_proc
WHERE drug_exposure_start_date < dateadd(day, 184, cohort_start_date)
  AND datediff(day, cohort_start_date, cohort_end_date) >= 184 ;

INSERT INTO @cohort_database_schema.treatment_tagged
SELECT * 
FROM @cohort_database_schema.adt_proc a
WHERE NOT EXISTS (SELECT 1 
                  FROM @cohort_database_schema.treatment_tagged t
                  WHERE t.cohort_definition_id = a.cohort_definition_id
                    AND t.person_id = a.person_id
                    AND t.codeset_tag = a.codeset_tag
                    AND t.drug_exposure_start_date = a.drug_exposure_start_date);

DROP TABLE IF EXISTS @cohort_database_schema.adt_proc;


-- collect initial treatment patterns info
DROP TABLE IF EXISTS @cohort_database_schema.treatment_pat;
CREATE TABLE @cohort_database_schema.treatment_pat AS
SELECT DENSE_RANK() OVER(PARTITION BY cohort_definition_id ORDER BY person_id) AS id,
       cohort_definition_id, person_id, before_codeset_tag, first_exposure, 
       after_codeset_tag, after_first_exposure, cohort_start_date, cohort_end_date
FROM (
      SELECT COALESCE(before_cohort_id, after_cohort_id) AS cohort_definition_id, 
             COALESCE(before_person_id, after_person_id) AS person_id, before_codeset_tag, first_exposure,
             after_codeset_tag, COALESCE(after_first_exposure, first_exposure) AS after_first_exposure, 
             COALESCE(before.cohort_start_date, after.cohort_start_date) AS cohort_start_date,
             COALESCE(before.cohort_end_date, after.cohort_end_date) AS cohort_end_date
      FROM (
            -- first six months treatment
            SELECT cohort_definition_id AS before_cohort_id, person_id AS before_person_id, codeset_tag AS before_codeset_tag,
                   MIN(drug_exposure_start_date) AS first_exposure, cohort_start_date, cohort_end_date
            FROM @cohort_database_schema.treatment_tagged tp
            WHERE drug_exposure_start_date <= DATEADD(day, 183, cohort_start_date)
            GROUP BY cohort_definition_id, person_id, codeset_tag, cohort_start_date, cohort_end_date
            ) before
      FULL JOIN (
            -- post six months treatment
            SELECT cohort_definition_id AS after_cohort_id, person_id AS after_person_id, codeset_tag AS after_codeset_tag,
                   MIN(drug_exposure_start_date) AS after_first_exposure, cohort_start_date, cohort_end_date
            FROM @cohort_database_schema.treatment_tagged tp
            WHERE drug_exposure_start_date > DATEADD(day, 183, cohort_start_date)
            GROUP BY cohort_definition_id, person_id, codeset_tag, cohort_start_date, cohort_end_date
            UNION
            SELECT cohort_definition_id AS after_cohort_id, person_id AS after_person_id, 'censored' AS after_codeset_tag,
	                 MAX(drug_exposure_start_date) AS after_first_exposure, cohort_start_date, cohort_end_date
            FROM @cohort_database_schema.treatment_tagged tt
            WHERE DATEDIFF(day, cohort_start_date, cohort_end_date) <= 183
            GROUP BY cohort_definition_id, person_id, codeset_tag, cohort_start_date, cohort_end_date
            ) after
      ON before.before_person_id = after.after_person_id
        AND before.before_codeset_tag = after.after_codeset_tag
        AND before_cohort_id = after_cohort_id
      ORDER BY after.after_person_id, after_first_exposure
      ) tab
ORDER BY cohort_definition_id;
