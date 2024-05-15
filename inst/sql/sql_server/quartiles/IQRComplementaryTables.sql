-- Subject_age table
DROP TABLE IF EXISTS @cohort_database_schema.subject_age;
CREATE TABLE @cohort_database_schema.subject_age AS 
SELECT tab.cohort_definition_id,
       tab.person_id,
       tab.cohort_start_date,
       DATEDIFF(year, DATEFROMPARTS(tab.year_of_birth, tab.month_of_birth, tab.day_of_birth),
                tab.cohort_start_date) AS age
FROM (
     SELECT c.cohort_definition_id, p.person_id, c.cohort_start_date, p.year_of_birth,
               CASE WHEN ISNUMERIC(p.month_of_birth) = 1 THEN p.month_of_birth ELSE 1 END AS month_of_birth,
               CASE WHEN ISNUMERIC(p.day_of_birth) = 1 THEN p.day_of_birth ELSE 1 END AS day_of_birth
     FROM @cohort_database_schema.@cohort_table c
     JOIN @cdm_database_schema.person p
         ON p.person_id = c.subject_id
     WHERE c.cohort_definition_id IN (@target_ids)
     ) tab
;


-- Charlson analysis
DROP TABLE IF EXISTS @cohort_database_schema.charlson_concepts;
CREATE TABLE @cohort_database_schema.charlson_concepts
(
    diag_category_id INT,
    concept_id       INT
);

DROP TABLE IF EXISTS @cohort_database_schema.charlson_scoring;
CREATE TABLE @cohort_database_schema.charlson_scoring
(
    diag_category_id   INT,
    diag_category_name VARCHAR(255),
    weight             INT
);


DROP TABLE IF EXISTS @cohort_database_schema.charlson_incl;
CREATE TABLE @cohort_database_schema.charlson_incl
(
    diag_category_id   INT,
    diag_category_name VARCHAR(255),
    concept_id         INT
);


DROP TABLE IF EXISTS @cohort_database_schema.charlson_excl;
CREATE TABLE @cohort_database_schema.charlson_excl
(
    diag_category_id   INT,
    diag_category_name VARCHAR(255),
    concept_id         INT
);


INSERT INTO @cohort_database_schema.charlson_scoring (diag_category_id, diag_category_name, weight)
VALUES (1, 'Myocardial infarction', 1),
       (2, 'Congestive heart failure', 1),
       (3, 'Peripheral vascular disease', 1),
       (4, 'Cerebrovascular disease', 1),
       (5, 'Dementia', 1),
       (6, 'Chronic pulmonary disease', 1),
       (7, 'Rheumatologic disease', 1),
       (8, 'Peptic ulcer disease', 1),
       (9, 'Mild liver disease', 1),
       (10, 'Diabetes (mild to moderate)', 1),
       (11, 'Diabetes with chronic complications', 2),
       (12, 'Hemoplegia or paralegia', 2),
       (13, 'Renal disease', 2),
       (14, 'Any malignancy', 2),
       (15, 'Moderate to severe liver disease', 3),
       (16, 'Metastatic solid tumor', 6),
       (17, 'AIDS', 6);


INSERT INTO @cohort_database_schema.charlson_incl (diag_category_id, diag_category_name, concept_id)
VALUES (1, 'Myocardial infarction', 4329847),
       (2, 'Congestive heart failure', 316139),
       (3, 'Peripheral vascular disease', 4247790),
       (3, 'Peripheral vascular disease', 195834),
       (3, 'Peripheral vascular disease', 199064),
       (3, 'Peripheral vascular disease', 312934),
       (3, 'Peripheral vascular disease', 312939),
       (3, 'Peripheral vascular disease', 315558),
       (3, 'Peripheral vascular disease', 317305),
       (3, 'Peripheral vascular disease', 317585),
       (3, 'Peripheral vascular disease', 320739),
       (3, 'Peripheral vascular disease', 321052),
       (3, 'Peripheral vascular disease', 321882),
       (3, 'Peripheral vascular disease', 4045408),
       (3, 'Peripheral vascular disease', 4099184),
       (3, 'Peripheral vascular disease', 4134603),
       (3, 'Peripheral vascular disease', 4188336),
       (4, 'Cerebrovascular disease', 381591),
       (4, 'Cerebrovascular disease', 434056),
       (4, 'Cerebrovascular disease', 4112026),
       (4, 'Cerebrovascular disease', 43530727),
       (4, 'Cerebrovascular disease', 4148906),
       (5, 'Dementia', 4182210),
       (5, 'Dementia', 373179),
       (6, 'Chronic pulmonary disease', 312940),
       (6, 'Chronic pulmonary disease', 256450),
       (6, 'Chronic pulmonary disease', 317009),
       (6, 'Chronic pulmonary disease', 256449),
       (6, 'Chronic pulmonary disease', 4063381),
       (6, 'Chronic pulmonary disease', 4112814),
       (6, 'Chronic pulmonary disease', 4279553),
       (6, 'Chronic pulmonary disease', 444084),
       (6, 'Chronic pulmonary disease', 259044),
       (7, 'Rheumatologic disease', 80182),
       (7, 'Rheumatologic disease', 4079978),
       (7, 'Rheumatologic disease', 255348),
       (7, 'Rheumatologic disease', 80800),
       (7, 'Rheumatologic disease', 80809),
       (7, 'Rheumatologic disease', 256197),
       (7, 'Rheumatologic disease', 438688),
       (7, 'Rheumatologic disease', 254443),
       (7, 'Rheumatologic disease', 257628),
       (7, 'Rheumatologic disease', 134442),
       (8, 'Peptic ulcer disease', 4027663),
       (9, 'Mild liver disease', 201612),
       (9, 'Mild liver disease', 4212540),
       (9, 'Mild liver disease', 4064161),
       (9, 'Mild liver disease', 4267417),
       (9, 'Mild liver disease', 194417),
       (9, 'Mild liver disease', 4159144),
       (9, 'Mild liver disease', 4240725),
       (9, 'Mild liver disease', 4059290),
       (9, 'Mild liver disease', 4055224),
       (10, 'Diabetes (mild to moderate)', 46270484),
       (10, 'Diabetes (mild to moderate)', 36684827),
       (10, 'Diabetes (mild to moderate)', 4008576),
       (10, 'Diabetes (mild to moderate)', 4159742),
       (10, 'Diabetes (mild to moderate)', 443727),
       (10, 'Diabetes (mild to moderate)', 37311673),
       (10, 'Diabetes (mild to moderate)', 4226238),
       (10, 'Diabetes (mild to moderate)', 4029423),
       (10, 'Diabetes (mild to moderate)', 37110593),
       (10, 'Diabetes (mild to moderate)', 45770902),
       (10, 'Diabetes (mild to moderate)', 45757277),
       (11, 'Diabetes with chronic complications', 442793),
       (12, 'Hemoplegia or paralegia', 4102342),
       (12, 'Hemoplegia or paralegia', 132617),
       (12, 'Hemoplegia or paralegia', 374022),
       (12, 'Hemoplegia or paralegia', 381548),
       (12, 'Hemoplegia or paralegia', 192606),
       (12, 'Hemoplegia or paralegia', 44806793),
       (12, 'Hemoplegia or paralegia', 374914),
       (13, 'Renal disease', 312358),
       (13, 'Renal disease', 44782429),
       (13, 'Renal disease', 439695),
       (13, 'Renal disease', 443919),
       (13, 'Renal disease', 4298809),
       (13, 'Renal disease', 4030518),
       (13, 'Renal disease', 197921),
       (13, 'Renal disease', 42539502),
       (13, 'Renal disease', 4147716),
       (13, 'Renal disease', 4019967),
       (13, 'Renal disease', 2617400),
       (13, 'Renal disease', 2617401),
       (13, 'Renal disease', 2617545),
       (13, 'Renal disease', 2213597),
       (13, 'Renal disease', 2213592),
       (13, 'Renal disease', 2213591),
       (13, 'Renal disease', 2213593),
       (13, 'Renal disease', 2213590),
       (13, 'Renal disease', 2101833),
       (13, 'Renal disease', 40664693),
       (13, 'Renal disease', 40664745),
       (13, 'Renal disease', 2108567),
       (13, 'Renal disease', 2108564),
       (13, 'Renal disease', 2108566),
       (13, 'Renal disease', 4286500),
       (13, 'Renal disease', 313232),
       (13, 'Renal disease', 2514586),
       (13, 'Renal disease', 46270032),
       (13, 'Renal disease', 2101834),
       (13, 'Renal disease', 4300839),
       (13, 'Renal disease', 4146536),
       (13, 'Renal disease', 4021107),
       (13, 'Renal disease', 4197300),
       (13, 'Renal disease', 2833286),
       (13, 'Renal disease', 2877118),
       (13, 'Renal disease', 45888790),
       (13, 'Renal disease', 4322471),
       (14, 'Any malignancy', 438701),
       (14, 'Any malignancy', 443392),
       (15, 'Moderate to severe liver disease', 4340386),
       (15, 'Moderate to severe liver disease', 24966),
       (15, 'Moderate to severe liver disease', 4237824),
       (15, 'Moderate to severe liver disease', 4029488),
       (15, 'Moderate to severe liver disease', 4245975),
       (15, 'Moderate to severe liver disease', 192680),
       (15, 'Moderate to severe liver disease', 4026136),
       (15, 'Moderate to severe liver disease', 4277276),
       (16, 'Metastatic solid tumor', 432851),
       (16, 'Metastatic solid tumor', 4201930),
       (16, 'Metastatic solid tumor', 4205430),
       (16, 'Metastatic solid tumor', 4264861),
       (16, 'Metastatic solid tumor', 4264288),
       (16, 'Metastatic solid tumor', 4246703),
       (16, 'Metastatic solid tumor', 763131),
       (17, 'AIDS', 4013106),
       (17, 'AIDS', 439727)
;

INSERT INTO @cohort_database_schema.charlson_excl (diag_category_id, diag_category_name, concept_id)
VALUES (3, 'Peripheral vascular disease', 4243371),
       (3, 'Peripheral vascular disease', 3184873),
       (3, 'Peripheral vascular disease', 42599607),
       (3, 'Peripheral vascular disease', 42572961),
       (3, 'Peripheral vascular disease', 4289307),
       (3, 'Peripheral vascular disease', 321822),
       (3, 'Peripheral vascular disease', 42597028),
       (3, 'Peripheral vascular disease', 4202511),
       (3, 'Peripheral vascular disease', 4263089),
       (3, 'Peripheral vascular disease', 42597030),
       (4, 'Cerebrovascular disease', 4121629),
       (4, 'Cerebrovascular disease', 4119617),
       (4, 'Cerebrovascular disease', 37204809),
       (4, 'Cerebrovascular disease', 4062269),
       (4, 'Cerebrovascular disease', 435875),
       (4, 'Cerebrovascular disease', 372721),
       (4, 'Cerebrovascular disease', 4267553),
       (4, 'Cerebrovascular disease', 441406),
       (4, 'Cerebrovascular disease', 762585),
       (4, 'Cerebrovascular disease', 765899),
       (4, 'Cerebrovascular disease', 762583),
       (4, 'Cerebrovascular disease', 762584),
       (4, 'Cerebrovascular disease', 37108913),
       (4, 'Cerebrovascular disease', 37117075),
       (4, 'Cerebrovascular disease', 432346),
       (4, 'Cerebrovascular disease', 192763),
       (4, 'Cerebrovascular disease', 43021816),
       (4, 'Cerebrovascular disease', 379778),
       (4, 'Cerebrovascular disease', 37017075),
       (4, 'Cerebrovascular disease', 4061473),
       (4, 'Cerebrovascular disease', 4088927),
       (4, 'Cerebrovascular disease', 4173794),
       (4, 'Cerebrovascular disease', 380943),
       (4, 'Cerebrovascular disease', 762351),
       (4, 'Cerebrovascular disease', 4079430),
       (4, 'Cerebrovascular disease', 4079433),
       (4, 'Cerebrovascular disease', 4082161),
       (4, 'Cerebrovascular disease', 764707),
       (4, 'Cerebrovascular disease', 42536193),
       (4, 'Cerebrovascular disease', 4079431),
       (4, 'Cerebrovascular disease', 4079432),
       (4, 'Cerebrovascular disease', 4079434),
       (4, 'Cerebrovascular disease', 4082162),
       (4, 'Cerebrovascular disease', 42536192),
       (4, 'Cerebrovascular disease', 45766085),
       (4, 'Cerebrovascular disease', 4111707),
       (4, 'Cerebrovascular disease', 4120104),
       (4, 'Cerebrovascular disease', 4079120),
       (4, 'Cerebrovascular disease', 4079021),
       (4, 'Cerebrovascular disease', 4082163),
       (4, 'Cerebrovascular disease', 42535879),
       (4, 'Cerebrovascular disease', 42535880),
       (4, 'Cerebrovascular disease', 4046364),
       (4, 'Cerebrovascular disease', 4234089),
       (4, 'Cerebrovascular disease', 313543),
       (4, 'Cerebrovascular disease', 4180026),
       (4, 'Cerebrovascular disease', 4121637),
       (5, 'Dementia', 378726),
       (5, 'Dementia', 37311999),
       (5, 'Dementia', 376095),
       (5, 'Dementia', 377788),
       (5, 'Dementia', 4139421),
       (5, 'Dementia', 372610),
       (5, 'Dementia', 4009647),
       (5, 'Dementia', 375504),
       (5, 'Dementia', 4108943),
       (5, 'Dementia', 4047745),
       (6, 'Chronic pulmonary disease', 257583),
       (6, 'Chronic pulmonary disease', 4250128),
       (6, 'Chronic pulmonary disease', 42535716),
       (6, 'Chronic pulmonary disease', 432347),
       (6, 'Chronic pulmonary disease', 37396824),
       (6, 'Chronic pulmonary disease', 4073287),
       (6, 'Chronic pulmonary disease', 24970),
       (6, 'Chronic pulmonary disease', 441321),
       (6, 'Chronic pulmonary disease', 26711),
       (6, 'Chronic pulmonary disease', 4080753),
       (6, 'Chronic pulmonary disease', 259848),
       (6, 'Chronic pulmonary disease', 257012),
       (6, 'Chronic pulmonary disease', 255362),
       (6, 'Chronic pulmonary disease', 4166508),
       (6, 'Chronic pulmonary disease', 4244339),
       (6, 'Chronic pulmonary disease', 4049965),
       (6, 'Chronic pulmonary disease', 4334649),
       (6, 'Chronic pulmonary disease', 4110492),
       (6, 'Chronic pulmonary disease', 4256228),
       (6, 'Chronic pulmonary disease', 4280726),
       (8, 'Peptic ulcer disease', 42575826),
       (8, 'Peptic ulcer disease', 42598770),
       (8, 'Peptic ulcer disease', 42572784),
       (8, 'Peptic ulcer disease', 42598976),
       (8, 'Peptic ulcer disease', 42598722),
       (8, 'Peptic ulcer disease', 4340230),
       (8, 'Peptic ulcer disease', 42572805),
       (8, 'Peptic ulcer disease', 4341234),
       (8, 'Peptic ulcer disease', 201340),
       (8, 'Peptic ulcer disease', 37203820),
       (8, 'Peptic ulcer disease', 4206524),
       (9, 'Mild liver disease', 4048083),
       (9, 'Mild liver disease', 4340386),
       (9, 'Mild liver disease', 197654),
       (9, 'Mild liver disease', 4194229),
       (9, 'Mild liver disease', 37396401),
       (9, 'Mild liver disease', 42599120),
       (9, 'Mild liver disease', 36716035),
       (9, 'Mild liver disease', 42599522),
       (9, 'Mild liver disease', 4342775),
       (9, 'Mild liver disease', 4026136),
       (10, 'Diabetes (mild to moderate)', 37016355),
       (10, 'Diabetes (mild to moderate)', 44809809),
       (10, 'Diabetes (mild to moderate)', 44789319),
       (10, 'Diabetes (mild to moderate)', 44789318),
       (10, 'Diabetes (mild to moderate)', 4096041),
       (10, 'Diabetes (mild to moderate)', 3180411),
       (10, 'Diabetes (mild to moderate)', 195771),
       (11, 'Diabetes with chronic complications', 46270484),
       (11, 'Diabetes with chronic complications', 761051),
       (11, 'Diabetes with chronic complications', 4159742),
       (11, 'Diabetes with chronic complications', 443727),
       (11, 'Diabetes with chronic complications', 4317258),
       (11, 'Diabetes with chronic complications', 761048),
       (11, 'Diabetes with chronic complications', 37311673),
       (11, 'Diabetes with chronic complications', 4226238),
       (11, 'Diabetes with chronic complications', 37109305),
       (11, 'Diabetes with chronic complications', 4029423),
       (11, 'Diabetes with chronic complications', 37110593),
       (11, 'Diabetes with chronic complications', 37016356),
       (11, 'Diabetes with chronic complications', 37016358),
       (11, 'Diabetes with chronic complications', 37016357),
       (11, 'Diabetes with chronic complications', 134398),
       (11, 'Diabetes with chronic complications', 195771),
       (11, 'Diabetes with chronic complications', 197304),
       (12, 'Hemoplegia or paralegia', 4044233),
       (12, 'Hemoplegia or paralegia', 4219507),
       (12, 'Hemoplegia or paralegia', 42537693),
       (12, 'Hemoplegia or paralegia', 81425),
       (12, 'Hemoplegia or paralegia', 4008510),
       (12, 'Hemoplegia or paralegia', 4136090),
       (12, 'Hemoplegia or paralegia', 37396338),
       (12, 'Hemoplegia or paralegia', 36684263),
       (12, 'Hemoplegia or paralegia', 374336),
       (12, 'Hemoplegia or paralegia', 35622325),
       (12, 'Hemoplegia or paralegia', 4222487),
       (12, 'Hemoplegia or paralegia', 434056),
       (12, 'Hemoplegia or paralegia', 36716141),
       (12, 'Hemoplegia or paralegia', 4077819),
       (12, 'Hemoplegia or paralegia', 43530607),
       (12, 'Hemoplegia or paralegia', 4013309),
       (12, 'Hemoplegia or paralegia', 372654),
       (12, 'Hemoplegia or paralegia', 37116389),
       (12, 'Hemoplegia or paralegia', 37312156),
       (12, 'Hemoplegia or paralegia', 37111591),
       (12, 'Hemoplegia or paralegia', 37116294),
       (12, 'Hemoplegia or paralegia', 35622086),
       (12, 'Hemoplegia or paralegia', 37116656),
       (12, 'Hemoplegia or paralegia', 36716260),
       (12, 'Hemoplegia or paralegia', 37117747),
       (12, 'Hemoplegia or paralegia', 35622085),
       (12, 'Hemoplegia or paralegia', 37110771),
       (12, 'Hemoplegia or paralegia', 37109775),
       (12, 'Hemoplegia or paralegia', 4318559),
       (12, 'Hemoplegia or paralegia', 40483180),
       (13, 'Renal disease', 37016359),
       (13, 'Renal disease', 4054915),
       (13, 'Renal disease', 4189531),
       (13, 'Renal disease', 4126305),
       (13, 'Renal disease', 442793),
       (13, 'Renal disease', 4149398),
       (13, 'Renal disease', 192279),
       (13, 'Renal disease', 2313999),
       (13, 'Renal disease', 4059475),
       (13, 'Renal disease', 46270934),
       (13, 'Renal disease', 46270933),
       (13, 'Renal disease', 37396069),
       (13, 'Renal disease', 3171077),
       (13, 'Renal disease', 4139443),
       (13, 'Renal disease', 2213596),
       (13, 'Renal disease', 2213595),
       (13, 'Renal disease', 2213597),
       (13, 'Renal disease', 2213594),
       (13, 'Renal disease', 2213592),
       (13, 'Renal disease', 2213591),
       (13, 'Renal disease', 2213593),
       (13, 'Renal disease', 2213590),
       (13, 'Renal disease', 2213586),
       (13, 'Renal disease', 2213585),
       (13, 'Renal disease', 2213584),
       (13, 'Renal disease', 2213583),
       (13, 'Renal disease', 2213582),
       (13, 'Renal disease', 2213581),
       (13, 'Renal disease', 2213589),
       (13, 'Renal disease', 2213588),
       (13, 'Renal disease', 2213587),
       (13, 'Renal disease', 2213580),
       (13, 'Renal disease', 2213579),
       (13, 'Renal disease', 2213578),
       (13, 'Renal disease', 2101833),
       (13, 'Renal disease', 40664693),
       (13, 'Renal disease', 40664745),
       (13, 'Renal disease', 2108567),
       (13, 'Renal disease', 2108564),
       (13, 'Renal disease', 2108566),
       (13, 'Renal disease', 4286500),
       (13, 'Renal disease', 2514586),
       (13, 'Renal disease', 2108568),
       (13, 'Renal disease', 2101834),
       (13, 'Renal disease', 4022474),
       (13, 'Renal disease', 45887599),
       (13, 'Renal disease', 2109583),
       (13, 'Renal disease', 2109584),
       (13, 'Renal disease', 2109582),
       (13, 'Renal disease', 2109580),
       (13, 'Renal disease', 2109581),
       (14, 'Any malignancy', 36403050),
       (14, 'Any malignancy', 36403028),
       (14, 'Any malignancy', 36403071),
       (14, 'Any malignancy', 36402997),
       (14, 'Any malignancy', 36403059),
       (14, 'Any malignancy', 36403077),
       (14, 'Any malignancy', 36403012),
       (14, 'Any malignancy', 36402991),
       (14, 'Any malignancy', 36403070),
       (14, 'Any malignancy', 36403044),
       (14, 'Any malignancy', 36403007),
       (14, 'Any malignancy', 36403014),
       (14, 'Any malignancy', 36403066),
       (14, 'Any malignancy', 36403006),
       (14, 'Any malignancy', 36403031),
       (14, 'Any malignancy', 36403020),
       (14, 'Any malignancy', 36403061),
       (14, 'Any malignancy', 36403004),
       (14, 'Any malignancy', 36403009),
       (14, 'Any malignancy', 36403056),
       (14, 'Any malignancy', 36403010),
       (14, 'Any malignancy', 36403042),
       (14, 'Any malignancy', 36403046),
       (14, 'Any malignancy', 36403036),
       (14, 'Any malignancy', 36403143),
       (14, 'Any malignancy', 36403115),
       (14, 'Any malignancy', 36403083),
       (14, 'Any malignancy', 36403138),
       (14, 'Any malignancy', 36403141),
       (14, 'Any malignancy', 36403128),
       (14, 'Any malignancy', 36403152),
       (14, 'Any malignancy', 36403107),
       (14, 'Any malignancy', 36403090),
       (14, 'Any malignancy', 36403132),
       (14, 'Any malignancy', 36403091),
       (14, 'Any malignancy', 36403142),
       (14, 'Any malignancy', 36403134),
       (14, 'Any malignancy', 36403148),
       (14, 'Any malignancy', 36403120),
       (14, 'Any malignancy', 36403095),
       (14, 'Any malignancy', 36403112),
       (14, 'Any malignancy', 36403093),
       (14, 'Any malignancy', 36403139),
       (14, 'Any malignancy', 36403145),
       (14, 'Any malignancy', 36403109),
       (14, 'Any malignancy', 42512800),
       (14, 'Any malignancy', 42511869),
       (14, 'Any malignancy', 42512038),
       (14, 'Any malignancy', 42511724),
       (14, 'Any malignancy', 42511824),
       (14, 'Any malignancy', 42511643),
       (14, 'Any malignancy', 36403149),
       (14, 'Any malignancy', 42512747),
       (14, 'Any malignancy', 42512286),
       (14, 'Any malignancy', 42512532),
       (14, 'Any malignancy', 42512028),
       (14, 'Any malignancy', 36403081),
       (14, 'Any malignancy', 36403026),
       (14, 'Any malignancy', 36403058),
       (14, 'Any malignancy', 36403034),
       (14, 'Any malignancy', 36402992),
       (14, 'Any malignancy', 36403054),
       (14, 'Any malignancy', 36403041),
       (14, 'Any malignancy', 36403043),
       (14, 'Any malignancy', 36403073),
       (14, 'Any malignancy', 435506),
       (14, 'Any malignancy', 36403030),
       (14, 'Any malignancy', 36403024),
       (14, 'Any malignancy', 36403117),
       (14, 'Any malignancy', 36403102),
       (14, 'Any malignancy', 433435),
       (14, 'Any malignancy', 36402628),
       (14, 'Any malignancy', 36403078),
       (14, 'Any malignancy', 36402440),
       (14, 'Any malignancy', 36403047),
       (14, 'Any malignancy', 36403129),
       (14, 'Any malignancy', 36403013),
       (14, 'Any malignancy', 36403049),
       (14, 'Any malignancy', 36402466),
       (14, 'Any malignancy', 42514272),
       (14, 'Any malignancy', 42514300),
       (14, 'Any malignancy', 42514069),
       (14, 'Any malignancy', 42514087),
       (14, 'Any malignancy', 42513173),
       (14, 'Any malignancy', 42513168),
       (14, 'Any malignancy', 42514355),
       (14, 'Any malignancy', 42514250),
       (14, 'Any malignancy', 42514287),
       (14, 'Any malignancy', 42514264),
       (14, 'Any malignancy', 42514252),
       (14, 'Any malignancy', 42514189),
       (14, 'Any malignancy', 42514379),
       (14, 'Any malignancy', 42514157),
       (14, 'Any malignancy', 42514198),
       (14, 'Any malignancy', 42514109),
       (14, 'Any malignancy', 42514206),
       (14, 'Any malignancy', 42514341),
       (14, 'Any malignancy', 42514251),
       (14, 'Any malignancy', 42514168),
       (14, 'Any malignancy', 42514350),
       (14, 'Any malignancy', 42514129),
       (14, 'Any malignancy', 42514102),
       (14, 'Any malignancy', 42514156),
       (14, 'Any malignancy', 42514291),
       (14, 'Any malignancy', 42514378),
       (14, 'Any malignancy', 42514367),
       (14, 'Any malignancy', 42514217),
       (14, 'Any malignancy', 42514165),
       (14, 'Any malignancy', 42514372),
       (14, 'Any malignancy', 42514202),
       (14, 'Any malignancy', 42514326),
       (14, 'Any malignancy', 42514143),
       (14, 'Any malignancy', 42514304),
       (14, 'Any malignancy', 42514180),
       (14, 'Any malignancy', 42514373),
       (14, 'Any malignancy', 42514103),
       (14, 'Any malignancy', 42514334),
       (14, 'Any malignancy', 42514182),
       (14, 'Any malignancy', 42513234),
       (14, 'Any malignancy', 42514239),
       (14, 'Any malignancy', 42514278),
       (14, 'Any malignancy', 42514169),
       (14, 'Any malignancy', 42514212),
       (14, 'Any malignancy', 42514362),
       (14, 'Any malignancy', 42514093),
       (14, 'Any malignancy', 42514097),
       (14, 'Any malignancy', 42514376),
       (14, 'Any malignancy', 42514163),
       (14, 'Any malignancy', 42514297),
       (14, 'Any malignancy', 42514369),
       (14, 'Any malignancy', 42514363),
       (14, 'Any malignancy', 42514178),
       (14, 'Any malignancy', 42514307),
       (14, 'Any malignancy', 42514214),
       (14, 'Any malignancy', 42514288),
       (14, 'Any malignancy', 42514208),
       (14, 'Any malignancy', 42514263),
       (14, 'Any malignancy', 42514201),
       (14, 'Any malignancy', 42514175),
       (14, 'Any malignancy', 42514303),
       (14, 'Any malignancy', 42514290),
       (14, 'Any malignancy', 42514100),
       (14, 'Any malignancy', 42514327),
       (14, 'Any malignancy', 42514271),
       (14, 'Any malignancy', 42514329),
       (14, 'Any malignancy', 42514240),
       (14, 'Any malignancy', 42514144),
       (14, 'Any malignancy', 42514254),
       (14, 'Any malignancy', 42514294),
       (14, 'Any malignancy', 42514170),
       (14, 'Any malignancy', 42514147),
       (14, 'Any malignancy', 42514215),
       (14, 'Any malignancy', 42514104),
       (14, 'Any malignancy', 42514374),
       (14, 'Any malignancy', 42514126),
       (14, 'Any malignancy', 42514199),
       (14, 'Any malignancy', 42514338),
       (14, 'Any malignancy', 42514173),
       (14, 'Any malignancy', 42514315),
       (14, 'Any malignancy', 42514225),
       (14, 'Any malignancy', 42514107),
       (14, 'Any malignancy', 42514131),
       (14, 'Any malignancy', 42514277),
       (14, 'Any malignancy', 42514231),
       (14, 'Any malignancy', 42514108),
       (14, 'Any malignancy', 42514141),
       (14, 'Any malignancy', 42514091),
       (14, 'Any malignancy', 42514232),
       (14, 'Any malignancy', 42514260),
       (14, 'Any malignancy', 42514302),
       (14, 'Any malignancy', 42514191),
       (14, 'Any malignancy', 42514365),
       (14, 'Any malignancy', 42514136),
       (14, 'Any malignancy', 42514237),
       (14, 'Any malignancy', 42514325),
       (14, 'Any malignancy', 42514337),
       (14, 'Any malignancy', 42514359),
       (14, 'Any malignancy', 42514110),
       (14, 'Any malignancy', 42514324),
       (14, 'Any malignancy', 42514228),
       (14, 'Any malignancy', 42514098),
       (14, 'Any malignancy', 42514048),
       (14, 'Any malignancy', 42514137),
       (14, 'Any malignancy', 42514218),
       (14, 'Any malignancy', 42514125),
       (14, 'Any malignancy', 42514080),
       (14, 'Any malignancy', 42514209),
       (14, 'Any malignancy', 42514357),
       (14, 'Any malignancy', 42514348),
       (14, 'Any malignancy', 42514335),
       (14, 'Any malignancy', 42514305),
       (14, 'Any malignancy', 432582),
       (14, 'Any malignancy', 36402451),
       (14, 'Any malignancy', 36402490),
       (14, 'Any malignancy', 42512086),
       (14, 'Any malignancy', 36402509),
       (14, 'Any malignancy', 36402513),
       (14, 'Any malignancy', 36402587),
       (14, 'Any malignancy', 42512566),
       (14, 'Any malignancy', 4283739),
       (14, 'Any malignancy', 432851),
       (14, 'Any malignancy', 36402471),
       (14, 'Any malignancy', 42512846),
       (14, 'Any malignancy', 36403151),
       (14, 'Any malignancy', 36403082),
       (14, 'Any malignancy', 36403123),
       (14, 'Any malignancy', 36403080),
       (14, 'Any malignancy', 36402645),
       (14, 'Any malignancy', 36403076),
       (14, 'Any malignancy', 36403068),
       (14, 'Any malignancy', 36403039),
       (14, 'Any malignancy', 36403033),
       (14, 'Any malignancy', 36403057),
       (14, 'Any malignancy', 36403001),
       (14, 'Any malignancy', 36403069),
       (14, 'Any malignancy', 36403072),
       (14, 'Any malignancy', 36403003),
       (14, 'Any malignancy', 36403048),
       (14, 'Any malignancy', 36403086),
       (14, 'Any malignancy', 36403154),
       (14, 'Any malignancy', 36402417),
       (14, 'Any malignancy', 36402373),
       (14, 'Any malignancy', 42512691),
       (14, 'Any malignancy', 36402391),
       (14, 'Any malignancy', 36402644),
       (15, 'Moderate to severe liver disease', 36716708),
       (15, 'Moderate to severe liver disease', 763021),
       (15, 'Moderate to severe liver disease', 4163687),
       (15, 'Moderate to severe liver disease', 4314443),
       (15, 'Moderate to severe liver disease', 439675),
       (15, 'Moderate to severe liver disease', 46270037),
       (15, 'Moderate to severe liver disease', 4308946),
       (15, 'Moderate to severe liver disease', 46270152),
       (15, 'Moderate to severe liver disease', 46270142),
       (15, 'Moderate to severe liver disease', 196029),
       (15, 'Moderate to severe liver disease', 194856),
       (15, 'Moderate to severe liver disease', 200031),
       (15, 'Moderate to severe liver disease', 439672),
       (15, 'Moderate to severe liver disease', 4331292),
       (15, 'Moderate to severe liver disease', 3183806),
       (15, 'Moderate to severe liver disease', 4291005)
;


INSERT INTO @cohort_database_schema.charlson_concepts
SELECT DISTINCT I.diag_category_id, I.descendant_concept_id
FROM (
     SELECT incl.diag_category_id, ca.ancestor_concept_id, ca.descendant_concept_id
     FROM @cdm_database_schema.concept_ancestor ca
     JOIN @cohort_database_schema.charlson_incl incl
         ON ca.ancestor_concept_id = incl.concept_id
     ) I
LEFT JOIN
    (
    SELECT excl.diag_category_id, ca.ancestor_concept_id, ca.descendant_concept_id
    FROM @cdm_database_schema.concept_ancestor ca
    JOIN @cohort_database_schema.charlson_excl excl
        ON ca.ancestor_concept_id = excl.concept_id
    ) E
    ON I.diag_category_id = E.diag_category_id
        AND I.descendant_concept_id = E.descendant_concept_id;


DROP TABLE IF EXISTS @cohort_database_schema.charlson_map;
CREATE TABLE @cohort_database_schema.charlson_map AS
SELECT DISTINCT * 
FROM (
  SELECT COALESCE(diag_category_id, 0) as diag_category_id,
         COALESCE (weight, 0) as weight,
         c.cohort_definition_id,
         c.subject_id,
         c.cohort_start_date
  FROM (SELECT concepts.diag_category_id, score.weight, cohort.subject_id, cohort.cohort_definition_id
  	FROM 
  	@cohort_database_schema.@cohort_table cohort
  	INNER JOIN @cdm_database_schema.condition_era condition_era
  		ON cohort.subject_id = condition_era.person_id
  	INNER JOIN @cohort_database_schema.charlson_concepts concepts
  		ON condition_era.condition_concept_id = concepts.concept_id
  	INNER JOIN @cohort_database_schema.charlson_scoring score
  		ON concepts.diag_category_id = score.diag_category_id
  	WHERE condition_era_start_date <= cohort.cohort_start_date	
  	) temp
  	RIGHT JOIN @cohort_database_schema.@cohort_table c
  		ON c.subject_id = temp.subject_id and c.cohort_definition_id=temp.cohort_definition_id
  	
  	UNION ALL
  	
  	-- cancer modifiers
  	SELECT 
          16 AS diag_category_id,
          6 AS weight, 
          cohort.cohort_definition_id,
          cohort.subject_id, 
          cohort_start_date
  	FROM @cohort_database_schema.@cohort_table cohort
  	INNER JOIN @cdm_database_schema.measurement meas
  		ON cohort.subject_id = meas.person_id
  	WHERE meas.measurement_date <= cohort.cohort_start_date
      AND measurement_concept_id IN (
          SELECT ca.descendant_concept_id
          FROM @cdm_database_schema.concept_ancestor ca
            WHERE ca.ancestor_concept_id IN (36769180, 1635142)
            )
            
    UNION ALL
  
  	-- metastasis measurement
  	SELECT 
          16 AS diag_category_id,
          6 AS weight, 
          cohort.cohort_definition_id,
          cohort.subject_id, 
          cohort_start_date
  	FROM @cohort_database_schema.@cohort_table cohort
  	INNER JOIN @cdm_database_schema.measurement meas
  		ON cohort.subject_id = meas.person_id
  	WHERE meas.measurement_date <= cohort.cohort_start_date
      AND measurement_concept_id IN (
          SELECT ca.descendant_concept_id
          FROM @cdm_database_schema.concept_ancestor ca
            WHERE ca.ancestor_concept_id IN (3006575)
            )
      AND value_as_concept_id in (45878386, 45881618, 45882500, 45876322)
	)
	DISTKEY(diag_category_id);
		
		
-- Update weights to avoid double counts of mild/severe course of the disease
-- Diabetes
UPDATE @cohort_database_schema.charlson_map
SET weight = 0
FROM (
  SELECT
    t1.subject_id AS sub_id
  , t1.cohort_definition_id AS coh_id
  , t1.diag_category_id AS d1
  , t2.diag_category_id AS d2
  FROM @cohort_database_schema.charlson_map t1
  INNER JOIN @cohort_database_schema.charlson_map t2 ON
    t1.subject_id = t2.subject_id
    AND t1.cohort_definition_id = t2.cohort_definition_id
) x
WHERE
  subject_id = x.sub_id
  AND cohort_definition_id = x.coh_id
  AND diag_category_id = 10
  AND x.d1 = 10
  AND x.d2 = 11;

-- Liver disease
UPDATE @cohort_database_schema.charlson_map
SET weight = 0
FROM (
  SELECT
    t1.subject_id AS sub_id
  , t1.cohort_definition_id AS coh_id
  , t1.diag_category_id AS d1
  , t2.diag_category_id AS d2
  FROM @cohort_database_schema.charlson_map t1
  INNER JOIN @cohort_database_schema.charlson_map t2 ON
    t1.subject_id = t2.subject_id
    AND t1.cohort_definition_id = t2.cohort_definition_id
) x
WHERE
  subject_id = x.sub_id
  AND cohort_definition_id = x.coh_id
  AND diag_category_id = 9
  AND x.d1 = 9
  AND x.d2 = 15;

-- Malignancy
UPDATE @cohort_database_schema.charlson_map
SET weight = 0
FROM (
  SELECT
    t1.subject_id AS sub_id
  , t1.cohort_definition_id AS coh_id
  , t1.diag_category_id AS d1
  , t2.diag_category_id AS d2
  FROM @cohort_database_schema.charlson_map t1
  INNER JOIN @cohort_database_schema.charlson_map t2 ON
    t1.subject_id = t2.subject_id
    AND t1.cohort_definition_id = t2.cohort_definition_id
) x
WHERE
  subject_id = x.sub_id
  AND cohort_definition_id = x.coh_id
  AND diag_category_id = 14
  AND x.d1 = 14
  AND x.d2 = 16;
  
  
DROP TABLE IF EXISTS @cohort_database_schema.charlson_incl;
DROP TABLE IF EXISTS @cohort_database_schema.charlson_excl;
